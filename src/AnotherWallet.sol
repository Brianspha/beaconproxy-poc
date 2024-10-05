// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {IWallet} from "./IWallet.sol";
import {IGame} from "./IGame.sol";

contract AnotherWallet is IWallet {
    IGame public game;

    constructor(IGame _game) {
        game = _game;
    }

    function addUserToWallet(address user) public override {
        revert NotImplemented();
    }

    function isWalletOwner(address user) public view override returns (bool) {
        revert NotImplemented();
    }

    function playGame() public override {
        game.startGame(address(this));
    }

    function collectRewards() public override {
        game.collectRewards();
    }
}
