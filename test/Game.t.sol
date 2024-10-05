// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "./base/GameBaseTest.t.sol";

contract GameTest is GameBaseTest {
    function setUp() public override {
        GameBaseTest.setUp();
    }

    function test_playGameWalletOne() public {
        vm.startPrank(owner);
        playerAOneWallet.playGame();
        vm.stopPrank();
    }
}
