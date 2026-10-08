import 'package:biblio_track_patron_portal/Data/Models/DomainModels/patron_recommendation_model.dart';

abstract class IPatronRecommendationRepo 
{

Future<PatronRecommendationModel> getRecommendedBooks(int memberRecordID);

}