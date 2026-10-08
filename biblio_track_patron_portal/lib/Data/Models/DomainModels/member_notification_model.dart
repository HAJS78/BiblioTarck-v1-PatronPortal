import 'package:biblio_track_patron_portal/Data/Models/DomainModels/member_notification_message_model.dart';

class MemberNotificationModel 
{

   final List<MemberNotificationMessageModel> notifications;
  final String? errorMessage;

   MemberNotificationModel({
    required this.notifications,
    this.errorMessage
  });
}