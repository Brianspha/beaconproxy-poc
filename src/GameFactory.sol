// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {GameFactoryBase} from "./GameFactoryBase.sol";

contract GameFactory is GameFactoryBase {
    function initialize() public initializer {
        __GameFactoryBase_init();
    }
}
