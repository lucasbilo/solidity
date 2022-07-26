// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.7.0 < 0.9.0;

import "./Ownable.sol";

contract Payment is Ownable{

    // funcion pagable
    function pay() public payable returns (uint256){
        return 1;
    }

    // necesito la referencia del balance del smart contract
    function getBalance() public view returns (uint256){
        return address(this).balance;
    }

    // retirar
    function withDraw(address _recipient) public isOwner returns (bool){
        uint256 myBalance = getBalance();
        payable(_recipient).transfer(myBalance);
        return true;
    }
}

