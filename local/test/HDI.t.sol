// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/HDI.sol";
import "forge-std/console.sol";

contract HDI_Test is Test {
    HDI h;
    address _example1 = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    address _example2 = 0x5c6B0f7Bf3E7ce046039Bd8FABdfD3f9F5021678;

    function setUp() public {
        h = new HDI(0);
    }

    function testMint() public {
        h.mint(address(this), 1000);

        assertEq(h.balanceOf(address(this)), 1000, "ok");
        assertEq(h.balanceOf(_example1), 0, "ok");

        console.log(address(this));

        h.mint(_example1, 100);

        assertEq(h.balanceOf(_example1), 100, "ok");
    }

    function testTransfer() public {
        h.mint(address(this), 1000);
        h.transfer(_example1, 500);

        assertEq(h.balanceOf(_example1), 500);
        assertEq(h.balanceOf(address(this)), 500);

        //-> msg.sender will always be the contract address
        //-> so prank() will let us to manipulate the EVM to modfiy the msg.sender
        //-> only for local sol dev
        vm.prank(_example1); //-> changes who the function will call
        h.transfer(msg.sender, 500);

        assertEq(h.balanceOf(_example1), 0);
    }

    function testApproval() public {
        h.mint(address(this), 100);

        assertEq(h.balanceOf(address(this)), 100);

        h.approve(_example1, 50);

        vm.prank(_example1);
        h.transferFrom(address(this), _example1, 25);

        assertEq(h.balanceOf(_example1), 25, "ok");
        assertEq(h.balanceOf(_example2), 0, "ok");
        assertEq(h.balanceOf(address(this)), 75, "ok");
        assertEq(h.allowance(address(this), _example1), 25, "ok");

    }

    function test_RevertMint() public {
        vm.prank(_example1);
        vm.expectRevert();
        h.mint(_example1, 100);
    }

    function test_RevertTransfer() public {
        h.mint(address(this), 100);
        vm.expectRevert();
        h.transfer(_example1, 101);
    }

    function test_RevertApproval() public {
        h.mint(address(this), 100);
        h.approve(_example1, 50);

        vm.prank(_example1);
        vm.expectRevert();
        h.transferFrom(address(this), _example1, 51);
    }

}