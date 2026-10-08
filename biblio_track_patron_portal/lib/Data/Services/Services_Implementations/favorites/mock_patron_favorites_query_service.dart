import 'package:biblio_track_patron_portal/Data/Models/DTOs/member_favorites_dto.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_patron_favorites_query_service.dart';

class MockPatronFavoritesQueryService implements IPatronFavoritesQueryService 
{

 Map<String,dynamic> favoritesSuccessResponse=
    {
    
    "data":
    {
      "favorites":
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
        "bookRecordID": 3,
        "title": "The Pragmatic Programmer",
        "author": "Andrew Hunt & David Thomas",
        "bookCoverImageUrl": "",
        "inFavorites": true,
        "favoriteRecordID": 2
     },
     
    ]},
    "error":null,
     "success":true
    };


Map<String,dynamic> favoritesFailedResponse=
    {
    
    "data":null,
    
    "error":"Failed to process request",
     "success":true
    };

 @override
  Future<MemberFavoritesDTO> getFavorites(int memberRecordID)async 
  {
   await  Future.delayed(Duration(seconds: 10));
   
   MemberFavoritesDTO dto=MemberFavoritesDTO.fromJson(favoritesSuccessResponse); //success
   //MemberFavoritesDTO dto=MemberFavoritesDTO.fromJson(favoritesFailedResponse); //failure
   return dto;    

  }

}