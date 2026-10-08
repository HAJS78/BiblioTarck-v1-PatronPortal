import 'package:biblio_track_patron_portal/Data/Models/DTOs/book_details_dto.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_book_service.dart';

class MockBookService implements IBookService
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
    "bookCoverImageUrl": "", "inFavorites": false, "favoriteRecordID": null,
    "isbn": "9781305079373", "summary": "This book provides a clear, molecular-level understanding of chemistry, emphasizing problem-solving and conceptual learning. It covers atomic structure, bonding, thermodynamics, and reaction mechanisms, making it a great resource for students and professionals alike.",
  },
  {
    "bookRecordID": 3, "title": "The Pragmatic Programmer", "author": "Andrew Hunt & David Thomas",
    "bookCoverImageUrl": "", "inFavorites": false, "favoriteRecordID": 2,
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
Future<BookDetailsDTO> getBookDetails(int bookRecordID,int memberRecordID) async
{
  await Future.delayed(const Duration(seconds: 2));

  var book = _catalogBooks.firstWhere(
    (b) => b['bookRecordID'] == bookRecordID,
    orElse: () => {},
  );

  Map<String, dynamic> successResponse={};
  //Map<String, dynamic> failedResponse={};

  if (book.isNotEmpty)
  {
    successResponse =
    {
      "data":
      {
        "bookRecordID": book['bookRecordID'],
        "title": book['title'],
        "author": book['author'],
        "bookCoverImageUrl": book['bookCoverImageUrl'],
        "summary": book['summary'] ?? 'No summary available.',
        "inFavorites": book['inFavorites'],
        "favoriteRecordID": book['favoriteRecordID'],
      },
      "error": null,
      "success": true,
    };
  }
  else
  {
    // failedResponse =
    // {
    //   "data": null,
    //   "error": 'Book not found',
    //   "success": false,
    // };
  }

  return BookDetailsDTO.fromJson(successResponse);  //success
  // return BookDetailsDTO.fromJson(failedResponse); //failure
}

 

}


