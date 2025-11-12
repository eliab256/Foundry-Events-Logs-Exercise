// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {EventLogger} from "../src/EventLogger.sol";
import {Vm} from "forge-std/Vm.sol";

/**
 * @title EventLogs Exercise
 * @author Elia Bordoni
 * @notice This test suite verifies that the `EventLogger` contract emits and encodes events correctly.
 *         It covers various event types, including simple and complex ones with arrays and strings.
 * @dev The tests use Foundry’s `vm.recordLogs()` to capture emitted logs and manually decode them
 *      to ensure that topics and data match expected values.
 *
 * 🔗 GitHub: https://github.com/eliab256
 * 🔗 LinkedIn: https://www.linkedin.com/in/elia-bordoni/
 */

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
        Vm.Log[] memory entries = vm.getRecordedLogs();
        assertEq(entries.length, 1);
        Vm.Log memory fullEvent = entries[0];
        bytes32 eventSignature = fullEvent.topics[0]; //event signature hashed
        bytes32 topic1 = fullEvent.topics[1]; //is indexed
        bytes32 topic2 = fullEvent.topics[2]; //is indexed
        bytes memory data = fullEvent.data; //is not indexed

        // encode expected values and compare with logs
        assertEq(
            eventSignature,
            keccak256("Transfer(address,address,uint256)")
        );
        assertEq(topic1, bytes32(uint256(uint160(user1))));
        assertEq(topic2, bytes32(uint256(uint160(user2))));
        assertEq(data, abi.encode(amount));

        //decode data from event and compare with expected values
        address testFrom = address(uint160(uint256(topic1)));
        address testTo = address(uint160(uint256(topic2)));
        uint256 testAmount = abi.decode(data, (uint256));

        assertEq(testFrom, user1);
        assertEq(testTo, user2);
        assertEq(testAmount, amount);
    }

    function testEmitMessage() public {
        string memory message = "Hello, World!";
        uint256 id = 10;

        vm.recordLogs();
        vm.prank(user1);
        logger.emitMessage(message, id);

        // extract event logs
        Vm.Log[] memory entries = vm.getRecordedLogs();
        assertEq(entries.length, 1);
        Vm.Log memory fullEvent = entries[0];
        bytes32 eventSignature = fullEvent.topics[0];
        bytes memory data = fullEvent.data;
        (string memory testMessage, uint256 testId) = abi.decode(
            data,
            (string, uint256)
        );

        // encode expected values and compare with logs
        assertEq(eventSignature, keccak256("Message(string,uint256)"));
        assertEq(data, abi.encode(message, id));

        //decode data from event and compare with expected values
        assertEq(message, testMessage);
        assertEq(id, testId);
    }

    /**
     * @notice Tests the simple `Ping` event with no arguments.
     * @dev Since there are no parameters, only the event signature is emitted as topic[0].
     */
    function testPing() public {
        vm.recordLogs();
        vm.prank(user1);
        logger.ping();

        // verify logs and compare with expected values
        Vm.Log[] memory entries = vm.getRecordedLogs();
        assertEq(entries.length, 1);
        Vm.Log memory fullEvent = entries[0];
        bytes32 eventSignature = fullEvent.topics[0];
        bytes memory data = fullEvent.data;

        assertEq(eventSignature, keccak256("Ping()"));
        assertEq(data.length, 0); //there is no not-indexed arguments
    }

    /**
     * @notice Tests a complex event with both an address and dynamic data types (array + string).
     * @dev Demonstrates how dynamic types are encoded in the event `data` field
     *      and how to decode them back for assertion.
     * @custom-suggestion Arrays cannot be `indexed` in Solidity events; they must be part of the data payload.
     */
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
        Vm.Log[] memory entries = vm.getRecordedLogs();
        assertEq(entries.length, 1);
        Vm.Log memory fullEvent = entries[0];
        bytes32 eventSignature = fullEvent.topics[0];
        bytes32 topic1 = fullEvent.topics[1];
        bytes memory data = fullEvent.data;
        (uint256[] memory testValues, string memory testNote) = abi.decode(
            data,
            (uint256[], string)
        );

        // verify logs and compare with expected values
        assertEq(
            eventSignature,
            keccak256("Complex(address,uint256[],string)")
        );
        assertEq(topic1, bytes32(uint256(uint160(user2))));
        assertEq(data, abi.encode(values, note));

        //decode data from event and compare with expected values
        assertEq(address(uint160(uint256(topic1))), user2);
        assertEq(testValues, values);
        assertEq(testNote, note);
        assertEq(testValues.length, 3);
        assertEq(testValues[0], 1);
        assertEq(testValues[1], 2);
        assertEq(testValues[2], 3);
    }
}
