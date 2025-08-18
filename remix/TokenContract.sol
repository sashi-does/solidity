pragma solidity ^0.8.26;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenContract is ERC20  {
    constructor(uint256 initialSupply) ERC20("Heidi", "HDI") {
        _mint(msg.sender, initialSupply);
    }
}