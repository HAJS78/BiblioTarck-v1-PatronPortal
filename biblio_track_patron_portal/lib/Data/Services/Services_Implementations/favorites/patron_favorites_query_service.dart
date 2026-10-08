import 'package:dio/dio.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/member_favorites_dto.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_patron_favorites_query_service.dart';

class PatronFavoritesQueryService implements IPatronFavoritesQueryService
{
  final Dio dio;

  PatronFavoritesQueryService({required this.dio});

  @override
  Future<MemberFavoritesDTO> getFavorites(int memberRecordID) async
  {
    final response = await dio.get('/PatronFavorites/$memberRecordID');

    return MemberFavoritesDTO.fromJson(response.data);
  }
}