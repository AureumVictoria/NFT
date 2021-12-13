/**
 * @title Whitelist Role
 * @dev WhitelistRole contract
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

contract WhitelistRole is Ownable {
    using Roles for Roles.Role;

    event WhitelisterAdded(address indexed account);
    event WhitelisterRemoved(address indexed account);

    Roles.Role private _whitelisters;

    constructor () internal {
        _addWhitelister(msg.sender);
    }

    modifier onlyWhitelister() {
        require(isWhitelister(msg.sender), "WhitelisterRole: caller does not have the Whitelister role");
        _;
    }

    /**
     * @dev Returns account address is whitelister true or false
     * 
     * Requirements:
     * 
     * address `account` cannot be the zero address.
     */
    function isWhitelister(address account) public view returns (bool) {
        return _whitelisters.has(account);
    }


    /**
     * @dev add address to the Whitelist role.
     * 
     * Requirements:
     * 
     * address `account` cannot be the zero address.
     */
    function addWhitelister(address account) public onlyOwner {
        _addWhitelister(account);
    }
    
    
    /**
     * @dev remove address from the Whitelist role.
     * 
     * Requirements:
     * 
     * address `account` cannot be the zero address.
     */
    function renounceWhitelister(address account) public onlyOwner {
        _removeWhitelister(account);
    }

    /**
     * @dev add address to the Whitelist role (internal).
     * 
     * Requirements:
     * 
     * address `account` cannot be the zero address.
     */
    function _addWhitelister(address account) internal {
        _whitelisters.add(account);
        emit WhitelisterAdded(account);
    }

    /**
     * @dev remove address from the Whitelist role (internal).
     * 
     * Requirements:
     * 
     * address `account` cannot be the zero address.
     */
    function _removeWhitelister(address account) internal {
        _whitelisters.remove(account);
        emit WhitelisterRemoved(account);
    }
}