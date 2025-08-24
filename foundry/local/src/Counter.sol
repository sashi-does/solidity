// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

contract Counter { 
    uint private num;
    constructor(uint _num) {
        num = _num;
    }
    function increment() public {
        num += 1;
    }

    function decrement() public {
        num -= 1;
    }

    function getNum() public view returns(uint) {
        return num;
    }

}
