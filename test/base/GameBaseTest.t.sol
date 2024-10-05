// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {MyCustomGame} from "../../src/MyCustomGame.sol";
import {AnotherGame} from "../../src/AnotherGame.sol";
import {AnotherWallet} from "../../src/AnotherWallet.sol";
import {RandomGame} from "../../src/RandomGame.sol";
import {MyCustomWallet, IGame} from "../../src/MyCustomWallet.sol";
import {Upgrades, Options} from "openzeppelin-foundry-upgrades/Upgrades.sol";
import {GameFactory} from "../../src/GameFactory.sol";
import {BeaconFactory} from "../../src/BeaconFactory.sol";
import "forge-std/Test.sol";

abstract contract GameBaseTest is Test {
    BeaconFactory public beaconFactory;
    GameFactory public gameFactory;
    MyCustomGame public game;
    AnotherGame public anotherGame;
    AnotherWallet public playerAOneWallet;
    AnotherWallet public playerATwoWallet;
    AnotherWallet public playerAThreeWallet;
    RandomGame public randomGame;
    address public owner;
    address public owner1;

    function setUp() public virtual {
        owner = _createUser("owner");
        owner1 = _createUser("owner1");
        vm.startPrank(owner);
        address proxy = Upgrades.deployUUPSProxy(
            "GameFactory.sol",
            abi.encodeCall(GameFactory.initialize, ())
        );
        gameFactory = GameFactory(proxy);
        randomGame = new RandomGame();
        anotherGame = AnotherGame(gameFactory.createGame());
        Options memory opts;
        opts.unsafeSkipAllChecks = true;
        beaconFactory = new BeaconFactory(address(anotherGame));
        playerAOneWallet = new AnotherWallet(
            IGame(beaconFactory.createBeaconProxy("0x"))
        );
        playerATwoWallet = new AnotherWallet(
            IGame(beaconFactory.createBeaconProxy("0x"))
        );
        playerAThreeWallet = new AnotherWallet(
            IGame(beaconFactory.createBeaconProxy("0x"))
        );
        vm.stopPrank();
    }

    function _createUser(
        string memory name
    ) internal returns (address payable) {
        (address user, ) = makeAddrAndKey(name);
        vm.deal({account: user, newBalance: 1000 ether});
        vm.label(user, name);
        return payable(user);
    }
}
