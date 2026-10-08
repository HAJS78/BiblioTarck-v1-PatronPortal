import 'package:biblio_track_patron_portal/Data/Models/DTOs/book_card_dto.dart';

class PatronRecommendationDTO
{
  
  final List<BookCardDTO> recommendedBooks;
  
  final String? errorMessage;

  PatronRecommendationDTO({
   
    required this.recommendedBooks,
    this.errorMessage
  });

 

  static PatronRecommendationDTO fromJson(Map<String, dynamic> json)
   {
    if (json['success'] == true && json['data'] != null) 
    {
      return PatronRecommendationDTO(
       
        recommendedBooks: BookCardDTO.fromJsonList( json['data']['recommendedBooks'])
        
      );
    }
    else 
    {
      return PatronRecommendationDTO(
     
       recommendedBooks:List.empty(),
        errorMessage: json['error'] ?? 'Unknown error');
    }
  }
}