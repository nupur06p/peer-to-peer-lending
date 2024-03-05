// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

contract P2P{

    struct lender{
        string name_l;
        string address_l;
        uint aadhar_l;
        uint bank_account;
        uint routing_number;
        string[4] type_investment;
        bool loan_request;
    }

    struct borrower{
        string name_b;
        string address_b;
        address borrower_address;
        uint aadhar_b; 
        string loan_reason;  
    }

    struct collateral{
        string proof_of_address;
        string proof_of_income;
        string emp_verification;
        string loan_app_form;
        string bank_statement;
        string cryptocoin_name;
        string cryptocoin_symbol;
        uint amt_cryptocoin;
    }

    //mapping struct lender to an array
    mapping(uint=>lender) public lenders;

    //mapping struct borrower to an array
    mapping(uint=>borrower) public borrowers;
    mapping(uint=>collateral) collaterals;

    //defining an array of collaterals
    collateral[] public collat_array; 

    //defining number of borrowers and lenders
    uint public numBorrowers;
    uint public numLenders;
    address address_borrower;
    

    //updating the lenders
    function lenderUpdate(string memory name_l, string memory address_l, uint aadhar_l, uint bank_account, uint routing_number, string[4] memory type_investment, bool loan_request) private{
        lenders[numLenders] = lender(name_l, address_l, aadhar_l, bank_account, routing_number, type_investment, loan_request); 
        numLenders++; 
    }


    //updating the borrower details
    function borrowerUpdate(string memory name_b, string memory address_b, address b_address, uint aadhar_b, string memory loan_reason) public {
        address_borrower = b_address;
        borrowers[numBorrowers] = borrower(name_b, address_b, b_address, aadhar_b, loan_reason);
    }

    //updating collaterals
    function getCollateral(string memory poa, string memory poi, string memory empv, string memory loan_af, string memory bank_stat, string memory coin_n, string memory coin_sym, uint amt_coin) private {
        collateral storage c = collaterals[numBorrowers];
        collaterals[numBorrowers] = collateral(poa, poi, empv, loan_af, bank_stat, coin_n, coin_sym, amt_coin);
        collat_array.push(c);
        numBorrowers++;
    }

    //collateral details
    function collateralArray(string memory proof_of_address, string memory proof_of_income, string memory emp_verification, string memory loan_app_form, string memory bank_statement, string memory coin_name, string memory coin_symbol, uint amount) public onlyBorrower(){
        getCollateral(proof_of_address, proof_of_income, emp_verification, loan_app_form, bank_statement, coin_name, coin_symbol, amount);
    }
    
    constructor(){
        string[4] memory _typeInvestment = ["Education", "Health", "Small scale Industry", "Housing"];
        lenderUpdate("Ambani", "Borivali Mumbai", 6587593700, 100000006789345, 4567890234, _typeInvestment, false);
    }

    //borrower's request 
    function loanRequest() public view returns(borrower[] memory){
        borrower[] memory borrowerArray = new borrower[](numBorrowers);
        for(uint i=0; i < numBorrowers; i++) {
            borrowerArray[i] = borrowers[i];
        }
        return borrowerArray;
    }

    //modifier for borrower
    modifier onlyBorrower() {
        require(msg.sender==address_borrower, "It can be executed only by the borrower");
        _;
    }
}



