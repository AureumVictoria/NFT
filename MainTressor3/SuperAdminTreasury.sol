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
import "./IOwnable.sol";

contract SuperAdminTreasury is Ownable {
      using SafeERC20 for IERC20;

    ITeamMember1 internal teamMember1;
    ITeamMember2 internal teamMember2;
    ITeamMember3 internal teamMember3;
    ITeamMember4 internal teamMember4;
    IOwnable internal TressorSuperAdmin;

    uint256 private lockTime1;
    uint256 private lockTimeEnd1;

    uint256 private lockTime2;
    uint256 private lockTime3;
    uint256 private lockTime4;
    uint256 private lockTimeEnd2;
    uint256 private lockTimeEnd3;
    uint256 private lockTimeEnd4;

    address public Member1 = 0xC9690De835d64e3073c7B6e214089a477614aE57;
    address public Member2 = 0xC9690De835d64e3073c7B6e214089a477614aE57;
    address public Member3 = 0xC9690De835d64e3073c7B6e214089a477614aE57;
    address public Member4 = 0xC9690De835d64e3073c7B6e214089a477614aE57;


    function aktivateSuperAdmin () public {
    require (Member1 == msg.sender || Member2 == msg.sender || Member3 == msg.sender || Member4 == msg.sender, "You don't have permission to aktivate SuperAdmin ");
    if (Member1 == msg.sender) {
    require (teamMember2.isVetoMember1() == false || teamMember3.isVetoMember1() == false || teamMember3.isVetoMember1() == false, "ALL Member has VETO"); 
    lockTime1 = block.timestamp + 30 days;
    lockTimeEnd1 = block.timestamp + 31 days;
    }
    if (Member2 == msg.sender) {
    require (teamMember1.isVetoMember2() == false && teamMember3.isVetoMember2() == false && teamMember3.isVetoMember2() == false, "Member has VETO"); 
    lockTime2 = block.timestamp + 90 days;
    lockTimeEnd2 = block.timestamp + 91 days;
    }
    if (Member3 == msg.sender) {
    require (teamMember1.isVetoMember3() == false && teamMember2.isVetoMember3() == false && teamMember4.isVetoMember3() == false, "Member has VETO"); 
    lockTime3 = block.timestamp + 90 days;
    lockTimeEnd3 = block.timestamp + 91 days;
    }
    if (Member4 == msg.sender) {
    require (teamMember1.isVetoMember4() == false && teamMember2.isVetoMember4() == false && teamMember3.isVetoMember4() == false, "Member has VETO"); 
    lockTime4 = block.timestamp + 90 days;
    lockTimeEnd4 = block.timestamp + 91 days;
    }
}

    function claimSuperAdminTeamMember1() public {
        require (Member1 == msg.sender || Member2 == msg.sender || Member3 == msg.sender || Member4 == msg.sender, "You don't have permission to claim SuperAdmin");
        require ( block.timestamp < lockTime1 , "Contract is locked for ever") ;
        require ( block.timestamp > lockTime1 , "Contract is locked until 30 days ") ;
        require (teamMember2.isVetoMember1() == false || teamMember3.isVetoMember1() == false || teamMember3.isVetoMember1() == false, "ALL Member has VETO"); 
        TressorSuperAdmin.transferOwnership(0xC9690De835d64e3073c7B6e214089a477614aE57);
        }

    function claimSuperAdminTeamMember2() public {
        require (Member2 == msg.sender || Member3 == msg.sender || Member4 == msg.sender, "You don't have permission to claim SuperAdmin");
        if (Member2 == msg.sender) {
        require ( block.timestamp < lockTime2 , "Contract is locked for ever") ;
        require ( block.timestamp > lockTime2 , "Contract is locked until 90 days") ;
        require (teamMember1.isVetoMember2() == false && teamMember3.isVetoMember2() == false && teamMember3.isVetoMember2() == false, "Member has VETO"); 
        TressorSuperAdmin.transferOwnership(0xC9690De835d64e3073c7B6e214089a477614aE57);
        }
        if (Member3 == msg.sender) {
        require ( block.timestamp < lockTime3 , "Contract is locked for ever") ;
        require ( block.timestamp > lockTime3 , "Contract is locked until 90 days") ;
        require (teamMember1.isVetoMember3() == false && teamMember2.isVetoMember3() == false && teamMember4.isVetoMember3() == false, "Member has VETO"); 
        TressorSuperAdmin.transferOwnership(0xC9690De835d64e3073c7B6e214089a477614aE57);
        }
        if (Member4 == msg.sender) {
        require ( block.timestamp < lockTime4 , "Contract is locked for ever") ;
        require ( block.timestamp > lockTime4 , "Contract is locked until 90 days") ;
        require (teamMember1.isVetoMember4() == false && teamMember2.isVetoMember4() == false && teamMember3.isVetoMember4() == false, "Member has VETO"); 
        TressorSuperAdmin.transferOwnership(0xC9690De835d64e3073c7B6e214089a477614aE57);
        }
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

    function updateTressorSuperAdmin(address _tressorSuperAdmin)
        public
        onlyOwner
    {
        TressorSuperAdmin = IOwnable(_tressorSuperAdmin);
    }
}