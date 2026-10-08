import 'package:biblio_track_patron_portal/Data/Models/DTOs/favorite_record_creation_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/favorite_record_deletion_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/member_favorite_record_dto.dart';

abstract class IPatronFavoritesManagementService 
{

Future<FavoriteRecordCreationDTO> addNewFavoriteRecordInDB(MemberFavoriteRecordDto favoriteRecord);
Future<FavoriteRecordDeletionDTO> deleteFavoriteRecordFromDB(int favoriteRecordID);


}