// SPDX-License-Identifier: MIT
pragma solidity  ^0.8.21;

contract ProxyV2 {
    uint256 public num = 1;
    address public version;

    constructor(address _version) {
        version = _version;
    }

    function setVersion(address _version) public {
        version = _version;
    }

    fallback() external { 
        ( bool success, ) = version.delegatecall(msg.data);
        require(success, "Failed");
    }
}

contract V1 {
    uint256 public num = 1;
    
    constructor() {}

    function setNum(uint256 _num) public {
        num = _num;
    }
}

contract V2 {
    uint256 public num = 1;

    function setNum(uint256 _num) public {
        num = _num * 2;
    }
}
