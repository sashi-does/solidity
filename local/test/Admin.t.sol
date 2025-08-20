// 1. **Use `prank`** to impersonate the `admin` address and call 
// `changeAdmin` to change the admin to a new address. Ensure this succeeds.
// 2. **Use `prank`** to impersonate a non-admin address and call `changeAdmin`.
//  Ensure this fails with the correct error message 
// (i.e., "Only admin can change the admin").

pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/Admin.sol";

contract AdminContract is Test {

    Admin a;
    address _admin = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    address _prank = 0x5c6B0f7Bf3E7ce046039Bd8FABdfD3f9F5021678;

    function setUp() public {
        a = new Admin(_admin);
    }

    function testAdmin() public {
        vm.prank(_admin);
        a.changeAdmin(_prank);
    }

    function test_RevertAdmin() public {
        vm.prank(_prank);
        vm.expectRevert("Only admin can change the admin");
        a.changeAdmin(_prank);
    }
}