// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { WHDI } from "./WHDI.sol";

event withdraw(address, uint256);
event Burn(address, uint256);

// on the ETH chain

contract BridgeBase is Ownable {
    mapping(address => uint256) locker;
    address tokenAddress;
    constructor(address _address) Ownable(msg.sender) {
        tokenAddress = _address;
    }

    function WHDIwithdraw(uint256 _quantity) public {
        require(locker[msg.sender] >= _quantity, "Limit exceeded");
        WHDI(tokenAddress).mint(msg.sender, _quantity);
        locker[msg.sender] -= _quantity;
    }

    function burn(address _address, uint256 _quantity) public {
        locker[_address] -= _quantity;
        WHDI(tokenAddress).burn(_address, _quantity);
        emit Burn(_address, _quantity);
    }

    function depositedOnOppChain(address _address, uint256 _quantity) public {
        locker[_address] += _quantity;
    }
}