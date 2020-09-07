pragma solidity ^0.5.14;
library SafeMath {

 

  /**
  * @dev Multiplies two numbers,  throws on overflow.
  */
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    if (a == 0) {
      return 0;
    }
    uint256 c = a * b;
    assert(c / a == b);
    return c;
  }
  
  /**
  * @dev Integer division of two numbers, truncating the quotient.
  */
  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    // assert(b > 0); // Solidity automatically throws when dividing by 0
    uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold
    return c;
  }

 

  /**
  * @dev Subtracts two numbers, throws on overflow (i.e. if subtrahend is greater than minuend).
  */
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b <= a);
    return a - b;
  }

 

  /**
  * @dev Adds two numbers, throws on overflow.
  */
  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    assert(c >= a);
    return c;
  }
}


contract ERC20Basic {
  function totalSupply() public view returns (uint256);
  function balanceOf(address who) public view returns (uint256);
  function transfer(address to, uint256 value) public returns (bool);
  event Transfer(address indexed from, address indexed to, uint256 value);
}



contract ERC20 is ERC20Basic {
  function allowance(address owner, address spender) public view returns (uint256);
  function transferFrom(address from, address to, uint256 value) public returns (bool);
  function approve(address spender, uint256 value) public returns (bool);
  function transfers(address from_,address _to, uint256 _value) public returns (bool);
  event Approval(address indexed owner, address indexed spender, uint256 value);
}





contract Tontine {
    
  struct cercle_tontine 
  {
        string ID_Tontine;
        address Createur;
        uint NBR_P;
        uint Montant;
        uint NBR_cercle;
        string frequence;
        uint date_creation;
        address[] liste_participants;
            mapping (address=> participant) participants;

      
  }
  
   struct participant 
   {
        address participant;
        uint ordre;
    }
    
    mapping (string => cercle_tontine) cercles;
    string[] liste_tontine;
    
    
    function Tontine() public {
        
    }/* constructor*/
    function Creation (string _ID_Tontine, uint NBR_P, uint Montant, uint NBR_cercle, string frequence) public
    {
        cercles[_ID_Tontine].ID_Tontine=_ID_Tontine;
        cercles[_ID_Tontine].NBR_P=NBR_P;
        cercles[_ID_Tontine].Montant=Montant;
        cercles[_ID_Tontine].NBR_cercle=NBR_cercle;
        cercles[_ID_Tontine].frequence=frequence;
        cercles[_ID_Tontine].Createur=msg.sender;
        cercles[_ID_Tontine].date_creation=0;
        liste_tontine.push(_ID_Tontine);
        addParticipant(_ID_Tontine, 1);
    }
    function getTontine(string _ID_Tontine)public view returns(string ,  uint , uint, uint , string, address,uint){

        return(cercles[_ID_Tontine].ID_Tontine,
                cercles[_ID_Tontine].NBR_P,
              cercles[_ID_Tontine].Montant,
             cercles[_ID_Tontine].NBR_cercle,
             cercles[_ID_Tontine].frequence,
             cercles[_ID_Tontine].Createur,
              cercles[_ID_Tontine].date_creation
             );
    } 
    
    /*function createUser(address _userAddress) public {
    User storage user = users[_userAddress];
    // Check that the user did not already exist:
    require(!user.set);
    //Store the user
    users[_userAddress] = User({
        id: _userId,
        name: _userName,
        set: true
    });
}
    Virement (0x0, msg.sender, totalSupply);
    function acceptation() public {}
    */
    
    
     function convertttt() public pure returns (bytes32 result) {
    string memory testFoo = "IMFT";
        assembly {
            result := mload(add(testFoo, 32))
        }
    }

     function addNewToken(bytes32 symbol_, address address_) public returns (bool) {
  tokens[symbol_] = address_;

  return true;
 }
    
    
    mapping(bytes32 => address) public tokens;
   ERC20 public ERC20Interface;
    function Transaction( address sender, address receiver, uint Montant )public 
    { bytes32 symbol_ = convertttt();
               address contract_ = tokens[symbol_];
        ERC20Interface = ERC20(contract_);
        ERC20Interface.transfers(sender, receiver, Montant);
    } 
    
    
     function retrait (string ID_Tontine ) public
     {
        Transaction(msg.sender, address(this),  cercles[ID_Tontine].Montant); 
     }
    
    /*address(this) adresse de ce contrat*/
    
    
    function Virement(string ID_Tontine ,address receiver)public
  {
     Transaction(address (this),receiver,cercles[ID_Tontine].Montant*cercles[ID_Tontine].NBR_P);
  }
  
  
  function ValidTontine (string ID_Tontine) public returns (bool){
        if (cercles[ID_Tontine].liste_participants.length == cercles[ID_Tontine].NBR_P) {
            return true;
        }
        else {
            return false;
        }
  }
    
     function addParticipant(string _ID_Tontine,uint ordre) public 
    {
     cercles[_ID_Tontine].participants[msg.sender].ordre=ordre;
    cercles[_ID_Tontine].participants[msg.sender].participant=msg.sender;
    Transaction(msg.sender,address(this),cercles[_ID_Tontine].Montant);
    }
  }