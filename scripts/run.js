const main = async() => {
    const confessContractFactory = await hre.ethers.getContractFactory('Confess');
    const confessContract = await confessContractFactory.deploy();
    await confessContract.deployed();

    console.log("Contract deployed to:", confessContract.address);

    let confessCount;
    confessCount = await confessContract.getTotalConfessions();
    console.log(confessCount.toNumber());

    let confessTxn = await confessContract.confess('A message');
    await confessTxn.wait();

    const [_, randomPerson] = await hre.ethers.getSigners();
    confessTxn = await confessContract.connect(randomPerson).confess('Another message!');
    await confessTxn.wait();



    let allConfessions = await confessContract.getAllConfessions();
    console.log(allConfessions);

};

const runMain = async() => {
    try {
        await main();
        process.exit(0);
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
};

runMain();