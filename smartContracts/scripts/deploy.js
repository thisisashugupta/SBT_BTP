async function main() {
  const factory = await ethers.getContractFactory("SBTFactory"); // artifacts -> contracts -> SBTFactory.json // is this the abi for our smart contract
  // this factory is a factory for creating instances of our SBTFactory smart contract

  const contract = await factory.deploy();
  console.log("Contract deployed to address: ", contract.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
