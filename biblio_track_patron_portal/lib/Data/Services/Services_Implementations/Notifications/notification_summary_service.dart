import 'package:biblio_track_patron_portal/Data/Models/DTOs/notification_summary_dto.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_notification_summary_service.dart';
import 'package:dio/dio.dart';

class NotificationSummaryService implements INotificationSummaryService
{
  final Dio dio;

  NotificationSummaryService({required this.dio});

  @override
  Future<NotificationSummaryDTO> getNotificationSummary(int memberRecordID) async
  {
    final response = await dio.get(
      '/NotificationSummary/$memberRecordID',
    );

    return NotificationSummaryDTO.fromJson(response.data);
  }
}