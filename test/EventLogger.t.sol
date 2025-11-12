// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {EventLogger} from "../src/EventLogger.sol";
import {Vm} from "forge-std/Vm.sol";

contract EventLoggerTest is Test {
    EventLogger logger;

    //create two users
    address user1 = makeAddr("user1");
    address user2 = makeAddr("user2");

    function setUp() public {
        logger = new EventLogger();
    }

    function testEmitTransfer() public {
        address to = user2;
        uint256 amount = 1000;

        vm.recordLogs();
        vm.prank(user1);
        logger.emitTransfer(to, amount);

        // extract event logs

        // encode expected values and compare with logs

        //decode data from event and compare with expected values
    }

    function testEmitMessage() public {
        string memory message = "Hello, World!";
        uint256 id = 10;

        vm.recordLogs();
        vm.prank(user1);
        logger.emitMessage(message, id);

        // extract event logs

        // encode expected values and compare with logs

        //decode data from event and compare with expected values
    }

    function testPing() public {
        vm.recordLogs();
        vm.prank(user1);
        logger.ping();

        // verify logs and compare with expected values
    }

    function testEmitComplex() public {
        //emit Complex(_user, _values, _note);
        address user = user2;
        uint256[] memory values = new uint256[](3);
        values[0] = 1;
        values[1] = 2;
        values[2] = 3;
        string memory note = "Test Note";

        vm.recordLogs();
        vm.prank(user1);
        logger.emitComplex(user, values, note);

        // extract event logs

        // verify logs and compare with expected values

        //decode data from event and compare with expected values
    }
}
