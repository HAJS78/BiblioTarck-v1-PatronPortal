class ChangePasswordResultModel
{
  final bool passwordChanged;
  final String? errorMessage;

  ChangePasswordResultModel({
    required this.passwordChanged,
    this.errorMessage
  });
}