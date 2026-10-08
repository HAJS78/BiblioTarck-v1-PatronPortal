import 'package:biblio_track_patron_portal/Data/Mappers/book_card_mapper.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/patron_recommendation_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/patron_recommendation_model.dart';

class PatronRecommendationMapper
{

  // DTO → Domain Model (used in Repo after service call)
  static PatronRecommendationModel fromDTO(PatronRecommendationDTO dto) 
  {
    if(dto.errorMessage==null)
    {
    return PatronRecommendationModel(
     
       recommendedBooks: BookCardMapper.toBookModelList(dto.recommendedBooks)
    );
    }
   else
   {
   return PatronRecommendationModel(
     
      recommendedBooks: List.empty(),
      errorMessage: dto.errorMessage,

      
      );


   }

  }

  
  
}