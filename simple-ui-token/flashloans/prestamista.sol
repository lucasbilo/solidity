// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.7.0 < 0.9.0;

interface IEjecutable{
    function ejecutar_prestamo(address payable caller) payable external;
}

interface IPrestamista{
    function depositar() external payable returns (bool);
    function tomar_prestado(address payable prestatario) external;
}

contract Prestamista is IPrestamista{

    uint256 public constant FEE = 1; // comision 1 wei

    constructor() payable{}

    function depositar() override external payable returns (bool){
        return true;
    }

    event Log(string message, uint256 amount);

    function tomar_prestado(address payable prestatario) override external{
        uint256 balance_antes_del_prestamo = address(this).balance;
        emit Log("Balance antes del prestamo: ! ", balance_antes_del_prestamo);
        IEjecutable(prestatario).ejecutar_prestamo{value: balance_antes_del_prestamo}(payable(address(this)));

        uint256 balance_despues_del_prestamo = address(this).balance;
        bool prestamoExitoso = balance_despues_del_prestamo > balance_antes_del_prestamo + FEE;
        require(prestamoExitoso == true, "El prestatario no pago los fess, revertimos transaccion");
    }

    function balance() external view  returns (uint256){
        return address(this).balance;
    }
}