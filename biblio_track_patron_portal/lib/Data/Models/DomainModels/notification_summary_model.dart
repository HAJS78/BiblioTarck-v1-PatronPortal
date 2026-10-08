class NotificationSummaryModel
{
  final int overdueItemsCount;
  final int reservedItemsCount;
    final String? errorMessage;

  NotificationSummaryModel({
    
    required this.overdueItemsCount,
    required this.reservedItemsCount,
   
   
    this.errorMessage
  });
}