import 'package:biblio_track_patron_portal/Data/Models/DTOs/member_notification_message_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/member_notification_message_model.dart';


class MemberNotificationMessageMapper 
{
static MemberNotificationMessageModel fromDTO(MemberNotificationMessageDTO dto) 
  {
    
   return MemberNotificationMessageModel(notificationId:dto.notificationId, title: dto.title, body: dto.body, type:dto. type, isRead: dto.isRead);
  

  }

static List<MemberNotificationMessageModel> toNotificationMessageModelList(List<MemberNotificationMessageDTO> list)
{

   late List<MemberNotificationMessageModel> notificationsList=[];
  
   for(var n in list)
   {
      notificationsList.add(MemberNotificationMessageModel(notificationId: n.notificationId, title: n.title, body: n.body, type: n.type, isRead: n.isRead));


   }

   return notificationsList;




}
}