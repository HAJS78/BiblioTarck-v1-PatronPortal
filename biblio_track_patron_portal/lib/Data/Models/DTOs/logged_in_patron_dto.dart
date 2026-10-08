class LoggedInPatronDTO 
{
  final int memberRecordID;
  final int personRecordID;
  final String userName;
  
  final String? photoUrl;
  
  
   LoggedInPatronDTO ({
    required this.memberRecordID,
    required this.personRecordID,
    required this.userName,
    this.photoUrl,
    
  });

 

  static  LoggedInPatronDTO  fromJson(Map<String, dynamic> json)
   {
    if (json['success'] == true && json['data'] != null) 
    {
      return  LoggedInPatronDTO (
        memberRecordID: json['data']['memberRecordID'],
        personRecordID: json['data']['personRecordID'],
        userName: json['data']['userName'],
        photoUrl: json['data']['photoUrl'],
       
      );
    }
    else 
    {
      return  LoggedInPatronDTO (
        memberRecordID: -1,
        personRecordID: -1,
        userName: 'N/A',
        photoUrl: null);
      
    }
  }
}