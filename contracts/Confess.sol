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

    constructor() payable {
        console.log("We have been constructed!");
        /*
         * Set the initial seed
         */
        seed = (block.timestamp + block.difficulty) % 100;
    }

    function confess(string memory _message) public {
        totalConfessions += 1;
        console.log("%s has confessed!", msg.sender);

        confessions.push(Confession(msg.sender, _message, block.timestamp));

        /*
         * Generate a new seed for the next user that sends a confession
         */
        seed = (block.difficulty + block.timestamp + seed) % 100;
        
        console.log("Random # generated: %d", seed);

        /*
         * Give a 50% chance that the user wins the prize.
         */
        if (seed <= 50) {
            console.log("%s won!", msg.sender);

            /*
             * The same code we had before to send the prize.
             */
            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than the contract has."
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
