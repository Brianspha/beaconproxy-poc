// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {Wallet, IGame} from "./Wallet.sol";

contract MyCustomWallet is Wallet {
    function initialize(address game_) public initializer {
        __Wallet_init();
        game = IGame(game_);
        owners[msg.sender] = true;
    }
}
