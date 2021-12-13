/**
 * @title Interface Referrals
 * @dev IReferrals contract
 *
 * @author Felix Götz - <AUREUM VICTORIA>
 * on behalf of Securus Technologies LLC
 *
 * SPDX-License-Identifier: GNU GPLv2
 *
 **/

pragma solidity ^0.8.4;

interface IReferrals {
    function updateEarn(address _member, uint256 _amount) external;

    function getSponsor(address account) external view returns (address);

    function isMember(address _user) external view returns (bool);

    function addMember(address _member, address _parent) external;

    function membersList(uint256 id) external view returns (address);

    function getListReferrals(address _member)
        external
        view
        returns (address[] memory);
}