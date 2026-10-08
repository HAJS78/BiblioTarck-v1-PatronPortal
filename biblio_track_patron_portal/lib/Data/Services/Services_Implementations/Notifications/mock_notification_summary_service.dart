import 'package:biblio_track_patron_portal/Data/Models/DTOs/notification_summary_dto.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_notification_summary_service.dart';

class MockNotificationSummaryService implements INotificationSummaryService
{
//1
final Map<String, dynamic> notificationSummaryDataSuccessResponse =
 {
  "data":
  { 
  
    "overdueItemsCount":3,
    "reservedItemsCount":1

  },
    "error": null,
    "success": true,
};

final Map<String, dynamic> notificationSummaryDataFailedResponse =
 {
  "data":null,
  "error": "Error while processing request",
  "success": true,
};

 @override
  Future<NotificationSummaryDTO> getNotificationSummary(int memberRecordID) async
  {
   await Future.delayed(const Duration(milliseconds: 500));
  
   return NotificationSummaryDTO.fromJson (notificationSummaryDataSuccessResponse); //success
   //return NotificationSummaryDTO.fromJson (notificationSummaryDataFailedResponse); //failure
    
  }


}