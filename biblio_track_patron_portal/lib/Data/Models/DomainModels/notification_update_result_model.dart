class NotificationUpdateResultModel
{
  final bool isUpdated;
  final String? errorMessage;

  NotificationUpdateResultModel({
    required this.isUpdated,
    this.errorMessage
  });
}