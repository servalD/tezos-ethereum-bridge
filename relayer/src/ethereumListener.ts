import { ethers } from "ethers";
import dotenv from "dotenv";
import VAULT_ABI from "../abi/vault.json";

dotenv.config();

const ETHEREUM_RPC_URL = process.env.ETHEREUM_RPC_URL || "";
const VAULT_CONTRACT_ADDRESS = process.env.VAULT_CONTRACT_ADDRESS || "";


if (!ETHEREUM_RPC_URL || !VAULT_CONTRACT_ADDRESS) {
  console.error("Missing environment variables");
  process.exit(1);
}

const provider = new ethers.JsonRpcProvider(ETHEREUM_RPC_URL);
const contract = new ethers.Contract(VAULT_CONTRACT_ADDRESS, VAULT_ABI.abi, provider);

// contract.on("Deposit", (user, amount) => {
//   console.log(`Deposit détecté : ${user} a déposé ${amount.toString()} tokens.`);
// });

contract.on("RequestUnlock", (user, tezAddress, amount) => {
  console.log(`RequestUnlock détecté : ${user} demande le déverrouillage de ${amount.toString()} tokens pour ${tezAddress}.`);
  // Je lock sur Tezos
  // Je débloque sur Ethereum
});

// contract.on("Unlock", (user, amount) => {
//   console.log(`Unlock détecté : ${user} a déverrouillé ${amount.toString()} tokens.`);
// });

contract.on("Withdraw", (user, amount) => {
  console.log(`Withdraw détecté : ${user} a retiré ${amount.toString()} tokens.`);
  // Je deduis sur Tezos
});

export { contract };
