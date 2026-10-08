import 'package:biblio_track_patron_portal/Data/Models/DTOs/favorite_record_creation_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/favorite_record_deletion_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/member_favorite_record_dto.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_patron_favorites_management_service.dart';

class MockPatronFavoritesManagementService implements IPatronFavoritesManagementService
{

  final Map<String, dynamic> _addNewFavoriteSuccessResponse = {
    "data": {
      "favoriteRecordID": 10,
    },
    "error": null,
    "success": true
  };

  // final Map<String, dynamic> _addNewFavoriteFailedResponse = {
  //   "data": null,
  //   "error": "Failed to add book to favorites.",
  //   "success": false
  // };

 @override
Future<FavoriteRecordCreationDTO> addNewFavoriteRecordInDB(MemberFavoriteRecordDto favoriteRecord)async
{
await  Future.delayed(Duration(seconds: 10));//simualte network work

return FavoriteRecordCreationDTO.fromJson(_addNewFavoriteSuccessResponse);
    // return FavoriteRecordCreationDTO.fromJson(_addNewFavoriteFailedResponse); // failure toggle

}

final Map<String, dynamic> _deleteFavoriteSuccessResponse = 
{
    "data": {
      "isDeleted": true,
    },
    "error": null,
    "success": true
  };

  // final Map<String, dynamic> _deleteFavoriteFailedResponse = {
  //   "data": null,
  //   "error": "Failed to remove book from favorites.",
  //   "success": false
  // };

@override
  Future<FavoriteRecordDeletionDTO> deleteFavoriteRecordFromDB(int favoriteRecordID)async
  {

    await  Future.delayed(Duration(seconds: 10));
    return FavoriteRecordDeletionDTO.fromJson(_deleteFavoriteSuccessResponse);
    // return FavoriteRecordDeletionDTO.fromJson(_deleteFavoriteFailedResponse); // failure toggle
   
  }


}