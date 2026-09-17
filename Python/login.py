import os
from dotenv import load_dotenv
load_dotenv()
from dhanhq import DhanLogin


def generate_access_token() -> str:
    client_id = os.environ["DHAN_CLIENT_ID"]
    api_key = os.environ["DHAN_APP_ID"]
    api_secret = os.environ["DHAN_APP_SECRET"]
    token_id = os.getenv("DHAN_TOKEN_ID", "").strip()

    dhan_login = DhanLogin(client_id)

    if not token_id:
        dhan_login.generate_login_session(api_key, api_secret)
        raise RuntimeError(
            "Complete browser login, save tokenId in .env as DHAN_TOKEN_ID, then run again."
        )

    response = dhan_login.consume_token_id(token_id, api_key, api_secret)

    access_token = response.get("accessToken")
    if not access_token:
        raise RuntimeError(f"Access token was not returned: {response}")

    return access_token


if __name__ == "__main__":
    print("Dhan login succeeded.")
   