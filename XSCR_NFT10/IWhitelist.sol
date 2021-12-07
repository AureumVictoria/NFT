// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

interface IWhitelist {


    function isWhitelisted(address _user) external view returns (bool);

    function statusWhitelist() external view returns(bool);

}