// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.13;

import "./Basic.sol";

//机器人管理
contract RobotManage is Basic {

    uint commonFee = 0.001 ether;

    function setLevelupFee(uint fee) external onlyOwner {
        commonFee = fee;
    }

    event DropRobot(string name, address indexed owner);

    //用户可以修改commander的名字
    function modifyCommanderName(string calldata newName) public payable {

        require(msg.value == commonFee, "Please pay enough ether.");

        uint curCommanderIndex = ownerToCommander[msg.sender];
        Commander storage curCommander = commanders[curCommanderIndex]; 
        curCommander.name = newName;
    }

    //用户可以修改commander的dna
    function modifyCommanderDna(string calldata newDna) public payable {

        require(msg.value == commonFee, "Please pay enough ether.");

        uint curCommanderIndex = ownerToCommander[msg.sender];
        Commander storage curCommander = commanders[curCommanderIndex]; 
        curCommander.dna = newDna;
    }

    //获取所有机器人信息
    function getRobotsByOwner() external view returns(uint[] memory) {
        uint[] memory result = new uint[](ownerRobotCount[msg.sender]);
        uint counter = 0;
        for (uint i = 0; i < robots.length; i++) {
            if (robotToOwner[i] == msg.sender) {
                result[counter] = i;
                counter++;
            }
        }
        return result;
    }

    //用户可以修改机器人的名字
    function setRobotName(uint robotId, string calldata newName) external payable ownerOfRobot(robotId) {
        //第一次修改不要钱
        if (keccak256(abi.encode(robots[robotId].name)) != keccak256(abi.encode("noName"))) {
            require(msg.value == commonFee, "Please pay enough ether.");
        }
        require(bytes(newName).length <= 20, "Robot name cannot exceed 20 characters.");
        robots[robotId].name = newName;
    }

    //用户可以丢弃丢弃机器人
    function dropRobot(uint robotId) public ownerOfRobot(robotId) {
        robotToOwner[robotId] = owner();
        emit DropRobot(robots[robotId].name, msg.sender);
    }
}