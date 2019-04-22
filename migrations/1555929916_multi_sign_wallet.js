const Migrations = artifacts.require("MultiSigWallet");

module.exports = function (deployer) {
  deployer.deploy(Migrations, [
    "0x16bB83dA9b12Ab08e79D75E22D483CB90e55EA79",
    "0x9E91D5412a33393542eCaF6393682B644b241B15",
    "0x7D13A39AfBdc5278751eed5074C4aD6925890153"
  ], 2, "0x63C710532d2dBF88CEe65b6b5159E8410507D118");
};
