import 'package:biblio_track_patron_portal/Data/Models/DTOs/library_card_lookup_dto.dart';

abstract interface class ILibraryCardService
{
  Future<LibraryCardLookupDTO> findLibraryCardByNumber(String libraryCardNumber);
}