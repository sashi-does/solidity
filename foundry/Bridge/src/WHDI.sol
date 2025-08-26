// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

contract WHDI is ERC20, Ownable {
    constructor(address _owner) ERC20("Wrapped Heidi", "WHDI") Ownable(msg.sender) {}

    function mint(uint256 _quantity) public onlyOwner {
        _mint(msg.sender, _quantity);
    }

    function burn(uint256 _quantity) public onlyOwner {
        _burn(msg.sender, _quantity);
    }
}