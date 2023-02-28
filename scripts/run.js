const main = async() => {
  // This will compile our contract and generate the necessary files we need to work with our contract under the artifacts directory.
  const whiteListNFTContractFactory = await hre.ethers.getContractFactory("WhiteListNFT");
  const whitelistContractNFT = await whiteListNFTContractFactory.deploy();

  //We'll wait until our contract is officially deployed to our local blockchain! Our constructor runs when we deploy.
  await whitelistContractNFT.deployed();
  console.log("whitelist contract deployed to: ", whitelistContractNFT.address);
};

const runMain = async() => {
  try {
    await main();
    process.exit(0);
  } catch(err) {
    console.log(err);
    process.exit(0);
  }
};

runMain();