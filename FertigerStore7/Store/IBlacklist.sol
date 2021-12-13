/**
 * @title Interface Blacklist
 * @dev IBlacklist contract
 *
 * @author Felix Götz - <AUREUM VICTORIA>
 * on behalf of Securus Technologies LLC
 *
 * SPDX-License-Identifier: GNU GPLv2
 *
 **/

pragma solidity ^0.8.4;

interface IBlacklist {
    function isBlacklisted(address _address) external view returns (bool);
}