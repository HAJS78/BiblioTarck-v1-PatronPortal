import 'package:biblio_track_patron_portal/Data/Models/DTOs/notification_summary_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/notification_summary_model.dart';

class NotificationSummaryMapper
{

  // DTO → Domain Model (used in Repo after service call)
  static NotificationSummaryModel fromDTO(NotificationSummaryDTO dto) 
  {
    if(dto.errorMessage==null)
    {
    return NotificationSummaryModel(
      overdueItemsCount: dto.overdueItemsCount,
      reservedItemsCount: dto.reservedItemsCount,
       
    );
    }
   else
   {
   return NotificationSummaryModel(
       overdueItemsCount: 0,
       reservedItemsCount: 0,
       errorMessage: dto.errorMessage,

      
      );


   }

  }

  
  
}