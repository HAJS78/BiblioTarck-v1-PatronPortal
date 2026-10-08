import 'package:biblio_track_patron_portal/Data/Models/DTOs/library_card_lookup_dto.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_library_card_service.dart';

class MockLibraryCardService implements ILibraryCardService
{
  Map<String, dynamic> successResponse=

    {
        "data": { "libraryCardRecordID": 7 },
        "error": null,
        "success": true,
    };

     Map<String, dynamic> failedResponse=

    {
        "data": null,
        "error": "Library card not found",
        "success": true,
    };

 
  @override
  Future<LibraryCardLookupDTO> findLibraryCardByNumber(String libraryCardNumber) async
  {
    await Future.delayed(const Duration(milliseconds: 500));
    
    return LibraryCardLookupDTO.fromJson(successResponse); //success
    
    //return LibraryCardLookupDTO.fromJson(failedResponse); //failure

  }
}