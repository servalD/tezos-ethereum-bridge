// SPDX-License-Identifier: AGPL-3.0
pragma solidity ^0.8.25;

import "forge-std/Script.sol";
import "../src/vault.sol";
import "../src/token.sol";

contract Deployment is Script {

    Token token;
    Vault vault;

    function run() external {
        uint256 deployer = vm.envUint("ANVIL_PRIVATE_KEY");
        address deployerAddress = vm.addr(deployer);

        vm.startBroadcast(deployer);

        token = new Token("Test Token", "TST", 1000000);

        vault = new Vault(deployerAddress);
        
        console.log("Vault deployed at:", address(vault));

        vm.stopBroadcast();
    }
}
