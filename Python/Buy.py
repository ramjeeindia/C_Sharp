
import json
import os
import sys

from dotenv import load_dotenv
from dhanhq import DhanContext, dhanhq


def required(name: str) -> str:
    value = os.getenv(name, "").strip()
    if not value:
        raise RuntimeError(f"Missing {name} in .env")
    return value


def main() -> None:
    load_dotenv()

    client_id = required("DHAN_CLIENT_ID")
    access_token = required("DHAN_ACCESS_TOKEN")
    security_id = required("ORDER_SECURITY_ID")
    exchange_segment = required("ORDER_EXCHANGE_SEGMENT").upper()
    quantity = int(required("ORDER_QUANTITY"))
    order_type = required("ORDER_TYPE").upper()
    product_type = required("ORDER_PRODUCT_TYPE").upper()
    price = float(os.getenv("ORDER_PRICE", "0"))

    if quantity <= 0:
        raise ValueError("ORDER_QUANTITY must be greater than zero.")
    if order_type not in {"MARKET", "LIMIT"}:
        raise ValueError("ORDER_TYPE must be MARKET or LIMIT.")
    # Dhan's REST API calls this INTRADAY; accept the SDK shorthand too.
    if product_type == "INTRA":
        product_type = "INTRADAY"
    if product_type not in {"CNC", "INTRADAY"}:
        raise ValueError("ORDER_PRODUCT_TYPE must be CNC or INTRADAY.")
    if order_type == "LIMIT" and price <= 0:
        raise ValueError("A LIMIT order needs ORDER_PRICE greater than zero.")

    print("\nBUY ORDER REVIEW")
    print(f"Security ID: {security_id}")
    print(f"Exchange:    {exchange_segment}")
    print(f"Quantity:    {quantity}")
    print(f"Order type:  {order_type}")
    print(f"Product:     {product_type}")
    print(f"Price:       {price}")

    confirmation = input("\nType B to submit, or press Enter to cancel: ").strip()
    if confirmation != "B":
        print("No order was sent.")
        return

    dhan = dhanhq(DhanContext(client_id, access_token))

    exchange_constants = {
        "NSE_EQ": dhan.NSE,
        "NSE_FNO": dhan.NSE_FNO,
    }
    product_constants = {
        "CNC": dhan.CNC,
        "INTRADAY": dhan.INTRA,
    }

    if exchange_segment not in exchange_constants:
        raise ValueError("This sample supports NSE_EQ and NSE_FNO only.")

    response = dhan.place_order(
        security_id=security_id,
        exchange_segment=exchange_constants[exchange_segment],
        transaction_type=dhan.BUY,
        quantity=quantity,
        order_type=dhan.MARKET if order_type == "MARKET" else dhan.LIMIT,
        product_type=product_constants[product_type],
        price=price,
    )

    print("\nDhan response:")
    print(json.dumps(response, indent=2, default=str))

    if response.get("status") == "success":
        print("Buy order submitted successfully.")
    else:
        print("Buy order was rejected or not accepted. Review the response above.")
        sys.exit(1)


if __name__ == "__main__":
    main()
