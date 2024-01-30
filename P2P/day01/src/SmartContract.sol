// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract SmartContract {
    uint256 public halfAnswerOfLife = 21;
    int256 private _youAreACheater = -42;
    string public PoCIsWhat = "PoC is good, PoC is life.";
    bool public _areYouABadPerson = false;
    address public myEthereumContractAddress = address(this);
    address public myEthereumAddress = msg.sender;

    bytes public whoIsTheBest = hex"4c75636173206327657374206c65206265737400000000000000000000000000";
    mapping(string => uint256) public myGrades;
    string[] public myPhoneNumber = ["06", "65", "70", "67", "61"];
    enum Role { STUDENT, TEACHER }
    struct Informations {
        string firstName;
        string lastName;
        uint8 age;
        string city;
        Role role;
    }
    Informations public myInformations;

    mapping(address => uint256) public balances;

    event BalanceUpdated(address indexed account, uint256 newBalance);

    function getHalfAnswerOfLife() public view returns (uint256) {
        return halfAnswerOfLife;
    }

    function _getMyEthereumContractAddress() public view returns (address) {
        return myEthereumContractAddress;
    }

    function getPoCIsWhat() external view returns (string memory) {
        return PoCIsWhat;
    }

    function _setAreYouABadPerson(bool _value) public {
        _areYouABadPerson = _value;
    }

    function editMyCity(string memory _city) public {
        myInformations.city = _city;
    }

    function getMyFullName() public view returns (string memory) {
        return string(abi.encodePacked(myInformations.firstName, " ", myInformations.lastName));
    }

    function getMyCity() public view returns (string memory) {
        return myInformations.city;
    }

    constructor() {
        myInformations = Informations("John", "Doe", 30, "New York", Role.STUDENT);
    }

    function completeHalfAnswerOfLife() public onlyOwner {
        halfAnswerOfLife += 21;
    }

    modifier onlyOwner() {
        require(msg.sender == myEthereumAddress, "Only the owner can call this function");
        _;
    }

        function hashMyMessage(string memory _message) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_message));
    }

    function getMyBalance() public view returns (uint256) {
        return balances[msg.sender];
    }

    function addToBalance(uint256 value) public payable {
        emit BalanceUpdated(myEthereumAddress, balances[msg.sender]);
        balances[msg.sender] += value;
        emit BalanceUpdated(myEthereumAddress, balances[msg.sender]);
    }

    function withdrawFromBalance(uint256 _amount) public {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        // (bool success, ) = msg.sender.call{value: _amount}("");
        // require(success, "Transfer failed");
        balances[msg.sender] -= _amount;
    }
}
