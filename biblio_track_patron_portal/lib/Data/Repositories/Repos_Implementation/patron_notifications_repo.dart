import 'package:biblio_track_patron_portal/Data/Mappers/member_notification_mapper.dart';
import 'package:biblio_track_patron_portal/Data/Mappers/notification_update_result_mapper.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/member_notification_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/notification_update_result_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/member_notification_model.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/notification_update_result_model.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_patron_notifications_repo.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_patron_notifications_service.dart';

class PatronNotificationsRepo implements IPatronNotificationsRepo
{

 final IPatronNotificationsService service;

 PatronNotificationsRepo({required this.service});


 @override
Future <MemberNotificationModel>loadNotifications(int memberRecordID)async
{

 MemberNotificationDTO dto=await service.loadNotifications(memberRecordID);
 return MemberNotificationMapper.fromDTO(dto);

}

@override
 Future <NotificationUpdateResultModel> updateNotificationReccord(int notificationId)async
 {
    
    
     NotificationUpdateResultDTO dto = await service.updateNotificationReccord(notificationId);
     return NotificationUpdateResultMapper.fromDTO(dto);
 }

}