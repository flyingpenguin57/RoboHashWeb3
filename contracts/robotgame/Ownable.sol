// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.21;

/**
* @title Ownable
* @dev The Ownable contract has an owner address, and provides basic authorization control
* functions, this simplifies the implementation of "user permissions".
*/
//Ownable合约，用于对智能合约的 所有人 进行改、查、权限校验操作
contract Ownable {
  address private _owner; //owner的地址

  //事件，智能合约所有人发生了转移;该事件包含两个成员，上一个所有人和现在的所有人;
  //变量用indexed关键字修饰，允许前端监听事件时通过该字段进行过滤
  event OwnershipTransferred(
    address indexed previousOwner, 
    address indexed newOwner       
  );

  /**
  * @dev The Ownable constructor sets the original `owner` of the contract to the sender
  * account.
  */
  //构造函数，仅在智能合约部署上链时/创建合约账户时 会执行一次
  constructor() {
    _owner = msg.sender; //把合约创建人设置为所有人
    //发射 所有人变更 事件；其实可以不用，address(0)这种写法应该代表了一个空地址
    emit OwnershipTransferred(address(0), _owner);
  }

  /**
  * @return the address of the owner.
  */
  //返回 所有人 地址
  function owner() public view returns(address) {
    return _owner;
  }

  /**
  * @dev Throws if called by any account other than the owner.
  */
  //修饰符，用于权限判断，仅所有人可通过校验
  modifier onlyOwner() {
    require(isOwner());
    _;
  }

  /**
  * @return true if `msg.sender` is the owner of the contract.
  */
  //判断当前调用者是否是合约所有人
  function isOwner() public view returns(bool) {
    return msg.sender == _owner;
  }

  /**
  * @dev Allows the current owner to relinquish control of the contract.
  * @notice Renouncing to ownership will leave the contract without an owner.
  * It will not be possible to call the functions with the `onlyOwner`
  * modifier anymore.
  */
  //放弃合约，把所有人变成一个空地址；这个应该不会用到
  function renounceOwnership() public onlyOwner {
    emit OwnershipTransferred(_owner, address(0));
    _owner = address(0);
  }

  /**
  * @dev Allows the current owner to transfer control of the contract to a newOwner.
  * @param newOwner The address to transfer ownership to.
  */
  //转移所有人
  function transferOwnership(address newOwner) public onlyOwner {
    _transferOwnership(newOwner);
  }

  /**
  * @dev Transfers control of the contract to a newOwner.
  * @param newOwner The address to transfer ownership to.
  */
  function _transferOwnership(address newOwner) internal {
    require(newOwner != address(0));
    emit OwnershipTransferred(_owner, newOwner);
    _owner = newOwner;
  }
}