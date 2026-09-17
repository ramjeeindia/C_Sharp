"""Read-only lookup for tradable NIFTY call-option contracts in Dhan's live master."""

import argparse
import csv
import io
from decimal import Decimal, InvalidOperation

import requests

MASTER_URL = "https://images.dhan.co/api-data/api-scrip-master.csv"


def numeric(value: str) -> Decimal:
    try:
        return Decimal(value.strip())
    except (InvalidOperation, AttributeError) as error:
        raise ValueError(f"Invalid strike value: {value!r}") from error


def matches_strike(raw_strike: str, requested: Decimal) -> bool:
    """Dhan master versions may express strike in rupees or paise."""
    try:
        raw = numeric(raw_strike)
    except ValueError:
        return False

    return any(raw / scale == requested for scale in (1, 100, 1_000, 10_000))


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Find NIFTY CE contracts in Dhan's current instrument master."
    )
    parser.add_argument("--strike", type=numeric, default=Decimal("23200"))
    parser.add_argument(
        "--expiry",
        help="Optional expiry text exactly as shown in the output; omit to list every expiry.",
    )
    args = parser.parse_args()

    response = requests.get(MASTER_URL, timeout=60)
    response.raise_for_status()
    rows = csv.DictReader(io.StringIO(response.content.decode("utf-8-sig")))

    matches = []
    candidates = []
    for row in rows:
        if row.get("SEM_EXM_EXCH_ID", "").strip() != "NSE":
            continue
        if row.get("SEM_SEGMENT", "").strip() != "D":
            continue
        if row.get("SEM_INSTRUMENT_NAME", "").strip() != "OPTIDX":
            continue
        if row.get("SEM_OPTION_TYPE", "").strip() != "CE":
            continue
        # Dhan may label the underlying as NIFTY, NIFTY 50, or only in custom symbol.
        underlying = " ".join(
            (
                row.get("SM_SYMBOL_NAME", ""),
                row.get("SEM_CUSTOM_SYMBOL", ""),
                row.get("SEM_TRADING_SYMBOL", ""),
            )
        ).upper()
        if "NIFTY" not in underlying:
            continue

        candidates.append(row)

        if not matches_strike(row.get("SEM_STRIKE_PRICE", ""), args.strike):
            continue

        expiry = row.get("SEM_EXPIRY_DATE", "").strip()
        if args.expiry and args.expiry.casefold() != expiry.casefold():
            continue

        matches.append(row)

    if not matches:
        print("No matching contract found for that strike/expiry.")
        print("\nSample NIFTY CE rows found in the current master:")
        print("Expiry | Raw strike | Security ID | Lot size | Trading symbol")
        print("-" * 100)
        for row in sorted(candidates, key=lambda item: item.get("SEM_EXPIRY_DATE", ""))[:30]:
            print(
                f"{row.get('SEM_EXPIRY_DATE', '').strip()} | "
                f"{row.get('SEM_STRIKE_PRICE', '').strip()} | "
                f"{row.get('SEM_SMST_SECURITY_ID', '').strip()} | "
                f"{row.get('SEM_LOT_UNITS', '').strip()} | "
                f"{row.get('SEM_TRADING_SYMBOL', '').strip()}"
            )
        return

    print("\nExpiry | Security ID | Lot size | Trading symbol")
    print("-" * 80)
    for row in sorted(matches, key=lambda item: item.get("SEM_EXPIRY_DATE", "")):
        print(
            f"{row.get('SEM_EXPIRY_DATE', '').strip()} | "
            f"{row.get('SEM_SMST_SECURITY_ID', '').strip()} | "
            f"{row.get('SEM_LOT_UNITS', '').strip()} | "
            f"{row.get('SEM_TRADING_SYMBOL', '').strip()}"
        )

    print("\nCopy one matching Security ID and lot size into .env. This program does not place orders.")


if __name__ == "__main__":
    main()
