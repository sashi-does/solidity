// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

event Deposit(address, uint256);

// on the ETH chain
contract BridgeETH is Ownable {
    // below is for generic tracking of all the tokens
    // mapping(address => mapping(string => uint256)) locker;
    // but we are doing this bridge only for HDI token
    mapping(address => uint256) pendingBalances;
    address public tokenAddress;
    constructor(address _tokenAddress) Ownable(msg.sender) {
        tokenAddress = _tokenAddress;
    }

    // unlock
    function withdraw(IERC20 _tokenAddress, uint256 _quantity) public {
        require(address(_tokenAddress) == tokenAddress, "Non HDI tokens can't be unlocked");
        require(pendingBalances[msg.sender] >= _quantity, "Quantity requested exceeds the user's pending balances");
        _tokenAddress.transfer(msg.sender, _quantity);
        pendingBalances[msg.sender] -= _quantity;
    }

    // lock
    function deposit(IERC20 _tokenAddress, uint256 _quantity) public {
        require((address(_tokenAddress)) == tokenAddress, "Non HDI tokens can't be locked");
        require(_tokenAddress.allowance(msg.sender, address(this)) >= _quantity, "Allowance should be set");
        require(_tokenAddress.transferFrom(msg.sender, address(this), _quantity), "Allowance is not yet set");
        emit Deposit(msg.sender, _quantity);
    }

    function burnedOnOtherChain(address _address, address _tokenAddress, uint256 _quantity) private onlyOwner {
        require((address(_tokenAddress)) == tokenAddress, "Non HDI tokens can't be locked");
        pendingBalances[_address] += _quantity;
    }
}