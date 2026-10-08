import 'package:biblio_track_patron_portal/Data/Models/DomainModels/favorite_record_creation_model.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/favorite_record_deletion_model.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/member_favorite_record_model.dart';

abstract class IPatronFavoritesManagementRepo 
{

Future<FavoriteRecordCreationModel> addNewFavoriteRecordInDB(MemberFavoriteRecordModel favoriteRecord);
 Future<FavoriteRecordDeletionModel> deleteFavoriteRecordFromDB(int favoriteRecordID);

}