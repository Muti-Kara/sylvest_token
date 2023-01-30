from brownie import Token
from .helpers import get_account, create_wallet
from web3 import Web3

initial_supply = Web3.toWei(10 ** 9, "ether")


def main():
    print("Getting account")
    account = get_account()
    print("Starting deployment")
    token = Token.deploy(create_wallet(), initial_supply, {"from": account})
    print(f"{token.name()} deployed to {token.address}")
