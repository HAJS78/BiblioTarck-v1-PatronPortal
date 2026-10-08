import 'package:biblio_track_patron_portal/Data/Models/DomainModels/book_card_model.dart';

class CatalogSearchResultModel
{
  final List<BookCardModel> searchResults;
  final String? errorMessage;

  CatalogSearchResultModel({
    required this.searchResults,
    this.errorMessage
  });
}