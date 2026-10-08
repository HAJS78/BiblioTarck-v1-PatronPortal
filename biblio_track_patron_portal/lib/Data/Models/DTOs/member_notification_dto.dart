import 'package:biblio_track_patron_portal/Data/Models/DTOs/member_notification_message_dto.dart';

class MemberNotificationDTO 
{

  
  final List<MemberNotificationMessageDTO> notifications;
  final String? errorMessage;

   MemberNotificationDTO({
    required this.notifications,
    this.errorMessage
  });

 

  static  MemberNotificationDTO fromJson(Map<String, dynamic> json)
   {
    if (json['success'] == true && json['data'] != null) 
    {
      return MemberNotificationDTO(
      
        notifications: MemberNotificationMessageDTO.fromJsonList( json['data']['notifications'])
        
      );
    }
    else 
    {
      return MemberNotificationDTO(
       notifications: List.empty(),
        errorMessage: json['error'] ?? 'Unknown error');
    }
  }
}