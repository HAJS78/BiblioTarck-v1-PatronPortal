import 'package:biblio_track_patron_portal/Data/Models/DTOs/member_notification_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/notification_update_result_dto.dart';

import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_patron_notifications_service.dart';

class MockPatronNotificationsService implements IPatronNotificationsService
{

  Map<String, dynamic> notificationRetrievalSuccessResponse = 
  {
  "data": {
    "notifications": [
      {
        "notificationId":1,
        "title": "Overdue Item",
        "body": "The following  books are overdue\n 1.Clean Code: A Handbook of Agile Software Craftsmanship\n2.Principles of Chemistry: A Molecular Approach",
        "type": "OverdueItems",
        "isRead": false,
      },
      {
        "notificationId":2,
        "title": "Reserved Item Ready",
        "body": "Your reserved book 'The Pragmatic Programmer' is available to be picked up.",
        "type": "ReservedItems",
        "isRead": false,
      },
    ]
  },
  "error": null,
  "success": true,
};


Map<String, dynamic> notificationRetrievalFailedResponse = 
  {
  "data": null,
  "error": "Error while processing the request",
  "success": true,
};


// after
Map<String, dynamic> notificationUpdateSuccessResponse = 
{
  "data": { "isUpdated": true },
  "error": null,
  "success": true,
};

Map<String, dynamic> notificationUpdateFailedResponse = 
{
  "data": null,
  "error": 'Cannot update status.',
  "success": false,
};
@override
  Future <MemberNotificationDTO>loadNotifications(int memberRecordID)async
  {

       await  Future.delayed(Duration(seconds: 10));
       MemberNotificationDTO dto=MemberNotificationDTO.fromJson(notificationRetrievalSuccessResponse);  //success
       //MemberNotificationDTO dto=MemberNotificationDTO.fromJson( notificationRetrievalFailedResponse); //failure
      
      
       return dto;
  }

@override
Future <NotificationUpdateResultDTO> updateNotificationReccord(int notificationId)async
{
 await  Future.delayed(Duration(seconds: 10));
 
 return NotificationUpdateResultDTO.fromJson(notificationUpdateSuccessResponse); //success
 //return NotificationUpdateResultDTO.fromJson(notificationUpdateFailedResponse); //failure

}

}