pragma solidity ^0.8.0;
interface IDetectionBot {
    function handleTransaction(address user, bytes calldata msgData) external;
}
interface IForta {
    function raiseAlert(address user) external;
}

//it was balance thing dont need this though is correct as well and may even be simpler/easier to understand
contract DetectionBot2 is IDetectionBot {
// handleTransaction is called by Forta.notify(player, msg.data)
address public origSender;
address public cryptoVault;
    function handleTransaction(address user, bytes calldata msgData) override external {
    // see the explanatory note preceding this code block to understand this like
        (,,origSender) = abi.decode(msgData[4:], (address, uint256, address));
        // If the origSender is cryptoVault contract
        if (origSender == address(cryptoVault))  {
        // call Forta.raiseAlert()
            IForta(msg.sender).raiseAlert(user);
        }
    }
    function setVault(address vault) public {
        cryptoVault = vault;
    }
}