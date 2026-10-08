import 'package:biblio_track_patron_portal/Data/Mappers/member_favorites_mapper.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/member_favorites_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/member_favorites_model.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_patron_favorites_query_repo.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_patron_favorites_query_service.dart';

class PatronFavoritesQueryRepo implements IPatronFavoritesQueryRepo
{

final IPatronFavoritesQueryService service;
 
PatronFavoritesQueryRepo({required this.service});

@override
Future<MemberFavoritesModel> getFavorites(int memberRecordID)async
{

   MemberFavoritesDTO dto=await service.getFavorites(memberRecordID);

   return MemberFavoritesMapper.fromDTO(dto);
}



}