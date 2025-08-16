// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

// H-Coin Contract
contract Heidi {
    address public ownerAddress;
    mapping(address => uint256) balances;
    uint256 public totalSupply;
    string public coinName;
    string public coinSymbol;
    mapping(address => mapping(address => uint256)) allowances;

    constructor(address _ownerAddress, string memory _coinName, string memory _coinSymbol) {
        ownerAddress = _ownerAddress;
        balances[_ownerAddress] = 0;
        coinName = _coinName;
        coinSymbol = _coinSymbol;
        totalSupply = 0;
    }

    modifier isOwner {
        require(ownerAddress == msg.sender, "Only the owner can call this function");
        _;
    }

    function mintTo(address _to, uint256 _amount) public isOwner {
        balances[_to] += _amount;
        totalSupply += _amount;
    }

    function burn(uint256 _amount) public  {
        require(_amount <= balances[msg.sender], "Insufficient Balance" );
        balances[msg.sender] -= _amount;
        totalSupply -= _amount;
    }

    function mint(uint256 _amount) public isOwner {
        balances[ownerAddress] += _amount;
        totalSupply += _amount;
    }

    function mintTokens(uint256 _amount) public isOwner {
        balances[ownerAddress] += _amount;
        totalSupply += _amount;
    }

    function balance() public view returns (uint256) {
        return balances[msg.sender];
    }

    function transferFrom(address _from, address _to, uint256 _value) public {
        require(_value <=  allowances[_from][msg.sender], "Not allowed to spend more than the allowance" );
        require(_value <= balances[_from], "Insufficient Balance");

        balances[_from] -= _value;
        balances[_to] += _value;
        allowances[_from][msg.sender] -= _value;
    }


    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowances[msg.sender][_spender] = _value;
        return true;
    }

}
