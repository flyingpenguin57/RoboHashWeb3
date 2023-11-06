// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.21;

import "./Basic.sol";

//点赞
contract Star is Basic {

    //点赞
    function giveStar(uint robotId) external {
        require(msg.sender != robotToOwner[robotId], "You cannot give a star to your own robot.");

        Commander storage myCommander = commanders[ownerToCommander[msg.sender]];
        require(myCommander.giveStarReadyTime <= block.timestamp, "Less than one day since last time you give a star.");
        robots[robotId].stars++;
        myCommander.giveStarReadyTime += uint64(readyTime);

        //更新排行榜
        if (topRobots.length < 100) {
            topRobots.push(robotId);
        } else {
            if (robots[robotId].stars > topRobots[0]) {
                topRobots[0] = robotId;
            }            
        }


        //重新找出star数最小的
        if (topRobots.length == 100) {
            uint minmumStarsIndex = 0;
            for (uint i = 1; i <100; i++) {
                if (robots[topRobots[i]].stars < robots[topRobots[minmumStarsIndex]].stars) {
                    minmumStarsIndex = i;
                }
            }
            uint temp = topRobots[0];
            topRobots[0] = topRobots[minmumStarsIndex];
            topRobots[minmumStarsIndex] = temp;            
        }

    }  

    //点赞排行 
    uint[] public topRobots;
}