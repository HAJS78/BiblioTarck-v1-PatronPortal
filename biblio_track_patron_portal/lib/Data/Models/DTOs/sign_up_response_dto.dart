class SignUpResponseDTO 
{
  final bool isSignedUp;
  final String? errorMessage;

  SignUpResponseDTO({
    required this.isSignedUp,
      this.errorMessage
  });

 

  static SignUpResponseDTO fromJson(Map<String, dynamic> json)
   {
    if (json['success'] == true && json['data'] != null) 
    {
      return SignUpResponseDTO(
        isSignedUp: json['data']['isSignedUp']
       
       
        
      );
    }
    else 
    {
      return SignUpResponseDTO(
        isSignedUp:false,
       errorMessage: json['error'] ?? 'Unknown error');
    }
  }
}