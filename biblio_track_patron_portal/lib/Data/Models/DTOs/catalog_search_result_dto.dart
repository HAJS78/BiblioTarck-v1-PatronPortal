import 'package:biblio_track_patron_portal/Data/Models/DTOs/book_card_dto.dart';

class CatalogSearchResultDTO
{
  final List<BookCardDTO> searchResults;
  final String? errorMessage;

  CatalogSearchResultDTO({
    required this.searchResults,
    this.errorMessage
  });

  static CatalogSearchResultDTO fromJson(Map<String, dynamic> json)
  {
    if (json['success'] == true && json['data'] != null)
    {
      return CatalogSearchResultDTO(
        searchResults: BookCardDTO.fromJsonList(json['data']['searchResults'])
      );
    }
    else
    {
      return CatalogSearchResultDTO(
        searchResults: List.empty(),
        errorMessage: json['error'] ?? 'Unknown error');
    }
  }
}