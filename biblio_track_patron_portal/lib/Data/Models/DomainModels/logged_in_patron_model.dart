class LoggedInPatronModel 
{
  final int memberRecordID;
  final int personRecordID;
  final String userName;
  final String? photoUrl;
  
  
   LoggedInPatronModel  ({
    required this.memberRecordID,
    required this.personRecordID,
    required this.userName,
    this.photoUrl,
    
  });

 

  
}