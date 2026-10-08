import 'package:biblio_track_patron_portal/Data/Models/DTOs/catalog_search_result_dto.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_book_search_service.dart';


class MockBookSearchService implements IBookSearchService  
{
//datasource
final List<Map<String, dynamic>> _catalogBooks =
[
  {
    "bookRecordID": 1, "title": "Clean Code", "author": "Robert C. Martin",
    "bookCoverImageUrl": "", "inFavorites": true, "favoriteRecordID": 1,
    "isbn": "9780132350884", "summary": "A guide to writing clean, maintainable, and efficient code using agile principles and best practices. Covers topics such as naming conventions, formatting, error handling, and testing.",
  },
  {
    "bookRecordID": 2, "title": "Principles of Chemistry", "author": "Nivaldo J. Tro",
    "bookCoverImageUrl": "", "inFavorites": true, "favoriteRecordID": null,
    "isbn": "9781305079373", "summary": "This book provides a clear, molecular-level understanding of chemistry, emphasizing problem-solving and conceptual learning. It covers atomic structure, bonding, thermodynamics, and reaction mechanisms, making it a great resource for students and professionals alike.",
  },
  {
    "bookRecordID": 3, "title": "The Pragmatic Programmer", "author": "Andrew Hunt & David Thomas",
    "bookCoverImageUrl": "", "inFavorites": false, "favoriteRecordID":2,
    "isbn": "9780135957059", "summary": "",
  },
  {
    "bookRecordID": 4, "title": "Design Patterns", "author": "Erich Gamma et al.",
    "bookCoverImageUrl": "", "inFavorites": false, "favoriteRecordID": null,
    "isbn": "9780201633610", "summary": "",
  },
  {
    "bookRecordID": 5, "title": "Introduction to Algorithms", "author": "Cormen, Leiserson, Rivest, Stein",
    "bookCoverImageUrl": "", "inFavorites": false, "favoriteRecordID":null,
    "isbn": "9780262046305", "summary": "",
  },
];

@override
Future<CatalogSearchResultDTO> searchCatalog(int memberRecordId, String searchFilter, String searchKeyword) async
{
  await Future.delayed(const Duration(seconds: 10));

  List<Map<String, dynamic>> results = [];
  String keyword = searchKeyword.toLowerCase();
 //simulate searching
  switch (searchFilter)
  {
    case "title":
      results = _catalogBooks.where((b) => (b['title'] as String).toLowerCase().contains(keyword)).toList();

    case "author":
      results = _catalogBooks.where((b) => (b['author'] as String).toLowerCase().contains(keyword)).toList();

    case "isbn":
      results = _catalogBooks.where((b) => (b['isbn'] as String)==searchKeyword).toList();

    case "tag":
      results = _catalogBooks.where((b) => (b['searchTag'] as String).toLowerCase().contains(keyword)).toList();

    case "titleOrTag":
      results = _catalogBooks.where((b) =>
          (b['title'] as String).toLowerCase().contains(keyword) ||
          (b['searchTag'] as String).toLowerCase().contains(keyword)).toList();

    default:
      results = _catalogBooks.where((b) => (b['title'] as String).toLowerCase().contains(keyword)).toList();
  }

//you assemble the resp as if were returned from endpoint 
Map<String, dynamic> successResponse =
  {
    "data": { "searchResults": results},
    "error": null,
    "success": true,
  };
 
// Map<String, dynamic> failedResponse =
//   {
//     "data": null,
//     "error": "Error while searching",
//     "success": true,
//   };

  return CatalogSearchResultDTO.fromJson(successResponse);  //success
  //return CatalogSearchResultDTO.fromJson(failedResponse); //failure
}



}