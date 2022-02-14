/**
 * @title Ownable
 * @dev Ownable contract
 *
 * @author - <AUREUM VICTORIA GROUP>
 * for the Securus Foundation
 *
 * SPDX-License-Identifier: GNU GPLv2
 *
 * File: @openzeppelin/contracts/access/Ownable.sol
 *
 **/
 
 pragma solidity ^0.6.12;

interface IOwnable {
  function owner() external view returns (address);
  function transferOwnership(address _newOwner) external returns (bool);
  function renounceOwnership() external returns (bool);

  event OwnershipTransferred(address indexed newOwner);
}