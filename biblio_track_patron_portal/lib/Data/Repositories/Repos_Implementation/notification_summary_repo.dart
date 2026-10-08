import 'package:biblio_track_patron_portal/Data/Mappers/notification_summary_mapper.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/notification_summary_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/notification_summary_model.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_notification_summary_repo.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_notification_summary_service.dart';

class NotificationSummaryRepo implements INotificationSummaryRepo 

{
  final INotificationSummaryService service;

  NotificationSummaryRepo ({required this.service});



@override
  Future<NotificationSummaryModel> getNotificationSummary(int memberRecordID)async
  {
   NotificationSummaryDTO dto= await service.getNotificationSummary(memberRecordID);

    NotificationSummaryModel model=NotificationSummaryMapper.fromDTO(dto);

     return model;

    
    
  }



}