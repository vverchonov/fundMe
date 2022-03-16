from brownie import accounts, network
import os


def getAccount():
    if network.show_active() == "development":
        return accounts[0]
    else:
        return accounts.add(os.getenv("PRIVATE_KEY"))
