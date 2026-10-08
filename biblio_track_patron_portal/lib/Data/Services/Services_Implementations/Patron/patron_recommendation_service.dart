import 'package:biblio_track_patron_portal/Data/Models/DTOs/patron_recommendation_dto.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_patron_recommendation_service.dart';
import 'package:dio/dio.dart';


class PatronRecommendationService implements IPatronRecommendationsService
{
  
  final Dio dio;

  PatronRecommendationService({required this.dio});

  @override
  Future<PatronRecommendationDTO> getRecommendedBooks(int memberRecordID) async
  {
    final response = await dio.get(
      '/PatronRecommendation/$memberRecordID',
    );
    return PatronRecommendationDTO.fromJson(response.data);

  }







}