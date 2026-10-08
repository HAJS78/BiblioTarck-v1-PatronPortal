class MemberFavoriteRecordModel 
{
final int recordID;
final int memberRecordID;
final int bookRecordID;
final DateTime dateAdded;
final String? errorMessage;

  MemberFavoriteRecordModel({required this.recordID, required this.memberRecordID, required this.bookRecordID,required this.dateAdded,this.errorMessage});



     
   
}