import 'package:biblio_track_patron_portal/Data/Models/DTOs/notification_update_result_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/notification_update_result_model.dart';

class NotificationUpdateResultMapper
{
  static NotificationUpdateResultModel fromDTO(NotificationUpdateResultDTO dto)
  {
    return NotificationUpdateResultModel(
      isUpdated: dto.isUpdated,
      errorMessage: dto.errorMessage
    );
  }
}