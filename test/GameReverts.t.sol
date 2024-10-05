// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "./base/GameBaseTest.t.sol";

contract GameTestReverts is GameBaseTest {
    function setUp() public override {
        GameBaseTest.setUp();
    }

    function test_revert_upgradeGameBeaconFactory() public {
        vm.startPrank(owner);
        beaconFactory.upgradeTo(address(randomGame));
        vm.expectRevert();
        playerAOneWallet.playGame();
        vm.stopPrank();
    }
}
