from dhanhq import DhanLogin

dhan_login = DhanLogin("1108497464")
pin = "920420"
totp = "236268"

access_token_data = dhan_login.generate_token(pin, totp)
print(access_token_data)


