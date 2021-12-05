// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Confess {
    uint256 totalConfessions;

    constructor() {
        console.log("Say something you've never told anyone and you'll probably die without telling anybody");
    }

    function confess() public {
        totalConfessions += 1;
        console.log("%s has confessed!", msg.sender);
    }

    function getTotalConfessions() public view returns (uint256) {
        console.log("We have %d total confessions!", totalConfessions);
        return totalConfessions;
    }
}