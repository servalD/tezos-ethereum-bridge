

all-devnet: deploy-anvil

all-testnet: deploy-sepolia

deploy-sepolia:
	forge script foundry/script/vault.s.sol --rpc-url $$(SEPOLIA_RPC_URL) --broadcast --private-key $$(SEPOLIA_PRIVATE_KEY)

deploy-anvil:
	cd foundry && forge script script/deploy.s.sol --rpc-url http://$$(ANVIL_RPC_URL) --private-key $$(ANVIL_PRIVATE_KEY)

