var RobotGame = artifacts.require("./robotgame/Start.sol");
module.exports = function(deployer) {
  deployer.deploy(RobotGame);
};