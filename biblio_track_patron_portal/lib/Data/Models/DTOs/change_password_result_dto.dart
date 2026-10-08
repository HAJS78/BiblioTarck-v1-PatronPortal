class ChangePasswordResultDTO
{
  final bool passwordChanged;
  final String? errorMessage;

  ChangePasswordResultDTO({
    required this.passwordChanged,
    this.errorMessage
  });

  static ChangePasswordResultDTO fromJson(Map<String, dynamic> json)
  {
    if (json['success'] == true && json['data'] != null)
    {
      return ChangePasswordResultDTO(
        passwordChanged: json['data'] as bool
      );
    }
    else
    {
      return ChangePasswordResultDTO(
        passwordChanged: false,
        errorMessage: json['error'] ?? 'Unknown error'
      );
    }
  }
}