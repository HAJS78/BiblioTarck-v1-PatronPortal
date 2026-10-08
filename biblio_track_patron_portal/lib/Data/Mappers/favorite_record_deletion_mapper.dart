import 'package:biblio_track_patron_portal/Data/Models/DTOs/favorite_record_deletion_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/favorite_record_deletion_model.dart';

class FavoriteRecordDeletionMapper 
{
  static FavoriteRecordDeletionModel fromDTO(FavoriteRecordDeletionDTO dto) {
    return FavoriteRecordDeletionModel(
      isDeleted: dto.isDeleted,
      errorMessage: dto.errorMessage,
    );
  }
}