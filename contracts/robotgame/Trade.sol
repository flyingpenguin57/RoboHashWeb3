// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.21;

import "./Basic.sol";
import "./SafeMath.sol";

//交易,这里价格的单位应该是wei
contract Trade is Basic {

    using SafeMath for uint256;
    uint[] public markets;

    //上架机器人
    function saleRobot(uint robotId, uint price) external ownerOfRobot(robotId) {
        markets.push(robotId);
        robots[robotId].status = 1;
        robots[robotId].price = price;
        robots[robotId].idInMarket = markets.length - 1;
    }

    //修改机器人价格
    function setRobotPrice(uint robotId, uint price) external ownerOfRobot(robotId) {
        robots[robotId].price = price;
    }

    //下架机器人
    function unSaleRobot(uint robotId) external ownerOfRobot(robotId) {
        //remove from market
        markets[robots[robotId].idInMarket] = markets[markets.length - 1];
        markets.pop();
        robots[robotId].status = 0;
        robots[robotId].price = 0;
    }

    //购买机器人
    function buyRobot(uint robotId) external payable {
        require(msg.sender != robotToOwner[robotId], "It's your robot, you can't buy it.");
        require(robots[robotId].status == 1, "This robot not on sale.");
        require(msg.value == robots[robotId].price);

        //机器人下架
        markets[robots[robotId].idInMarket] = markets[markets.length - 1];
        markets.pop();
        robots[robotId].status = 0;
        robots[robotId].price = 0;

        //获取收款人地址
        address payable salerAddr = payable(robotToOwner[robotId]);

        //转移机器人所有权
        robotToOwner[robotId] = msg.sender;

        //转账给收款人，收取5%交易费
        salerAddr.transfer(msg.value.div(100).mul(95));
    }
}