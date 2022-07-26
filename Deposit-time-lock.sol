// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.7.0 < 0.9.0;

import "./Ownable.sol";

contract DepositTimeLocked is Ownable{

    mapping(address => uint256) balances;
    mapping(address => uint256) lockUntil;

    function deposit() public payable returns (bool){
        // https://gwei.io/
        // 1 ether == 1 000 000 000 000 000 000 000 000 wei
        // 1 ether == 1 000 000 000 gwei
        require(msg.value >= 1 ether, "Balance insuficiente, porfavor envie mas ether");
        balances[msg.sender] += msg.value;
        lockUntil[msg.sender] += block.timestamp + 1 minutes;
        return true;
    }

    function getBalance() public view returns (uint256){
        return address(this).balance;
    }

    function withDraw() public{
        require(block.timestamp > lockUntil[msg.sender], "Lo siento, no paso el tiempo suficiente para retirar");
        require(balances[msg.sender] > 0, "Su balances es 0");
        // Por seguridad, hay que setear en 0 el balance antes de hacer la transferencia
        uint256 amountToTransfer = balances[msg.sender];
        balances[msg.sender] = 0;
        payable(msg.sender).transfer(amountToTransfer);
    }

    function withDrawAll(address _recipient) public isOwner returns (bool){
        uint256 myBalance = getBalance();
        payable(_recipient).transfer(myBalance);
        return true;
    }
}