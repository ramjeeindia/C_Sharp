import json
import os

from dotenv import load_dotenv
from dhanhq import DhanContext, dhanhq

load_dotenv()


def required(name: str) -> str:
    value = os.getenv(name, "").strip()

    if not value:
        raise RuntimeError(f"Missing {name} in .env")

    return value


client_id = required("DHAN_CLIENT_ID")
access_token = required("DHAN_ACCESS_TOKEN")

context = DhanContext(client_id, access_token)
dhan = dhanhq(context)

try:
    funds = dhan.get_fund_limits()
    holdings = dhan.get_holdings()
    positions = dhan.get_positions()

    print("\n=== FUND LIMITS ===")
    print(json.dumps(funds, indent=2, default=str))

    print("\n=== HOLDINGS / PORTFOLIO ===")
    print(json.dumps(holdings, indent=2, default=str))

    print("\n=== TODAY'S OPEN POSITIONS ===")
    print(json.dumps(positions, indent=2, default=str))

except Exception as error:
    print(f"Could not fetch Dhan portfolio data: {error}")