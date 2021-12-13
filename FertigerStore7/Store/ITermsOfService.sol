/**
 * @title Interface Terms of Service
 * @dev ITermsOfService contract
 *
 * @author Felix Götz - <AUREUM VICTORIA>
 * on behalf of Securus Technologies LLC
 *
 * SPDX-License-Identifier: GNU GPLv2
 *
 **/

pragma solidity ^0.8.4;

interface ITermsOfService {
    function hasAcceptedTermsOfService(address _user)
        external
        view
        returns (bool);
}