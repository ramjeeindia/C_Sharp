import json
import math
import os
import time

from dotenv import load_dotenv
from dhanhq import DhanContext, dhanhq


# ============================================================
# CONFIGURATION
# ============================================================

# OPTION / F&O CONTRACT TO BUY
SECURITY_ID = "56980"
EXCHANGE_SEGMENT = "NSE_FNO"

# Quantity of the option contract
QUANTITY = 65

# NIFTY 50 SPOT SECURITY ID
#
# IMPORTANT:
# Verify this against Dhan's current instrument/security master.
# This must be the NIFTY 50 SPOT instrument, NOT SECURITY_ID above.
NIFTY_SPOT_SECURITY_ID = "13"
NIFTY_SPOT_SEGMENT = "NSE_IDX"

# Trigger every 50 NIFTY points
TRIGGER_INTERVAL = 50

# Profit / loss monitoring after entry
PROFIT_TARGET = 500.0
LOSS_LIMIT = 300.0

# Dhan market quote API limit is 1 request/sec.
POLL_SECONDS = 1.0


# ============================================================
# ENVIRONMENT
# ============================================================

def required(name: str) -> str:
    value = os.getenv(name, "").strip()

    if not value:
        raise RuntimeError(f"Missing {name} in .env")

    return value


# ============================================================
# HELPERS
# ============================================================

def number(value, default=0.0) -> float:
    try:
        if value in (None, ""):
            return default

        return float(value)

    except (TypeError, ValueError):
        return default


def get_nifty_ltp(client: dhanhq) -> float:
    """
    Fetch NIFTY 50 spot LTP from Dhan.

    Dhan's ticker_data() returns market LTP data.
    """

    response = client.ticker_data(
        {
            NIFTY_SPOT_SEGMENT: [
                int(NIFTY_SPOT_SECURITY_ID)
            ]
        }
    )

    if response.get("status") == "failure":
        raise RuntimeError(
            "Failed to fetch NIFTY LTP:\n"
            + json.dumps(response, indent=2, default=str)
        )

    data = response.get("data", {})

    segment_data = data.get(NIFTY_SPOT_SEGMENT, {})

    instrument = segment_data.get(
        str(NIFTY_SPOT_SECURITY_ID)
    )

    if instrument is None:
        # Some responses/SDK versions may return integer keys.
        instrument = segment_data.get(
            NIFTY_SPOT_SECURITY_ID
        )

    if instrument is None:
        raise RuntimeError(
            "NIFTY 50 Security ID was not found in Dhan response:\n"
            + json.dumps(response, indent=2, default=str)
        )

    ltp = number(instrument.get("last_price"))

    if ltp <= 0:
        raise RuntimeError(
            f"Invalid NIFTY LTP received: {ltp}"
        )

    return ltp


def trigger_level(ltp: float) -> int:
    """
    Return the 50-point level at or immediately below LTP.

    Examples:

        23499 -> 23450
        23500 -> 23500
        23512 -> 23500
        23549 -> 23500
        23550 -> 23550
    """

    return math.floor(ltp / TRIGGER_INTERVAL) * TRIGGER_INTERVAL


def matching_position(client: dhanhq) -> dict | None:
    response = client.get_positions()

    positions = (
        response
        if isinstance(response, list)
        else response.get("data", [])
    )

    for position in positions:

        if str(position.get("securityId")) != SECURITY_ID:
            continue

        if position.get("exchangeSegment") != EXCHANGE_SEGMENT:
            continue

        if number(position.get("netQty")) > 0:
            return position

    return None


# ============================================================
# BUY ORDER
# ============================================================

def place_market_buy(client: dhanhq, trigger_level_value: int):
    print()
    print("=" * 60)
    print("NIFTY 50 TRIGGER REACHED")
    print("=" * 60)

    print(f"Trigger level : {trigger_level_value}")
    print(f"Security ID   : {SECURITY_ID}")
    print(f"Quantity      : {QUANTITY}")
    print("Order type    : MARKET")
    print("Product       : INTRADAY")
    print("=" * 60)

    response = client.place_order(
        security_id=SECURITY_ID,
        exchange_segment=client.NSE_FNO,
        transaction_type=client.BUY,
        quantity=QUANTITY,
        order_type=client.MARKET,
        product_type=client.INTRA,
        price=0,
        tag=f"nifty-{trigger_level_value}",
    )

    print("BUY order response:")
    print(json.dumps(response, indent=2, default=str))

    if response.get("status") == "failure":
        raise RuntimeError(
            "Dhan rejected the BUY order. "
            "Check the response above."
        )

    return response


# ============================================================
# EXIT
# ============================================================

def exit_position(client: dhanhq, position: dict) -> None:
    quantity = int(number(position.get("netQty")))

    if quantity <= 0:
        print("No long position remains to exit.")
        return

    response = client.place_order(
        security_id=SECURITY_ID,
        exchange_segment=client.NSE_FNO,
        transaction_type=client.SELL,
        quantity=quantity,
        order_type=client.MARKET,
        product_type=client.INTRA,
        price=0,
        tag="nifty-pnl-exit",
    )

    print("Exit-order response:")
    print(json.dumps(response, indent=2, default=str))

    if response.get("status") == "failure":
        raise RuntimeError(
            "Dhan rejected the exit order. "
            "Check the response above immediately."
        )


# ============================================================
# POSITION MONITOR
# ============================================================

def monitor_until_exit(client: dhanhq) -> None:

    print()
    print(
        f"Monitoring Security ID {SECURITY_ID} "
        "for automatic exit..."
    )

    while True:

        position = matching_position(client)

        if position is None:
            print("Waiting for BUY position to appear...")
            time.sleep(POLL_SECONDS)
            continue

        realized = number(
            position.get("realizedProfit")
        )

        unrealized = number(
            position.get("unrealizedProfit")
        )

        pnl = realized + unrealized

        print(
            f"P&L: ₹{pnl:.2f} | "
            f"target: ₹{PROFIT_TARGET:.2f} | "
            f"loss limit: ₹{LOSS_LIMIT:.2f}"
        )

        if pnl >= PROFIT_TARGET:

            print(
                "PROFIT TARGET reached. "
                "Submitting market exit..."
            )

            exit_position(client, position)
            return

        if pnl <= -LOSS_LIMIT:

            print(
                "LOSS LIMIT reached. "
                "Submitting market exit..."
            )

            exit_position(client, position)
            return

        time.sleep(POLL_SECONDS)


# ============================================================
# NIFTY TRIGGER MONITOR
# ============================================================

def monitor_nifty_and_buy(client: dhanhq) -> None:

    print()
    print("=" * 60)
    print("NIFTY 50 AUTO-ENTRY MONITOR")
    print("=" * 60)

    print(
        f"Watching NIFTY 50 Security ID : "
        f"{NIFTY_SPOT_SECURITY_ID}"
    )

    print(
        f"Trigger interval               : "
        f"{TRIGGER_INTERVAL} points"
    )

    print(
        f"Option Security ID             : "
        f"{SECURITY_ID}"
    )

    print(
        f"BUY quantity                   : "
        f"{QUANTITY}"
    )

    print("Waiting for a 50-point NIFTY level...")
    print("=" * 60)

    previous_ltp = None
    previous_level = None

    while True:

        try:

            ltp = get_nifty_ltp(client)

            current_level = trigger_level(ltp)

            print(
                f"NIFTY LTP: {ltp:.2f} | "
                f"Current 50-point level: {current_level}"
            )

            # First valid tick establishes our baseline.
            #
            # This prevents the program from immediately buying
            # simply because it was started while NIFTY was already
            # sitting at a 50-point level.
            if previous_ltp is None:

                previous_ltp = ltp
                previous_level = current_level

                print(
                    f"Initial NIFTY level = {current_level}. "
                    "Waiting for the next level crossing..."
                )

                time.sleep(POLL_SECONDS)
                continue

            # Detect movement into a NEW 50-point bucket.
            if current_level != previous_level:

                if current_level > previous_level:

                    print(
                        f"NIFTY crossed upward: "
                        f"{previous_level} -> {current_level}"
                    )

                    # BUY only once for this level.
                    place_market_buy(
                        client,
                        current_level
                    )

                    # Once the order is submitted, start
                    # monitoring its position.
                    monitor_until_exit(client)

                    return

                else:

                    print(
                        f"NIFTY moved downward: "
                        f"{previous_level} -> {current_level}"
                    )

            previous_ltp = ltp
            previous_level = current_level

            time.sleep(POLL_SECONDS)

        except KeyboardInterrupt:

            print()
            print("Monitor stopped by user.")
            return

        except Exception as exc:

            print()
            print("ERROR while monitoring NIFTY:")
            print(exc)
            print()

            # Don't hammer the API if a temporary error occurs.
            time.sleep(POLL_SECONDS)


# ============================================================
# MAIN
# ============================================================

def main() -> None:

    load_dotenv()

    client = dhanhq(
        DhanContext(
            required("DHAN_CLIENT_ID"),
            required("DHAN_ACCESS_TOKEN")
        )
    )

    print()
    print("=" * 60)
    print("NIFTY 50 AUTOMATIC ENTRY SYSTEM")
    print("=" * 60)

    print(
        f"Option Security ID : {SECURITY_ID}"
    )

    print(
        f"Exchange            : {EXCHANGE_SEGMENT}"
    )

    print(
        f"Quantity            : {QUANTITY}"
    )

    print(
        f"NIFTY trigger       : Every {TRIGGER_INTERVAL} points"
    )

    print(
        f"Profit target       : ₹{PROFIT_TARGET:.2f}"
    )

    print(
        f"Loss limit          : ₹{LOSS_LIMIT:.2f}"
    )

    print(
        f"Polling             : {POLL_SECONDS:.1f}s"
    )

    print("=" * 60)

    monitor_nifty_and_buy(client)


if __name__ == "__main__":
    main()