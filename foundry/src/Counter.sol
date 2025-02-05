// SPDX-License-Identifier: AGPL-3.0
pragma solidity ^0.8.25;

contract Counter {
    uint256 public number;

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number++;
    }
}
