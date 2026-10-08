class MemberFavoriteRecordDto 
{
final int recordID;
final int memberRecordID;
final int bookRecordID;
final DateTime dateAdded;
final String? errorMessage;

  MemberFavoriteRecordDto({required this.recordID, required this.memberRecordID, required this.bookRecordID,required this.dateAdded,this.errorMessage});



     
   Map<String, dynamic> toJson() 
      {
          
            return
            {
              "recordID":-1,
              "memberRecordID": memberRecordID,
              "bookRecordID": bookRecordID,
              "dateAdded": dateAdded.toIso8601String(),
              
            };
      } 

  static MemberFavoriteRecordDto fromJson(Map<String, dynamic> json)
  {
    //try catch must be implemented in other dtos from json
    try 
    {
          if (json['success'] == true && json['data'] != null)
          {
            return MemberFavoriteRecordDto(
              recordID: json['data']['recordID'],
              memberRecordID: json['data']['memberRecordID'],
              bookRecordID: json['data']['bookRecordID'],
              dateAdded: DateTime.parse(json['data']['dateAdded']),
            );
          }
          else
          {
            return MemberFavoriteRecordDto(
              recordID: -1,
              memberRecordID: -1,
              bookRecordID: -1,
              dateAdded: DateTime.now(),
              errorMessage: json['error'] ?? 'Unknown error',
            );
          }
    }

    catch (e)
  {
    return MemberFavoriteRecordDto(
      recordID: -1,
      memberRecordID: -1,
      bookRecordID: -1,
      dateAdded: DateTime.now(),
      errorMessage: 'Failed to parse server response: $e',
    );
  }

  }
  

}