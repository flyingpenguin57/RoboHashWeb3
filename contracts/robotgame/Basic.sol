// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.13;

import "./Ownable.sol";
import "./RobotBasic.sol";
import "./CommanderBasic.sol";

//基础合约，定义基本的数据结构
//创建commander；每天免费获取机器人
contract Basic is Ownable, RobotBasic, CommanderBasic {

    uint readyTime = 1 days; //通用的冷却时间，1天

    //这里是所有commander的信息
    Commander[] public commanders;

    //这里是所有机器人的信息
    Robot[] public robots;

    //所有者账号 => commander id
    mapping(address => uint) public ownerToCommander;
    
    //robot id => 所有者账号
    mapping(uint => address) public robotToOwner;

    //所有者账号 => 机器人数量
    mapping(address => uint) public ownerRobotCount;

    //修饰符，判断是不是机器人的主人
    modifier ownerOfRobot(uint robotId) {
        require(msg.sender == robotToOwner[robotId], "Not your robot.");
        _;
    }

    event NewCommander(uint id, string name, uint dna, address indexed owner);

    event NewRobot(uint id, string name, uint64 dna, uint spieces, address indexed owner);

    constructor() {
        commanders.push(Commander("init", 0, 0, 0));
    }

    //玩家进入游戏后，可以创建一个commander
    function CreateCommander(string calldata name) public {
        require(ownerToCommander[msg.sender] == 0, "Your commander already existed.");

        commanders.push(Commander(name, uint64(block.timestamp), uint64(block.timestamp), uint64(block.timestamp)));

        uint id = commanders.length - 1;

        ownerToCommander[msg.sender] = id;

        //触发事件
        emit NewCommander(id, name, uint64(block.timestamp), msg.sender);
    }

    //创建机器人的函数
    function CreateRobot() internal {

        //the limitation of robots you can hold is 100
        require(ownerRobotCount[msg.sender] <= 100, "Your repo is full.");
        //get random spieces
        uint8 spieces = uint8(block.timestamp % 2);
        robots.push(Robot("noName", uint64(block.timestamp), spieces, 0, 0, 0, 0));
        uint id = robots.length - 1;    
        robotToOwner[id] = msg.sender;
        ownerRobotCount[msg.sender] ++;

        emit NewRobot(id, "noName", uint64(block.timestamp), spieces, msg.sender);
    }

    //玩家每天可以获取一个免费机器人
    function getFreeRobot() public {
        //判断冷却是否完成
        Commander storage commander = commanders[ownerToCommander[msg.sender]];
        require(commander.getFreeRobotReadyTime <= block.timestamp, "Less than one day since last time you get a free robot.");
        CreateRobot();
        commander.getFreeRobotReadyTime = uint64(block.timestamp + readyTime);
    }

}