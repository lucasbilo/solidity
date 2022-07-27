// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

contract MerkleTree{
    // https://www.npmjs.com/package/merkletreejs
    bytes32 MERKLETREE_HASH_ROOT = 0x123;
    uint256 magicNumber;

    function setHashRoot(bytes32 _newhashroot) public {
        MERKLETREE_HASH_ROOT = _newhashroot;
    }

    modifier allowed(bytes32[] calldata proof){
        bytes32 leaf = keccak256(abi.encodePacked(msg.sender));
        bool isAllowed = MerkleProof.verify(proof, MERKLETREE_HASH_ROOT, leaf);
        require(isAllowed, "Your are not allowed");
        _;
    }

    function saveNumber(uint256 _number, bytes32[] calldata proof) public allowed(proof){
        magicNumber = _number;
    }
}