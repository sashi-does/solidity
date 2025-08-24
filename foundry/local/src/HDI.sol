// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract HDI is ERC20 {
    address private owner;
    constructor(uint256 _initialValue) ERC20("Heidi", "HDI") {
        _mint(msg.sender, _initialValue);
        owner = msg.sender;
    }

    function mint(address to, uint256 amount) public {
        require(msg.sender == owner, "Must be the owner");
        _mint(to, amount);
    }

    function test() public {

    }
}