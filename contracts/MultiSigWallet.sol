pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

contract MultiSigWallet {

  uint minApprovers;

  address payable beneficiary;
  address payable owner;

  mapping (address => bool) approvedBy;
  mapping (address => bool) isApprover;

  uint approversNum;

  constructor(address[] memory _approvers, uint _minApprovers, address payable _beneficiary ) public {
    require(_minApprovers <= _approvers.length, "Required number of approvers should be less than number of approvers");

    minApprovers = _minApprovers;
    beneficiary = _beneficiary;
    owner = msg.sender;

    for(uint i = 0; i < _approvers.length; i++){
      address approver = _approvers[i];
      isApprover[approver] = true;
    }
  }


  /**
    msg.sender is the intended approver with regards to
    this method
   */
  function approve() public {
      require(isApprover[msg.sender], "Not an Approver");
      
      // check if msg.sender has already approved transaction
      if(!approvedBy[msg.sender]){
        approversNum++;
        approvedBy[msg.sender] = true;
      }

      if(approversNum == minApprovers){
        bool succeeded = beneficiary.send(address(this).balance);
        if(!succeeded){
          selfdestruct(owner);
        }
      } 
  }

  function reject() public {
    require(isApprover[msg.sender], "Not an Approver");
    selfdestruct(owner);
  }
}
