// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {IRC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20";

contract LockUSDT {
    address private usdt;
    mapping(address => uint256) users;

    constructor(address _address) {
        usdt = _address;
    }

    function deposit(uint256 _amount) public {
        // check in the usdt allowance 
        // whether we are allowed 
        // to use the user's tokens on their behalf
        require(IRC20(usdt).allowance(msg.sender, address(this)) >= _amount);
        IRC20(usdt).transferFrom(msg.sender, address(this), _amount);
        users[msg.sender] += _amount;  
    }

    function withdraw() public {
        uint256 remBalance = users[msg.sender];
        IRC20(usdt).transfer(msg.sender, users[msg.sender]);
        users[msg.sender] = 0;
    }
}
