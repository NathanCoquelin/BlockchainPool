// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {SmartContract} from "../src/SmartContract.sol";

contract SmartContractTest is Test {
    // Instance of the SmartContract to be tested
    SmartContract smartContract;

    // Set up function executed before each test
    function setUp() public {
        smartContract = new SmartContract();
    }

    // Test function for getHalfAnswerOfLife
    function testGetHalfAnswerOfLife() public {
        assertEq(smartContract.getHalfAnswerOfLife(), 21, "Half answer of life should be 21");
    }

    // Test function for _getMyEthereumContractAddress
    function testGetMyEthereumContractAddress() public {
        assertEq(address(smartContract._getMyEthereumContractAddress()), address(smartContract), "Contract addresses should match");
    }

    // Test function for myEthereumAddress
    function testMyEthereumAddress() public {
        assertEq(smartContract.myEthereumAddress(), address(this), "My Ethereum address should match the test contract address");
    }

    // Test function for _setAreYouABadPerson
    function testSetAreYouABadPerson() public {
        smartContract._setAreYouABadPerson(true);
        assertEq(smartContract._areYouABadPerson(), true, "Are you a bad person should be true after setting");
    }

    // Test function for myInformations
    function testMyInformations() public {
        // Retrieve individual components of myInformations
        (string memory firstName, string memory lastName, uint8 age, string memory city, SmartContract.Role role) = smartContract.myInformations();

        // Assert individual components
        assertEq(firstName, "John", "First name should be John");
        assertEq(lastName, "Doe", "Last name should be Doe");
        assertEq(age, 30, "Age should be 30");
        assertEq(city, "New York", "City should be New York");
        assertEq(uint(role), 0, "Role should be STUDENT");
    }

    function testEditMyCity() public {
        string memory newCity = "Los Angeles";
        smartContract.editMyCity(newCity);
        assertEq(keccak256(abi.encodePacked(smartContract.getMyCity())), keccak256(abi.encodePacked(newCity)), "Los Angeles");
    }

    function testGetMyFullName() public {
        string memory expectedFullName = "John Doe";
        assertEq(keccak256(abi.encodePacked(smartContract.getMyFullName())), keccak256(abi.encodePacked(expectedFullName)), "John Doe");
    }

    // Test function to pass
    function testCompleteHalfAnswerOfLifePass() public {
        uint256 initialHalfAnswer = smartContract.halfAnswerOfLife();
        smartContract.completeHalfAnswerOfLife();
        uint256 newHalfAnswer = smartContract.halfAnswerOfLife();
        assertEq(newHalfAnswer, initialHalfAnswer + 21, "Half answer of life should increase by 21");
    }

    // Test function to fail
    function testCompleteHalfAnswerOfLifeFail() public {
        // Call completeHalfAnswerOfLife directly without being the owner
        smartContract.completeHalfAnswerOfLife();
        // This assertion should fail since the caller is not the owner
        assertEq(smartContract.halfAnswerOfLife(), 42, "Half answer of life should remain unchanged");
    }

    function testHashMyMessage() public {
        string memory message = "Hello, World!";
        bytes32 hashedMessage = smartContract.hashMyMessage(message);

        assertEq(hashedMessage, keccak256(abi.encodePacked(message)), "Hashed message should match");
    }

    function testAddToBalance() public payable {
        uint256 amountToAdd = 100 wei;
        uint256 initialBalance = smartContract.getMyBalance();

        smartContract.addToBalance(amountToAdd);

        assertEq(
            smartContract.getMyBalance(),
            amountToAdd + initialBalance,
            "Balance should be updated after adding funds"
        );
    }

    function testWithdrawFromBalance() public {
        uint256 amountToWithdraw = 50;
        smartContract.addToBalance(100);
        uint256 initialBalance = smartContract.getMyBalance();

        smartContract.withdrawFromBalance(amountToWithdraw);

        assertEq(
            smartContract.getMyBalance(),
            initialBalance - amountToWithdraw,
            "Balance should be updated after withdrawal"
        );
    }
    
}
