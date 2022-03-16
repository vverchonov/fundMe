// SPDX-License-Identifier: MIT

pragma solidity 0.8.0;

import "./v3.sol";

contract Fund {

    mapping(address => uint256) public addressToAmount;
    address owner;
    address[] funders;

    constructor(){
        owner = msg.sender;
    }


    function fund() public payable{
        addressToAmount[msg.sender] = msg.value;
        funders.push(msg.sender);
    }


    function getEthPrice() public view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        (,int256 price,,,) = priceFeed.latestRoundData();
        return uint256(price * 10000000000);
    }

    function getUsdAmount(uint256 amount) public view returns(uint256){
        uint256 ethPrice = getEthPrice();
        uint256 usdPrice = (ethPrice * amount) / 1000000000000000000;
        return usdPrice;
    }

    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }

    function withdraw() payable onlyOwner public {
        payable(msg.sender).transfer(address(this).balance);
        for(uint256 indx = 0; indx < funders.length; indx++){
            addressToAmount[funders[indx]] = 0;
        }
        funders = new address[](0);
    }

}