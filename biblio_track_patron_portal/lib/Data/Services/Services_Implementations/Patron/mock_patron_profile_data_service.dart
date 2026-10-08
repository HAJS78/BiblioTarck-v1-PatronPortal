import 'package:biblio_track_patron_portal/Data/Models/DTOs/patron_full_name_dto.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_patron_profile_data_service.dart';

class MockPatronProfileDataService implements IPatronProfileDataService
{

 final Map<String,dynamic> fullNameSuccessResponse=
  {
    "data":{"patronFullName":"Lisa James Smith"},
    "error": null,
    "success": true,


     
  
  };

 final Map<String,dynamic> fullNameFailedResponse=
  {
    "data":null,
    "error": "Error while processing request",
    "success": true,


     
  
  };


  @override
  
  Future<PatronFullNameDTO> getPatronFullName(int memberRecordID)async
  {

      await Future.delayed(const Duration(milliseconds: 10));
      return PatronFullNameDTO.fromJson(fullNameSuccessResponse);
     // return PatronFullNameDTO.fromJson(fullNameFailedResponse);

  }
}