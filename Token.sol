// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.7.0 < 0.9.0;

import "./Ownable.sol";

// Estandar para tokens fungibles
interface IERC20{
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
    function totalSupply() external view returns (uint256);
    function balanceOf(address _owner) external view returns (uint256 balance);
    function transfer(address _to, uint256 _value) external returns (bool success);
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success);
    function approve(address _spender, uint256 _value) external returns (bool success);
    function allowance(address _owner, address _spender) external view returns (uint256 remaining);
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

}

contract myToken is IERC20, Ownable{

    string public override name = "LucasCoin";
    string public override symbol = "LC";
    uint8 public override decimals = 18;
    
    uint256 supply;
    mapping(address => uint256) public balances;

    mapping(address => mapping(address => uint256)) _allowance;

    function allowance(address _owner, address _spender) public override view returns (uint256){
        return _allowance[_owner][_spender];
    }

    function approve(address _spender, uint256 _value) external returns (bool success){
        _allowance[msg.sender][_spender] += _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function totalSupply() public override view returns (uint256){
        return supply;
    }

    function balanceOf(address _owner) public override view returns (uint256 balance){
        return balances[_owner];
    }

    function transfer(address _to, uint256 _value) public returns (bool success){
        require(balances[msg.sender] >= _value, "Balance insuficiente");
        require(balances[_to] + _value > balances[_to], "Overflow");
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success){
        require(_allowance[_from][msg.sender] >= _value, "Not allowed");
        require(balances[_from] >= _value, "Balance insuficiente");
        require(balances[_to] + _value > balances[_to], "Overflow");
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        _allowance[_from][msg.sender] -= _value;
        return true;
    }

    function mintAsOwner(uint256 _value) external isOwner{
        balances[msg.sender] += _value * 10 ether;
        supply += _value * 10 ether; 
    }

    function mint() external payable{
        require(msg.value >= 1 ether, "1 ether es lo minimo");
        balances[msg.sender] += 10 ether * msg.value;
        supply += 10 ether * msg.value;
    }
   
}