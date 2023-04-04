const API_KEY = process.env.API_KEY;
const PRIVATE_KEY = process.env.PRIVATE_KEY;
const CONRACT_ADDRESS = process.env.CONRACT_ADDRESS;
const TEST_ACCOUNT = process.env.TEST_ACCOUNT;

const { LogDescription } = require("ethers/lib/utils");
const { ethers } = require("hardhat"); // reference to ethers
const contract = require("../artifacts/contracts/SBTFactory.sol/SBTFactory.json");

// Provider
const web3Provider = new ethers.providers.AlchemyProvider(
  (network = "goerli"),
  API_KEY
);
// Signer
const signer = new ethers.Wallet(PRIVATE_KEY, web3Provider);

// contract instance
const sbtContract = new ethers.Contract(CONRACT_ADDRESS, contract.abi, signer);
// this line tells that whenever we will be interacting with sbtContract, we will be interacting with contract with
// address: CONTRACT_ADDRESS
// abi: contract.abi
// signer: signer, it will be me who will be signing the contract

async function main() {
  const uni = await sbtContract.uni(); // default getter method for public variables
  console.log("The address of the university is:", uni);

  const addTx = await sbtContract.addStudent(TEST_ACCOUNT, "test-cid");
  await addTx.wait(1); // waiting for this transaction to be mined in the blockchain be waiting till 1 block confirmation(s)
  console.log("addStudent() executed. \n");

  //   const receivedCID = await searchStudent(TEST_ACCOUNT);
  //   console.log("searchStudent() executed. \n");

  console.log("end of main file");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
