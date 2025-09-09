// SPDX-License-Identifier: MIT
pragma solidity  ^0.8.21;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract Proxy is Ownable {

    // num is at slot 1. since ownable has owner variable at slot 0
    uint256 public num = 1;
    address implementation;

    constructor(address _implementation) Ownable(msg.sender) {
        implementation = _implementation;
    }

    // delegates call to the other contract
    function setNum(uint256 _num) public {
        // num is at slot 1
        (bool success, ) = implementation.delegatecall(
            abi.encodeWithSignature("setNum(uint256)", _num)
        );
        require(success, "Delegatecall failed");
    }

    function changeModifier(address _implementation) public {
        implementation = _implementation;
    }

}

contract ImplementationV1 {
    
    // owner is added to make sure that num is at slot 1
    address owner;
    uint256 public num = 1;

    constructor() {}

    function setNum(uint256 _num) public {
        // num is at slot 0 if owner isn't here
        num = _num;
    }
}

contract ImplementationV2 {

    // owner is added to make sure that num is at slot 1
    address owner;
    uint256 public num = 1;
    

    constructor() {}

    function setNum(uint256 _num) public {
        // num is at slot 1
        num = _num * 4;
    }
}
