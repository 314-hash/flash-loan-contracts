const hre = require("hardhat");

async function main() {
  const provider = "0x..."; // Aave PoolAddressesProvider for the testnet
  const FlashLoanArbitrage = await hre.ethers.getContractFactory("FlashLoanArbitrage");
  const contract = await FlashLoanArbitrage.deploy(provider);
  await contract.deployed();

  console.log("✅ FlashLoanArbitrage deployed to:", contract.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
