class MemberNotificationMessageModel 
{
final int notificationId;
  final String title; 
  final String body;  
  final String type; 
  final bool isRead;

  MemberNotificationMessageModel({required this.notificationId, required this.title, 
  required this.body, required this.type, required this.isRead});

  
}