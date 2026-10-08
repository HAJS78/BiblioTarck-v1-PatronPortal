import 'package:biblio_track_patron_portal/Data/Models/DTOs/favorite_record_creation_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/favorite_record_creation_model.dart';

class FavoriteRecordCreationMapper 
{
  static FavoriteRecordCreationModel fromDTO(FavoriteRecordCreationDTO dto) {
    return FavoriteRecordCreationModel(
      favoriteRecordID: dto.favoriteRecordID,
      errorMessage: dto.errorMessage,
    );
  }
}