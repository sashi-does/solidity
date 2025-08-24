// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Deposit.sol";

contract DepositContract is Test {
    Deposit D;

    function setUp() public {
        D = new Deposit();
    }

    function testDeposit() public {
        vm.deal(address(msg.sender), 2 ether);
        D.deposit{value: 2 ether}();
    }

    function test_RevertDeposit() public {
        vm.deal(address(msg.sender), 0.2 ether);
        vm.expectRevert("Deposit is below minimum");
        D.deposit{value: 0.2 ether}();
    }
    
}
