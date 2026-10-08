class PatronLookupByEmailDTO
{
  final int memberRecordID;
  final String? errorMessage;

  PatronLookupByEmailDTO({
    required this.memberRecordID,
      this.errorMessage
  });

 

  static PatronLookupByEmailDTO fromJson(Map<String, dynamic> json)
   {
    if (json['success'] == true && json['data'] != null) 
    {
      return PatronLookupByEmailDTO(
        memberRecordID: json['data']['memberRecordID']
       
       
        
      );
    }
    else 
    {
      return PatronLookupByEmailDTO(
        memberRecordID: -1,
       errorMessage: json['error'] ?? 'Unknown error');
    }
  }
}