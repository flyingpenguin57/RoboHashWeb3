// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.13;

//commander
contract CommanderBasic {
    //one account can only have one commander.
    struct Commander {
        string name; //commander's name
        uint64 dna; //commander's dna
        uint64 getFreeRobotReadyTime; 
        uint64 giveStarReadyTime;
    }
}