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
import "./ITeamMember.sol";



contract MainTreasury is Ownable {
    using SafeERC20 for IERC20;

    ITeamMember1 internal teamMember1;
    ITeamMember2 internal teamMember2;
    ITeamMember3 internal teamMember3;
    ITeamMember4 internal teamMember4;

    function AdminwithdrawTokens(address _token, address _to, uint256 _amount) external onlyOwner {
        IERC20(_token).safeTransfer(_to, _amount);
    }

    function withdrawTokens(address _token, address _to, uint256 _amount) external {
       uint256 bal = IERC20(_token).balanceOf(address(this));
       require (_amount <= bal, "not enough coins");

       require (teamMember1.isTokenAddressOK() == _token, "Team Member 1 has not released this token"); 
       require (teamMember1.isTokenBalanceOK() >= _amount, "Team Member 1 has released less than the required amount.");
       require (teamMember1.isTokenWithdrawlAddressOK() == _to, "Team Member 1 has not released this address for payment");

       require (teamMember2.isTokenAddressOK() == _token, "Team Member 2 has not released this token"); 
       require (teamMember2.isTokenBalanceOK() >= _amount, "Team Member 2 has released less than the required amount.");
       require (teamMember2.isTokenWithdrawlAddressOK() == _to, "Team Member 2 has not released this address for payment");

       require (teamMember3.isTokenAddressOK() == _token, "Team Member 3 has not released this token"); 
       require (teamMember3.isTokenBalanceOK() >= _amount, "Team Member 3 has released less than the required amount.");
       require (teamMember3.isTokenWithdrawlAddressOK() == _to, "Team Member 3 has not released this address for payment");

       require (teamMember4.isTokenAddressOK() == _token, "Team Member 4 has not released this token"); 
       require (teamMember4.isTokenBalanceOK() >= _amount, "Team Member 4 has released less than the required amount.");
       require (teamMember4.isTokenWithdrawlAddressOK() == _to, "Team Member 4 has not released this address for payment");

        IERC20(_token).safeTransfer(_to, _amount);
    }

    function updateTeamMember1(address _teamMember1)
        public
        onlyOwner
    {
        teamMember1 = ITeamMember1(_teamMember1);
    }

    function updateTeamMember2(address _teamMember2)
        public
        onlyOwner
    {
        teamMember2 = ITeamMember2(_teamMember2);
    }

    function updateTeamMember3(address _teamMember3)
        public
        onlyOwner
    {
        teamMember3 = ITeamMember3(_teamMember3);
    }

    function updateTeamMember4(address _teamMember4)
        public
        onlyOwner
    {
        teamMember4 = ITeamMember4(_teamMember4);
    }
}