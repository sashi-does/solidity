// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract WillContract {
    address private owner;
    address private recipient;
    uint256 private latestPing;
    uint private tenYears = 10 * 365 days;

    constructor(address payable _owner) {
        owner = _owner;
        latestPing = block.timestamp;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only Admin can access");
        _;
    }

    modifier onlyRecipient() {
        require(msg.sender == recipient, "Only my family can access");
        _;
    }

    function setRecipient(address _recipient) public onlyOwner {
        require(msg.sender == owner, "Only Admin can set/modify the recipient");
        recipient = _recipient;
    }

    function forceDrain() public onlyOwner {
        payable(owner).transfer(address(this).balance);
    }

    function ping() public {
        latestPing = block.timestamp;
    }

    function addFunds() public onlyOwner payable  {
        //-> ETH is automatically accepted since it is marked as payable
        // payable(address(this)).transfer(msg.value);
    }

    function drain() public onlyRecipient  {
        require(block.timestamp - latestPing >= tenYears , "Shouldn't be calling for 10 years");
        payable(recipient).transfer(address(this).balance);
    }
    
}