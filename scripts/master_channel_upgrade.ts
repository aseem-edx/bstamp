import { ethers, upgrades } from "hardhat";

const { MASTER_CHANNEL_ADDRESS } = process.env;

async function main() {
  const MasterChannelLedger = await ethers.getContractFactory(
    "MasterChannelLedger"
  );
  const masterChannelLedger = await upgrades.upgradeProxy(
    MASTER_CHANNEL_ADDRESS!,
    MasterChannelLedger
  );
  console.log("MasterChannelLedger Updated");
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
