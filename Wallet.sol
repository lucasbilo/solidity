// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Wallet{

    event Log(string message);

    fallback() external payable{
        if(msg.value > 0){
            emit Log("Se llamo a 'Fallback' y Ether fue depositado");
        } else{
            emit Log("Se llamo a 'Fallback'");
        }
    }

    receive() external payable{
        if(msg.value > 0){
            emit Log("Se llamo a 'Receive' y Ether fue depositado");
        } else{
            emit Log("Se llamo a 'Receive'");
        }
    }

    function deposit() external payable{
        emit Log("Deposit function has been called");
    }

    function getBalance() external view returns (uint256){
        return address(this).balance;
    }

    function withDraw() external{
        msg.sender.call{value: address(this).balance}('');
    }
}

//                      primeros 4 bytes de "msg.data" vacios?
//                              /               \
//                             si                no
//                            /                    \  
//                   receive() existe?       esta el "function selector" de deposit?
//                   /            \             /                   \ 
//                 si              no         no                     si           
//                 /                \         /                        \
//             receive()            fallback()                        deposit()
//