from brownie import Fund
from scripts.support import getAccount
import os
os.getenv("WEB3_INFURA_PROJECT_ID")


def deploy():
    account = getAccount()
    fund = Fund.deploy({"from": account})


def main():
    deploy()
