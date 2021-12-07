// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

interface IBlacklist {

    function isBlacklisted(address _address) external view returns(bool);

}