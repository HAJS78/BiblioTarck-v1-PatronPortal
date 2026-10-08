import 'package:dio/dio.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/member_notification_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/notification_update_result_dto.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_patron_notifications_service.dart';

class PatronNotificationsService implements IPatronNotificationsService
{
  final Dio dio;

  PatronNotificationsService({required this.dio});

  @override
  Future<MemberNotificationDTO> loadNotifications(int memberRecordID) async
  {
    final response = await dio.get('/PatronNotifications/$memberRecordID');

    return MemberNotificationDTO.fromJson(response.data);
  }

  @override
  Future<NotificationUpdateResultDTO> updateNotificationReccord(int notificationId) async
  {
    final response = await dio.put('/PatronNotifications/$notificationId');

    return NotificationUpdateResultDTO.fromJson(response.data);
  }
}