// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.21;

//合约中有未实现的函数，所以要用abstract修饰，和java有点类似
abstract contract ERC721 {
  event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
  event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);

  //没有实现的函数用virtual修饰
  function balanceOf(address _owner) external virtual view returns (uint256);
  function ownerOf(uint256 _tokenId) external virtual view returns (address);
  function transferFrom(address _from, address _to, uint256 _tokenId) external virtual payable;
  function approve(address _approved, uint256 _tokenId) external virtual payable;
}