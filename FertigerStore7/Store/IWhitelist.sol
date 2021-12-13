/**
 * @title Interface Whitelist
 * @dev IWhitelist contract
 *
 * @author Felix Götz - <AUREUM VICTORIA>
 * on behalf of Securus Technologies LLC
 *
 * SPDX-License-Identifier: GNU GPLv2
 *
 **/

pragma solidity ^0.8.4;

interface IWhitelist {
    function isWhitelisted(address _user) external view returns (bool);

    function statusWhitelist() external view returns (bool);
}