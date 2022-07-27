// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CallerLowLevel{

    bytes public response;

    // https://www.4byte.directory/
    function callFallback(address _to) external {
        _to.call('');
    }

    function callInextingFunction(address _to) external{
        bytes memory functionSignature = abi.encodeWithSignature("estaFunctionNoExiste()");
        _to.call(functionSignature);
    }

    function callWithParameters(address payable _to) external payable{
        bytes memory functionSignature = abi.encodeWithSignature("mint(uint256)", 42);
        (bool _success, bytes memory _response) = _to.call{value: msg.value}(functionSignature);
        require(_success, "Llamada a otro contrato fallo");
        response = _response;
    }
}