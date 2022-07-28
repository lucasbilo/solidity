// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.7.0 < 0.9.0;

interface IEjecutable{
    function ejecutar_prestamo(address payable caller) payable external;
}

interface IPrestamista{
    function depositar() external payable returns (bool);
    function tomar_prestado(address payable prestatario) external;
}

interface IOpportunity{
    function getSomeFreeEther() external;
}

contract Prestatario is IEjecutable{

    constructor() payable {}

    event Log(string message, uint256 amount);

    function iniciar_flow(address payable prestamista) external{
        IPrestamista(prestamista).tomar_prestado(payable(address(this)));
    }

    function ejecutar_prestamo(address payable caller) override payable external{
        emit Log("Me han prestado ether ! ", msg.value);

        IOpportunity("aca va el smart contract").getSomeFreeEther();


        IPrestamista(caller).depositar{value:msg.value + 1}();
    }

    function balance() external view  returns (uint256){
        return address(this).balance;
    }
}
