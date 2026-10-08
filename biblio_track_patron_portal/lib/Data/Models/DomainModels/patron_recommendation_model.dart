import 'package:biblio_track_patron_portal/Data/Models/DomainModels/book_card_model.dart';

class PatronRecommendationModel
{
  
  final List<BookCardModel> recommendedBooks;
  final String? errorMessage;

  PatronRecommendationModel({
    
   
    required this.recommendedBooks,
   
    this.errorMessage
  });
}