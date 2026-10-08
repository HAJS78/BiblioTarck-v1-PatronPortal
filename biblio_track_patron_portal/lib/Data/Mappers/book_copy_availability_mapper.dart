import 'package:biblio_track_patron_portal/Data/Mappers/borrowed_copy_mapper.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/book_copy_availability_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/book_copy_availability_model.dart';

class BookCopyAvailabilityMapper
{
  static BookCopyAvailabilityModel fromDTO(BookCopyAvailabilityDTO dto)
  {
    if (dto.errorMessage == null)
    {
      return BookCopyAvailabilityModel(
        availableBookCopyID: dto.availableBookCopyID,
        borrowedCopies: BorrowedCopyMapper.toModelList(dto.borrowedCopies),
      );
    }
    else
    {
      return BookCopyAvailabilityModel(
        availableBookCopyID: null,
        borrowedCopies: List.empty(),
        errorMessage: dto.errorMessage,
      );
    }
  }
}