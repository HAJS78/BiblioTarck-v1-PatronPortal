class PatronFullNameDTO
{
final String patronFullName;
  final String? errorMessage;

  PatronFullNameDTO({
    required this.patronFullName,
      this.errorMessage
  });

 

  static PatronFullNameDTO fromJson(Map<String, dynamic> json)
   {
    if (json['success'] == true && json['data'] != null) 
    {
      return PatronFullNameDTO(
        patronFullName: json['data']['patronFullName']
       
       
        
      );
    }
    else 
    {
      return PatronFullNameDTO(
        patronFullName:'Unknown Patron',
       errorMessage: json['error'] ?? 'Unknown error');
    }
  }


}