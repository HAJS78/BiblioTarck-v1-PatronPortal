import 'package:biblio_track_patron_portal/Data/Models/DTOs/patron_recommendation_dto.dart';

abstract class IPatronRecommendationsRepo 
{

Future<PatronRecommendationDTO> getDashboardData(int memberRecordID);

}