// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// https://github.com/OpenZeppelin/openzeppelin-contracts
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./Ownable.sol";

contract DemoToken is ERC20, Ownable {
    constructor() ERC20("DemoToken", "DT") {
    }

    function mint(uint256 amount) external payable returns (bool){
        require(msg.value > 200, "Insuficient balance");
        _mint(msg.sender, amount);
        return true;
    }

    event Log(string message);
    bool public wasCalled = false;
    fallback() external{
        emit Log("Se llamo a fallback");
        wasCalled = true;
    }

    //function _beforeTokenTransfer(address from, address to, uint256 amount) internal override {
    //    _transfer(from, devAddress, amount/100);
    //}
}