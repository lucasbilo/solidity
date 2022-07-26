// Solidity desde 0.
// https://remix-project.org/

// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.7.0 < 0.9.0;

contract Employess{

    // Por defecto las variables tienen visibilidad: internal
    // value
    uint256 public age; // se la seteo en publica
    string name;
    bool admin;
    int256 favoriteNumber;
    address wallet;
    bytes32 txHash; // 64 caracteres

    // reference 
    uint256[] numbers; 
    mapping(address => uint256) balances;  // {'0x1234123214312312321321321ads': 123123}
    mapping(uint256 => address) idToWallet; // {0: '0x12354g312312312321321f'}

    // Como string es dinamico, hay que aclarar donde se lo guarda, dependiendo el lugar
    // va a costar un fee distinto: "memory" or "calldata"

    // Funciones
    // Visibilidades posibles: public, internal
    function setEmployee(uint256 _age, string memory _name, bool _admin, int256 _number, address _wallet) public {
        age = _age;
        name = _name;
        admin = _admin;
        favoriteNumber = _number;
        wallet = _wallet;
    }
}

contract Employess2{

    struct Person {
        uint256 age;
        string name;
        bool admin;
        address wallet;
    }

    // array de 10 personas
    // Person[10] myEmployess;

    // Usando mappings es mejor, no hay que setear la cantidad
    mapping(uint256 => Person) myEmployess;

    function setEmployee(uint256 _index,uint256 _age, string memory _name, bool _admin, address _wallet) public {
        myEmployess[_index].age = _age;
        myEmployess[_index].age = _age;
        myEmployess[_index].name = _name;
        myEmployess[_index].admin = _admin;
        myEmployess[_index].wallet = _wallet;
    }

    // se debe aclarar el tipo de retorno
    // hay que aclarar si la función muta los datos, view significa que es solo lectura --> no se mutan
    function getEmployee(uint256 _index) public view returns (Person memory){
        return myEmployess[_index]; //devuelve una tupla
    }

}