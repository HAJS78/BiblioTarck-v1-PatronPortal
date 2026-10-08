import 'package:biblio_track_patron_portal/Data/Models/DTOs/book_details_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/book_details_model.dart';

class BookDetailsMapper
{
  static BookDetailsModel fromDTO(BookDetailsDTO dto)
  {
    if (dto.errorMessage == null)
    {
      return BookDetailsModel(
        bookRecordID: dto.bookRecordID,
        title: dto.title,
        author: dto.author,
        bookCoverImageUrl: dto.bookCoverImageUrl,
        summary: dto.summary,
        inFavorites: dto.inFavorites,
        favoriteRecordID: dto.favoriteRecordID,
      );
    }
    else
    {
      return BookDetailsModel(
        bookRecordID: -1,
        title: 'N/A',
        author: 'N/A',
        bookCoverImageUrl: '',
        summary: '',
        inFavorites: false,
        favoriteRecordID: -1,
        errorMessage: dto.errorMessage,
      );
    }
  }
}