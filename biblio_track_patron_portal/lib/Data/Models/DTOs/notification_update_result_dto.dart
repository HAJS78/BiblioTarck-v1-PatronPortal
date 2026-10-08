class NotificationUpdateResultDTO
{
  final bool isUpdated;
  final String? errorMessage;

  NotificationUpdateResultDTO({
    required this.isUpdated,
    this.errorMessage
  });

  static NotificationUpdateResultDTO fromJson(Map<String, dynamic> json)
  {
    try
    {
      if (json['success'] == true && json['data'] != null)
      {
        return NotificationUpdateResultDTO(
          isUpdated: json['data']['isUpdated'] ?? false,
        );
      }
      else
      {
        return NotificationUpdateResultDTO(
          isUpdated: false,
          errorMessage: json['error'] ?? 'Unknown error',
        );
      }
    }
    catch (e)
    {
      return NotificationUpdateResultDTO(
        isUpdated: false,
        errorMessage: 'Failed to parse server response: $e',
      );
    }
  }
}