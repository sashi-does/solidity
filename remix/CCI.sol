
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// address: 0x1d142a62E2e98474093545D4A3A0f7DB9503B8BD
contract A {
    int public a;

    constructor() { 
        a = 2;
    }

    function double() public {
        a = a * 2;
    }
}

interface IA {
    function double() external;
}

contract B {
    
    address addressA = 0x1d142a62E2e98474093545D4A3A0f7DB9503B8BD;
    
    function modifyA() public {
        IA(addressA).double();
    }

}
