import { ethers, upgrades } from "hardhat";

async function main() {
  const MasterChannelLedger = await ethers.getContractFactory(
    "MasterChannelLedger"
  );
  const masterChannelLedger = await upgrades.deployProxy(MasterChannelLedger);
  await masterChannelLedger.waitForDeployment();

  console.log("MasterChannelLedger Address:", masterChannelLedger.target);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
