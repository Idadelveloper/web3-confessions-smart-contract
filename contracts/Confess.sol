// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Confess {
    uint256 totalConfessions;

    event NewConfession(address indexed from, uint256 timestamp, string message);

    struct Confession {
        address confessor; // The address of the user who waved.
        string message; // The message the user sent.
        uint256 timestamp; // The timestamp when the user waved.
    }

    Confession[] confessions;


    constructor() payable {
        console.log("Say something you've never told anyone and you'll probably die without telling anybody");
    }

    function confess(string memory _message) public{
        totalConfessions += 1;
        console.log("%s has made a confession sayine '%s'", msg.sender, _message);

        confessions.push(Confession(msg.sender, _message, block.timestamp));

        emit NewConfession(msg.sender, block.timestamp, _message);

        uint256 prizeAmount = 0.0001 ether;
        require(
            prizeAmount <= address(this).balance,
            "Trying to withdraw more money than the contract has."
        );
        (bool success, ) = (msg.sender).call{value: prizeAmount}("");
        require(success, "Failed to withdraw money from contract.");
    }

    function getAllConfessions() public view returns (Confession[] memory) {
        return confessions;
    }


    function getTotalConfessions() public view returns (uint256) {
        console.log("We have %d total confessions!", totalConfessions);
        return totalConfessions;
    }
}