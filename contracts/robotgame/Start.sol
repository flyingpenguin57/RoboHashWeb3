// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.21;

import "./RobotManage.sol";
import "./Gamble.sol";
import "./Star.sol";
import "./Trade.sol";
//入口
contract Start is RobotManage, Gamble, Star, Trade {
    constructor() {
        commanders.push(Commander("init", "init", 0, 0));
    }
}