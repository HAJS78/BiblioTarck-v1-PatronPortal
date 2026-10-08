class UserNameAvailabilityDTO
{
  final bool isTaken;
  final String? errorMessage;

  UserNameAvailabilityDTO({
    required this.isTaken,
    this.errorMessage
  });

  static UserNameAvailabilityDTO fromJson(Map<String, dynamic> json)
  {
    try
    {
      if (json['success'] == true && json['data'] != null)
      {
        return UserNameAvailabilityDTO(
          isTaken: json['data']['isTaken'] ?? false,
        );
      }
      else
      {
        return UserNameAvailabilityDTO(
          isTaken: false,
          errorMessage: json['error'] ?? 'Unknown error',
        );
      }
    }
    catch (e)
    {
      return UserNameAvailabilityDTO(
        isTaken: false,
        errorMessage: 'Failed to parse server response: $e',
      );
    }
  }
}