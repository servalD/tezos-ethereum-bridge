

all-devnet: deploy-anvil

all-testnet: deploy-sepolia

deploy-sepolia:
	forge script foundry/script/vault.s.sol --rpc-url $(SEPOLIA_RPC_URL) --broadcast --private-key $(SEPOLIA_PRIVATE_KEY)

deploy-anvil:
	forge script foundry/script/vault.s.sol --rpc-url $(ANVIL_RPC_URL) --broadcast --private-key $(ANVIL_PRIVATE_KEY)

