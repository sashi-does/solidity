pragma solidity ^0.8.0;

contract Deposit {
    uint256 public minimumDeposit = 1 ether;

    function deposit() external payable {
        require(msg.value >= minimumDeposit, "Deposit is below minimum");
    }
}
