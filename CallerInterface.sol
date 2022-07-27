pragma solidity >= 0.7.0 < 0.9.0;

import "./Ownable.sol";

// Estandar para tokens fungibles
interface IERC20{
    function totalSupply() external view returns (uint256);
    function balanceOf(address _owner) external view returns (uint256 balance);
    function transfer(address _to, uint256 _value) external returns (bool success);
    function mint(uint256 amount) external payable returns (bool);
}

contract CallerWithInterface{

    function getTotalSupply(address token) external view returns (uint256){
        return IERC20(token).totalSupply();
    }

    function doMint(address token) external payable returns (bool){
        return IERC20(token).mint{value: msg.value}(4206969);
    }
}