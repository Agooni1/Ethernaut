// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IDex {
    function isSold() external view returns (bool);
    function buy() external;
}


contract DexAttacker {
    address public owner;
    IDex public target;
    

    constructor(address _shopAddress){
        owner = msg.sender;
        target = IDex(_shopAddress);
    }

    modifier onlyOwner {
    require(msg.sender == owner);
    _;
    }


    

    function attack() public onlyOwner{
        target.buy();
    }
}