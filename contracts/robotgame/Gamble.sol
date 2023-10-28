// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.21;

import "./Basic.sol";

//赌博游戏
contract Gamble is Basic {

    //用户可以把自己的机器人当作筹码，进行一次赌博
    //获胜可以随机获取一个新的机器人
    //失败会失去筹码
    function gamble(uint choice, uint robotId) external ownerOfRobot(robotId) {

        uint randInt = randMod(6) + 1;
        uint res;
        if (randInt <=3 ) {
            res = 0;
        } else {
            res = 1;
        }

        if (choice == res) {
             getFreeRobotAfterGambleWin();
        } else {
            robotToOwner[robotId] = owner();
        }
    }

    //从赌博中获胜后，获得免费机器人
    function getFreeRobotAfterGambleWin() internal {
        CreateRobot();
    }
}