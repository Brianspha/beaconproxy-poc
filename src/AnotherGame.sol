// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {IGame} from "./IGame.sol";

contract AnotherGame is IGame {
    fallback() external {}
    function __Game_init() public override {}

    function startGame(address player) public virtual override returns (bool) {
        emit GameStarted(block.timestamp, player);
    }

    function addPlayer(address player) public virtual override returns (bool) {
        revert NotImplemented();
    }

    function removePlayer(address player) public virtual override returns (bool) {
        revert NotImplemented();
    }

    function whiteListWallet(address wallet, bool status) public virtual override returns (bool) {
        revert NotImplemented();
    }

    function collectRewards() public virtual override returns (bool) {
        revert NotImplemented();
    }

    function healthCheck() public view override returns (bool) {
        revert NotImplemented();
    }
}
