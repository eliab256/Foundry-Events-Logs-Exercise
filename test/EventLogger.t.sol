// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/EventLogger.sol";

contract EventLoggerTest is Test {
    EventLogger logger;

    function setUp() public {
        logger = new EventLogger();
    }

    function testEmitTransfer() public {
        address to = address(0x123);
        uint256 amount = 1000;

        vm.expectEmit(true, true, false, true);
        emit EventLogger.Transfer(address(this), to, amount);

        logger.emitTransfer(to, amount);

        // verify logs and compare with expected values
    }

    function testEmitMessage() public {
        string memory content = "Hello, World!";
        uint256 timestamp = block.timestamp;

        vm.expectEmit(false, false, false, true);
        emit EventLogger.Message(content, timestamp);

        logger.emitMessage(content);

        // verify logs and compare with expected values
    }

    function testPing() public {
        vm.expectEmit(false, false, false, false);
        emit EventLogger.Ping();

        logger.ping();

        // verify logs and compare with expected values
    }

    function testEmitComplex() public {
        address user = address(0x456);
        uint256[] memory values = new uint256[](3);
        values[0] = 1;
        values[1] = 2;
        values[2] = 3;
        string memory note = "Test Note";

        vm.expectEmit(true, false, false, true);
        emit EventLogger.Complex(user, values, note);

        logger.emitComplex(user, values, note);

        // verify logs and compare with expected values
    }

}