import 'package:biblio_track_patron_portal/Data/Models/DTOs/patron_lookup_by_library_card_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/sign_up_response_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/user_name_availability_dto.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_patron_registeration_service.dart';

class MockPatronRegisterationService implements IPatronRegisterationService
{


final Map<String, dynamic> _patronLookupByLibraryCardSuccessResponse = 
{
    "data": {
      "memberRecordID": 1,
    },
    "error": null,
    "success": true
  };

  // 2. Failure Mock Response
  // final Map<String, dynamic> _patronLookupByLibraryCardFailedResponse = 
  // {
  //   "data": null,
  //   "error": "library card was not found",
  //   "success": false
  // };
  
  // sign up process

  //a-find by card
  @override
  Future<PatronLookupByLibraryCardDTO> findPatronByLibraryCardNumber(String libraryCardNumber) async
  {

    await Future.delayed(const Duration(milliseconds: 500));

    return PatronLookupByLibraryCardDTO.fromJson(_patronLookupByLibraryCardSuccessResponse); //success
    //return PatronLookupByLibraryCardDTO.fromJson(_patronLookupByLibraryCardFailedResponse); //failure


  }


 //b.check if userName entered is not taken

final Map<String, dynamic> _isUserNameTakenSuccessResponse = 
{
  "data": 
  {
    "isTaken": true,
  },
  "error": null,
  "success": true
};

// final Map<String, dynamic> _isUserNameTakenFailedResponse = 
// {
//   "data": 
//   {
//     "isTaken": true,
//   },
//   "error": null,
//   "success": true
// };

@override
Future<UserNameAvailabilityDTO> isUserNameTaken(String usrName) async 
{
  await Future.delayed(const Duration(milliseconds: 500));
  return UserNameAvailabilityDTO.fromJson(_isUserNameTakenSuccessResponse);//success
   //return UserNameAvailabilityDTO.fromJson(_isUserNameTakenSuccessResponse);//failure

}
  
  final Map<String, dynamic> _patronSignUpSuccessResponse = 
  {
    "data": {
      "isSignedUp": true,
    },
    "error": null,
    "success": true
  };

  // // 2. Failure Mock Response
  // final Map<String, dynamic> _patronSignUpFailedResponse = {
  //   "data": null,
  //   "error": "Error processing signing up",
  //   "success": false
  // };
  
  
  //c.updating the account and signing up is done 
  @override
  Future<SignUpResponseDTO> updatePatronAccount(String username,String password,int memberRecordID)async
  {

  await Future.delayed(const Duration(milliseconds: 500));

  return SignUpResponseDTO.fromJson(_patronSignUpSuccessResponse); //success
  //return SignUpResponseDTO.fromJson(_patronSignUpFailedResponse); //failure


  }



}