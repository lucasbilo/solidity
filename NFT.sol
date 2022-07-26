// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./Ownable.sol";

contract NFT is Ownable, ERC721 {

    uint256 public immutable MAX_SUPPLY = 10000;
    uint256 public currentSupply = 0;

    // no es recomendable, agrega costo a la coleccion. Hay mejores maneras como firmas
    mapping(address => uint256) max_sells;

    constructor() ERC721("NFTCollection", "NFTC"){}

    function mint(uint256 _id, address _recipient) external isOwner{
        _mint(_recipient, _id);
        currentSupply += 1;
    }

    function publicSale(uint256 _id) external payable{
        require(MAX_SUPPLY >= currentSupply, "Exceeds supply");
        require(max_sells[msg.sender] < 2, "You cannot buy more than 2 nfts");
        require(msg.value == 1 ether, "Incorrect value");
        currentSupply += 1;
        max_sells[msg.sender] += 1;
        _mint(msg.sender, _id);
    }

    function withDraw() external isOwner {
        payable(msg.sender).transfer(address(this).balance);
    }
}