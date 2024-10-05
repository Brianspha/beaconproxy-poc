// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {Game} from "./Game.sol";

contract MyCustomGame is Game {
    function initialize() public initializer {
        __Game_init();
    }
}
