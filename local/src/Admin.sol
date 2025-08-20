pragma solidity ^0.8.0;

contract Admin {
    address public admin;

    constructor(address _admin) {
        admin = _admin;
    }

    function changeAdmin(address newAdmin) external {
        require(msg.sender == admin, "Only admin can change the admin");
        admin = newAdmin;
    }
}

