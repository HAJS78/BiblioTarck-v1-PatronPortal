import 'package:biblio_track_patron_portal/Data/Models/DomainModels/notification_summary_model.dart';

abstract class INotificationSummaryRepo 
{
Future<NotificationSummaryModel> getNotificationSummary(int memberRecordID);


}