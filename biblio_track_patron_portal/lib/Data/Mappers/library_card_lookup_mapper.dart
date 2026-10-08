import 'package:biblio_track_patron_portal/Data/Models/DTOs/library_card_lookup_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/library_card_lookup_model.dart';

class LibraryCardLookupMapper
{
  static LibraryCardLookupModel fromDTO(LibraryCardLookupDTO dto)
  {
    return LibraryCardLookupModel(
      libraryCardRecordID: dto.libraryCardRecordID,
      errorMessage: dto.errorMessage,
    );
  }
}