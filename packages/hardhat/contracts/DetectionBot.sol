// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IDetectionBot {
    function handleTransaction(address user, bytes calldata msgData) external;
}
interface IForta {
    function raiseAlert(address user) external;
}

import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";

contract DetectionBot is IDetectionBot, Ownable {
    address public vault;

    constructor(address _owner, address _vault) Ownable(_owner){
        vault = _vault;
    }

/* calldata layout
| calldata offset | length | element                                | type    | example value                                                      |
|-----------------|--------|----------------------------------------|---------|--------------------------------------------------------------------|
| 0x00            | 4      | function signature (handleTransaction) | bytes4  | 0x220ab6aa                                                         |
| 0x04            | 32     | user                                   | address | 0x000000000000000000000000XxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXx |
| 0x24            | 32     | offset of msgData                      | uint256 | 0x0000000000000000000000000000000000000000000000000000000000000040 |
| 0x44            | 32     | length of msgData                      | uint256 | 0x0000000000000000000000000000000000000000000000000000000000000064 |
| 0x64            | 4      | function signature (delegateTransfer)  | bytes4  | 0x9cd1a121                                                         |
| 0x68            | 32     | to                                     | address | 0x000000000000000000000000XxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXx |
| 0x88            | 32     | value                                  | uint256 | 0x0000000000000000000000000000000000000000000000056bc75e2d63100000 |
| 0xA8            | 32     | origSender                             | address | 0x000000000000000000000000XxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXx |
| 0xC8            | 28     | padding                                | bytes   | 0x00000000000000000000000000000000000000000000000000000000         |
*/

    function handleTransaction(address user, bytes calldata) external override {
        address to;
        uint256 value;
        address origSender;

        //decode msg params
        assembly {
            to := calldataload(0x68)
            value := calldataload(0x88)
            origSender := calldataload(0xA8)
        }

        if (origSender == vault) {
            IForta(msg.sender).raiseAlert(user);
        }
    }

    function setVault(address _vault) public onlyOwner {
        vault = _vault;
    }
}