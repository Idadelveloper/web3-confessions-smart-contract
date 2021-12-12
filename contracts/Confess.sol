// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Confess {
    uint256 totalConfessions;

    /*
     * We will be using this below to help generate a random number
     */
    uint256 private seed;

    event NewConfession(address indexed from, uint256 timestamp, string message);

    struct Confession {
        address confessor;
        string message;
        uint256 timestamp;
    }

    Confession[] confessions;

    mapping(address => uint256) public lastConfessedAt;

    constructor() payable {
        console.log("We have been constructed!");
        /*
         * Set the initial seed
         */
        seed = (block.timestamp + block.difficulty) % 100;
    }

    function confess(string memory _message) public {

        require(lastConfessedAt[msg.sender] + 30 seconds < block.timestamp, "Must wait 30 seconds before waving again.");

        lastConfessedAt[msg.sender] = block.timestamp;

        totalConfessions += 1;
        console.log("%s has confessed!", msg.sender);

        confessions.push(Confession(msg.sender, _message, block.timestamp));

        seed = (block.difficulty + block.timestamp + seed) % 100;

        if (seed <= 50) {
            console.log("%s won!", msg.sender);

            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than they contract has."
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
        }

        emit NewConfession(msg.sender, block.timestamp, _message);
    }

    function getAllConfessions() public view returns (Confession[] memory) {
        return confessions;
    }

    function getTotalConfessions() public view returns (uint256) {
        return totalConfessions;
    }
}
