import 'package:biblio_track_patron_portal/Data/Models/DTOs/notification_summary_dto.dart';

abstract class INotificationSummaryService 
{

Future<NotificationSummaryDTO> getNotificationSummary(int memberRecordID) ;

  
}