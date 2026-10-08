import 'package:biblio_track_patron_portal/Data/Mappers/book_card_mapper.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/member_favorites_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/member_favorites_model.dart';
 
class MemberFavoritesMapper
{
 
  // DTO → Domain Model (used in Repo after service call)
  static MemberFavoritesModel fromDTO(MemberFavoritesDTO dto)
  {
    if(dto.errorMessage==null)
    {
    return MemberFavoritesModel(
      memberFavorites: BookCardMapper.toBookModelList(dto.memberFavorites)
    );
    }
   else
   {
   return MemberFavoritesModel(
      memberFavorites: List.empty(),
      errorMessage: dto.errorMessage,
      );
 
   }
 
  }
 
}