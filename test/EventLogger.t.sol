// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {EventLogger} from "../src/EventLogger.sol";
import {Vm} from "forge-std/Vm.sol";

contract EventLoggerTest is Test {
    EventLogger logger;

    function setUp() public {
        logger = new EventLogger();
    }

    function testEmitTransfer() public {
        address to = address(0x123);
        uint256 amount = 1000;

        vm.recordLogs();
        logger.emitTransfer(to, amount);

        // verify logs and compare with expected values
    }

    function testEmitMessage() public {
        string memory content = "Hello, World!";
        //uint256 timestamp = block.timestamp;

        vm.recordLogs();
        logger.emitMessage(content);

        // verify logs and compare with expected values
    }

    function testPing() public {
        vm.recordLogs();
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

        vm.recordLogs();
        logger.emitComplex(user, values, note);

        // verify logs and compare with expected values
    }
}
