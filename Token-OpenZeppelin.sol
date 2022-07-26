// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// https://github.com/OpenZeppelin/openzeppelin-contracts
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./Ownable.sol";

contract LBToken is ERC20, Ownable {
    constructor() ERC20("LBToken", "LBT") {
    }

    function mint(uint256 amount) external isOwner{
        _mint(msg.sender, amount);
    }

    //function _beforeTokenTransfer(address from, address to, uint256 amount) internal override {
    //    _transfer(from, devAddress, amount/100);
    //}
}