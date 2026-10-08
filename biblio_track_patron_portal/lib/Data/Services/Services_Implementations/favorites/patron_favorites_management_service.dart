import 'package:dio/dio.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/favorite_record_creation_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/favorite_record_deletion_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/member_favorite_record_dto.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_patron_favorites_management_service.dart';

class PatronFavoritesManagementService implements IPatronFavoritesManagementService
{
  final Dio dio;

  PatronFavoritesManagementService({required this.dio});

  @override
  Future<FavoriteRecordCreationDTO> addNewFavoriteRecordInDB(MemberFavoriteRecordDto favoriteRecord) async
  {
    final response = await dio.post(
      '/PatronFavorites',
      data: {
        'memberRecordID': favoriteRecord.memberRecordID,
        'bookRecordID': favoriteRecord.bookRecordID,
      },
    );

    return FavoriteRecordCreationDTO.fromJson(response.data);
  }

  @override
  Future<FavoriteRecordDeletionDTO> deleteFavoriteRecordFromDB(int favoriteRecordID) async
  {
    final response = await dio.delete('/PatronFavorites/$favoriteRecordID');

    return FavoriteRecordDeletionDTO.fromJson(response.data);
  }
}