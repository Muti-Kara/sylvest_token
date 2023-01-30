from brownie import accounts, config
import secrets
import json


def get_account():
    owner = accounts.add(config["wallets"]["from_key"])
    print("==================================================")
    print(f"Address of the owner {owner.address}")
    print("==================================================")
    return owner


def create_wallet():
    private_key = secrets.token_hex(32)
    wallet = accounts.add(private_key=private_key)
    wallet_dict: dict = {
        "address": wallet.address,
        "key": f"0x{private_key}"
    }
    with open("wallet.json", "w") as file:
        json.dump(wallet_dict, file)
    print("==================================================")
    print(f"Address of the wallet {wallet.address}")
    print("=================================================")
    return wallet.address
