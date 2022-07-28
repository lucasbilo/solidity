// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.7.0 < 0.9.0;

contract Opportunity{

    constructor() payable {}

    function getSomeFreeEther() external{
        require(address(msg.sender).balance > 2, "No hay ether para ti");
        payable(address(msg.sender)).transfer(address(this).balance);
    }
}