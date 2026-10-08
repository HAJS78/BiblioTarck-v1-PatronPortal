class UserNameAvailabilityModel
{
  final bool isTaken;
  final String? errorMessage;

  UserNameAvailabilityModel({
    required this.isTaken,
    this.errorMessage
  });
}