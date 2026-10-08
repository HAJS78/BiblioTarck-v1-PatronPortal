import 'package:biblio_track_patron_portal/Data/Models/DTOs/member_notification_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/notification_update_result_dto.dart';

abstract class IPatronNotificationsService 
{

Future <MemberNotificationDTO>loadNotifications(int memberRecordID);
Future <NotificationUpdateResultDTO> updateNotificationReccord(int notificationId);

}