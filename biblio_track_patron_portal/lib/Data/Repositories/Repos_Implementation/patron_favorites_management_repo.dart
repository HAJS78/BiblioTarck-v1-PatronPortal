import 'package:biblio_track_patron_portal/Data/Mappers/favorite_record_creation_mapper.dart';
import 'package:biblio_track_patron_portal/Data/Mappers/favorite_record_deletion_mapper.dart';
import 'package:biblio_track_patron_portal/Data/Mappers/member_favorite_record_mapper.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/favorite_record_creation_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/favorite_record_deletion_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/member_favorite_record_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/favorite_record_creation_model.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/favorite_record_deletion_model.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/member_favorite_record_model.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_patron_favorites_management_repo.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_patron_favorites_management_service.dart';

class PatronFavoritesManagementRepo implements IPatronFavoritesManagementRepo
{

final IPatronFavoritesManagementService service;

  PatronFavoritesManagementRepo({required this.service});


@override
Future<FavoriteRecordCreationModel> addNewFavoriteRecordInDB(MemberFavoriteRecordModel favoriteRecord)async
{
 
MemberFavoriteRecordDto dto=MemberFavoriteRecordMapper.toDTO(favoriteRecord);//dto to db
FavoriteRecordCreationDTO dto1=await service.addNewFavoriteRecordInDB(dto);  //returned response dto
return   FavoriteRecordCreationMapper.fromDTO(dto1);

}

@override
Future<FavoriteRecordDeletionModel> deleteFavoriteRecordFromDB(int favoriteRecordID)async
{
   FavoriteRecordDeletionDTO dto=await service.deleteFavoriteRecordFromDB(favoriteRecordID);
     return  FavoriteRecordDeletionMapper.fromDTO(dto);
}


}