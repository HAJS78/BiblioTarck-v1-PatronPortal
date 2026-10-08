import 'package:biblio_track_patron_portal/Data/Models/DTOs/patron_recommendation_dto.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_patron_recommendation_service.dart';

class MockPatronRecommendationService implements IPatronRecommendationsService
{

//1
final Map<String, dynamic> dashboardDataSuccessResponse =
   {
  "data": 
  {
    "recommendedBooks": 
    [
      {
        "bookRecordID": 1,
        "title": "Clean Code",
        "author": "Robert C. Martin",
        "bookCoverImageUrl": "",
        "inFavorites": true,
        "favoriteRecordID": 1,
      },
      {
        "bookRecordID": 2,
        "title": "Principles of Chemistry",
        "author": "Nivaldo J. Tro",
        "bookCoverImageUrl": "",
        "inFavorites":true,
        "favoriteRecordID": null,
      },
      {
        "bookRecordID": 3,
        "title": "The Pragmatic Programmer",
        "author": "Andrew Hunt & David Thomas",
        "bookCoverImageUrl": "",
        "inFavorites": false,
        "favoriteRecordID": null,
      },
      {
        "bookRecordID": 4,
        "title": "Design Patterns",
        "author": "Erich Gamma et al.",
        "bookCoverImageUrl": "",
        "inFavorites": false,
        "favoriteRecordID": 2,
      },
      {
        "bookRecordID": 5,
        "title": "Introduction to Algorithms",
        "author": "Cormen, Leiserson, Rivest, Stein",
        "bookCoverImageUrl": "",
        "inFavorites": false,
        "favoriteRecordID": 3,
      },
    ],
   

  },
    "error": null,
    "success": true,
};

final Map<String, dynamic> dashboardDataFailedResponse =
   {
  "data": null,
  "error": 'No dashboard data was retrieved',
  "success": true,
};

@override
  Future<PatronRecommendationDTO> getRecommendedBooks(int memberRecordID) async
  {
   await Future.delayed(const Duration(milliseconds: 500));
  
   return PatronRecommendationDTO.fromJson (dashboardDataSuccessResponse);
  // return PatronRecommendationDTO.fromJson (dashboardDataFailedResponse);
    
  }



}