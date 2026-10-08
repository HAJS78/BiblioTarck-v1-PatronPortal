import 'package:biblio_track_patron_portal/Data/Models/DomainModels/library_card_lookup_model.dart';

abstract interface class ILibraryCardRepo
{
  Future<LibraryCardLookupModel> findLibraryCardByNumber(String libraryCardNumber);
}