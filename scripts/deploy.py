import imp
from brownie import fund

from scripts.supporting import getAccount


def deploy():
    account = getAccount()
    fund = fund.deploy({"from": account})


def main():
    deploy()
