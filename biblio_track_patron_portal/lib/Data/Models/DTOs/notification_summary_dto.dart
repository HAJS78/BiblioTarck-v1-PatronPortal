class NotificationSummaryDTO
{
  final int overdueItemsCount;
  final int reservedItemsCount;
  
  
  final String? errorMessage;

  NotificationSummaryDTO({
    required this.overdueItemsCount,
    required this.reservedItemsCount,
   
    this.errorMessage
  });

 

  static NotificationSummaryDTO fromJson(Map<String, dynamic> json)
   {
    if (json['success'] == true && json['data'] != null) 
    {
      return NotificationSummaryDTO(
        overdueItemsCount: json['data']['overdueItemsCount'],
        reservedItemsCount: json['data']['reservedItemsCount'],
        
        
      );
    }
    else 
    {
      return NotificationSummaryDTO(
       overdueItemsCount: 0,
        reservedItemsCount: 0,
        errorMessage: json['error'] ?? 'Unknown error');
    }
  }
}