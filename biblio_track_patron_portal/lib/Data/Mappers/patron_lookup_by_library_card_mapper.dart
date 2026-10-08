import 'package:biblio_track_patron_portal/Data/Models/DTOs/patron_lookup_by_library_card_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/patron_lookup_by_library_card_model.dart';

class PatronLookupByLibraryCardMapper
{

  // DTO → Domain Model (used in Repo after service call)
  static PatronLookupByLibraryCardModel fromDTO(PatronLookupByLibraryCardDTO dto) 
  {
    if(dto.errorMessage==null)
    {
    return PatronLookupByLibraryCardModel(
      memberRecordID: dto.memberRecordID,
     
      
    );
    }
   else
   {
   return  PatronLookupByLibraryCardModel(
      memberRecordID: -1,
       errorMessage: dto.errorMessage 
      
      );
     


   }

  }
}
