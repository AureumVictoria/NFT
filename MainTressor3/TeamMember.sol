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

import "./SafeERC20.sol";
import "./Ownable.sol";

contract MainTreasury is Ownable {
    using SafeERC20 for IERC20;

    address public tokenAddress;
    uint256 public tokenBalance;
    address public tokenWithdrawlAddress;
    bool public vetoMember1 = true;
    bool public vetoMember2 = true;
    bool public vetoMember3 = true;
    bool public vetoMember4 = true;

    function setTokenAddress(address _token) external onlyOwner {

        tokenAddress = _token;
    }

    function setTokenBalance(uint256 _amount) external onlyOwner {

        tokenBalance = _amount;
    }

    function setTokenWithdrawlAddress(address _to) external onlyOwner {

        tokenWithdrawlAddress = _to;
    }

    function isTokenAddressOK() public view returns (address) {
    return tokenAddress;
    }

    function isTokenBalanceOK() public view returns (uint256) {
    return tokenBalance;
    }

    function isTokenWithdrawlAddressOK() public view returns (address) {
    return tokenWithdrawlAddress;
    }

    function setVetoMember1(bool _vetoMember1) external onlyOwner {

        vetoMember1 = _vetoMember1;
    }

    function setVetoMember2(bool _vetoMember2) external onlyOwner {

        vetoMember2 = _vetoMember2;
    }

    function setVetoMember3(bool _vetoMember3) external onlyOwner {

        vetoMember3 = _vetoMember3;
    }

    function setVetoMember4(bool _vetoMember4) external onlyOwner {

        vetoMember4 = _vetoMember4;
    }

    function isVetoMember1() public view returns (bool) {
    return vetoMember1;
    }

    function isVetoMember2() public view returns (bool) {
    return vetoMember2;
    }

    function isVetoMember3() public view returns (bool) {
    return vetoMember3;
    }

    function isVetoMember4() public view returns (bool) {
    return vetoMember4;
    }
}