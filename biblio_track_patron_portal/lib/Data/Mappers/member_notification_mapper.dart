import 'package:biblio_track_patron_portal/Data/Mappers/member_notification_message_mapper.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/member_notification_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/member_notification_model.dart';

class MemberNotificationMapper 
{

static MemberNotificationModel fromDTO(MemberNotificationDTO dto) 
  {
    if(dto.errorMessage==null)
    {
    return MemberNotificationModel(
     
       notifications: MemberNotificationMessageMapper.toNotificationMessageModelList(dto.notifications)
    );
    }
   else
   {
   return MemberNotificationModel(
      
      notifications: List.empty(),
      errorMessage: dto.errorMessage,

      
      );


   }




}
}