// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract EventLogger {
    // Evento con un parametro indicizzato e uno normale
    event Transfer(address indexed from, address indexed to, uint256 amount);

    // Evento con solo parametri non indicizzati
    event Message(string content, uint256 timestamp);

    // Evento con un solo topic (nome evento)
    event Ping();

    event Complex(address indexed user, uint256[] values, string note);

    function emitTransfer(address _to, uint256 _amount) external {
        emit Transfer(msg.sender, _to, _amount);
    }

    function emitMessage(string calldata _content) external {
        emit Message(_content, block.timestamp);
    }

    function emitComplex(
        address _user,
        uint256[] calldata _values,
        string calldata _note
    ) external {
        emit Complex(_user, _values, _note);
    }

    function ping() external {
        emit Ping();
    }
}
