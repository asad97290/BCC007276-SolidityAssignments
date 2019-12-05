pragma solidity ^0.5.13;

contract StudentContract{
    
    address payable private collegeAddress = 0xaD335c3c503aBd738Af9a7690FB41f9fadcBE91A;
    mapping(uint  => Student)public studentRecord;
    uint public totalNoOfStudent;
    
    enum gender{male,female}
    enum status{online,onsite}

    struct Student{
        string name;
        uint rollNo;
        status myStatus;
        gender mygender;
        string degreeName;
        bool hasValidDegree;
        bool isFeePayed;
    } 
    function setAddress(address payable _address) public{
        collegeAddress = _address;
    }
    function getAddress() public view returns(address payable){
        return collegeAddress;
    }
    function getBalance() public view returns(uint){
        return collegeAddress.balance;
    }
    function payFee(uint _rollNo) public payable{
        require(!studentRecord[_rollNo].isFeePayed);
        studentRecord[_rollNo].hasValidDegree = true;
        studentRecord[_rollNo].isFeePayed = true;
        collegeAddress.transfer(msg.value);
        totalNoOfStudent++;
    }
    function registerStudent(string memory _degreeName,uint _rollNo,string memory _name,gender _gender,status _status) public{
        studentRecord[_rollNo].degreeName = _degreeName;
        studentRecord[_rollNo].rollNo = _rollNo;
        studentRecord[_rollNo].name = _name;
        studentRecord[_rollNo].mygender = _gender;
        studentRecord[_rollNo].myStatus = _status;
    }
}