/**
 * @title Terms of Service Role
 * @dev TermsOfServiceRole contract
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

contract TermsOfServiceRole is Ownable {
    using Roles for Roles.Role;

    event AdminAdded(address indexed account);
    event AdminRemoved(address indexed account);

    Roles.Role private _admins;

    constructor() internal {
        _addAdmin(msg.sender);
    }

    modifier onlyAdmin() {
        require(
            isAdmin(msg.sender),
            "TermsOfServiceRole: caller does not have the Admin role"
        );
        _;
    }

    /**
     * @dev Returns account address is Admin true or false
     *
     * Requirements:
     *
     * address `account` cannot be the zero address.
     */
    function isAdmin(address account) public view returns (bool) {
        return _admins.has(account);
    }

    /**
     * @dev add address to the Admin role.
     *
     * Requirements:
     *
     * address `account` cannot be the zero address.
     */
    function addAdmin(address account) public onlyOwner {
        _addAdmin(account);
    }

    /**
     * @dev remove address from the Admin role.
     *
     * Requirements:
     *
     * address `account` cannot be the zero address.
     */
    function renounceAdmin(address account) public onlyOwner {
        _removeAdmin(account);
    }

    /**
     * @dev add address to the Admin role (internal).
     *
     * Requirements:
     *
     * address `account` cannot be the zero address.
     */
    function _addAdmin(address account) internal {
        _admins.add(account);
        emit AdminAdded(account);
    }

    /**
     * @dev remove address from the Admin role (internal).
     *
     * Requirements:
     *
     * address `account` cannot be the zero address.
     */
    function _removeAdmin(address account) internal {
        _admins.remove(account);
        emit AdminRemoved(account);
    }
}