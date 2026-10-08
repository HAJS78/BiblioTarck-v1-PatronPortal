import 'package:biblio_track_patron_portal/Data/Models/DomainModels/member_notification_model.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/notification_update_result_model.dart';

abstract class IPatronNotificationsRepo 
{

Future <MemberNotificationModel>loadNotifications(int memberRecordID);
 Future <NotificationUpdateResultModel> updateNotificationReccord(int notificationId);

}