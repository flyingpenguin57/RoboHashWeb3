// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.13;

//robot
contract RobotBasic {

    struct Robot {
        string name; //name   
        uint64 dna;    //dna
        uint8 spieces; //spieces 0 or 1
        uint8 status; //normal 0 on sale 1
        uint32 stars; 
        uint256 price; 
        uint256 idInMarket;
    }

}