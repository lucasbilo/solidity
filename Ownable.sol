pragma solidity >= 0.7.0 < 0.9.0;

contract Ownable {

    address public owner;

    constructor(){
        // msg es global, depende de quien la llama
        owner = msg.sender;
    }

    // se va a ejecutar en la función que la llame
    modifier isOwner(){
        //if(msg.sender !== owner){
        //    throw "Your are not the owner");
        //}
        require(msg.sender == owner, "Your are not the owner");
        //esto indica el cuerpo del codigo de la función que lo llama
        // estando asi, se va a ejecutar el require antes que el resto.
        _:
    }

    function setOwner(address _newOwner) public isOwner returns (bool){
        owner = _newOwner;
        return true; 
    }
}