const main = async() => {
    const [owner, randomPerson] = await hre.ethers.getSigners();
    const confessContractFactory = await hre.ethers.getContractFactory('Confess');
    const confessContract = await confessContractFactory.deploy();
    await confessContract.deployed();

    console.log("Contract deployed to:", confessContract.address);
    console.log("Contract deployed to:", confessContract.address);

    let confessCount;
    confessCount = await confessContract.getTotalConfessions();

    let confessTxn = await confessContract.confess();
    await confessTxn.wait();

    confessCount = await confessContract.getTotalConfessions();

    confessTxn = await confessContract.connect(randomPerson).confess();
    await confessTxn.wait();

    confessCount = await confessContract.getTotalConfessions();

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