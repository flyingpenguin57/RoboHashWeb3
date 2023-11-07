// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.13;

import "./RobotManage.sol";
import "./Star.sol";
import "./Gamble.sol";
import "./Trade.sol";

//入口
contract App is RobotManage, Star, Gamble, Trade {

}