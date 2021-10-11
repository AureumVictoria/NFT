// SPDX-License-Identifier: MIT

pragma solidity  0.8.4;

import "./Roles.sol";
import "./Ownable.sol";

contract WhitelistRole is Ownable {
    using Roles for Roles.Role;

    event WhitelisterAdded(address indexed account);
    event WhitelisterRemoved(address indexed account);

    Roles.Role private _whitelisters;

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
    function addWhitelister(address account) public onlyAuthorized {
        _addWhitelister(account);
    }
    
    
    /**
     * @dev remove address from the Whitelist role.
     * 
     * Requirements:
     * 
     * address `account` cannot be the zero address.
     */
    function renounceWhitelister(address account) public onlyAuthorized {
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