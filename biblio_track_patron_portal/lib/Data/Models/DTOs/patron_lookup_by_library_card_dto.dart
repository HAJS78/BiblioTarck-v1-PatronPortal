class PatronLookupByLibraryCardDTO
{
  final int memberRecordID;
  final String? errorMessage;

  PatronLookupByLibraryCardDTO({
    required this.memberRecordID,
      this.errorMessage
  });

 

  static PatronLookupByLibraryCardDTO fromJson(Map<String, dynamic> json)
   {
    if (json['success'] == true && json['data'] != null) 
    {
      return PatronLookupByLibraryCardDTO(
        memberRecordID: json['data']['memberRecordID']
       
       
        
      );
    }
    else 
    {
      return PatronLookupByLibraryCardDTO(
        memberRecordID: -1,
       errorMessage: json['error'] ?? 'Unknown error');
    }
  }
}