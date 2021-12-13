/**
 * @title Blacklist Role
 * @dev BlacklistRole contract
 *
 * @author Felix Götz - <AUREUM VICTORIA>
 * on behalf of Securus Technologies LLC 
 * 
 * SPDX-License-Identifier: GNU GPLv2
 *
 **/

pragma solidity ^0.6.12;

import "./Roles.sol";
import "./Ownable.sol";

contract BlacklistRole is Ownable {
    using Roles for Roles.Role;

    event BlacklisterAdded(address indexed account);
    event BlacklisterRemoved(address indexed account);

    Roles.Role private _blacklisters;

    constructor () internal {
        _addBlacklister(msg.sender);
    }

    modifier onlyBlacklister() {
        require(isBlacklister(msg.sender), "BlacklisterRole: caller does not have the Blacklister role");
        _;
    }

    /**
     * @dev Returns account address is Blacklister true or false
     * 
     * Requirements:
     * 
     * address `account` cannot be the zero address.
     */
    function isBlacklister(address account) public view returns (bool) {
        return _blacklisters.has(account);
    }
    
    /**
     * @dev add address to the Blacklister role.
     * 
     * Requirements:
     * 
     * address `account` cannot be the zero address.
     */
    function addBlacklister(address account) public onlyOwner {
        _addBlacklister(account);
    }

    /**
     * @dev remove address from the Blacklister role.
     * 
     * Requirements:
     * 
     * address `account` cannot be the zero address.
     */
    function renounceBlacklister(address account) public onlyOwner {
        _removeBlacklister(account);
    }

    /**
     * @dev add address to the Blacklister role (internal).
     * 
     * Requirements:
     * 
     * address `account` cannot be the zero address.
     */
    function _addBlacklister(address account) internal {
        _blacklisters.add(account);
        emit BlacklisterAdded(account);
    }

    /**
     * @dev remove address from the Blacklister role (internal).
     * 
     * Requirements:
     * 
     * address `account` cannot be the zero address.
     */
    function _removeBlacklister(address account) internal {
        _blacklisters.remove(account);
        emit BlacklisterRemoved(account);
    }
    
}