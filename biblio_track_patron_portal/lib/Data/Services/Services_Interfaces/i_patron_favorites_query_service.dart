import 'package:biblio_track_patron_portal/Data/Models/DTOs/member_favorites_dto.dart';

abstract class IPatronFavoritesQueryService 
{

Future<MemberFavoritesDTO> getFavorites(int memberRecordID);

}