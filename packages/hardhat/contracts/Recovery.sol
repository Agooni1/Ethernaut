// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

interface ISimpleToken {
    function destroy(address payable _to) external;
}

contract RecoveryHelper is Ownable {

    constructor(address _initialOwner) Ownable(_initialOwner) {
        
    }
    function recover(address tokenAddress, address payable recipient) external onlyOwner(){
        ISimpleToken(tokenAddress).destroy(recipient);
    }
}