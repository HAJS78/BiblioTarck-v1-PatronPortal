import 'package:biblio_track_patron_portal/Data/Models/DTOs/patron_lookup_by_library_card_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/sign_up_response_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/user_name_availability_dto.dart';

abstract class IPatronRegisterationService
 {

  Future<UserNameAvailabilityDTO> isUserNameTaken(String usrName);
  Future<PatronLookupByLibraryCardDTO > findPatronByLibraryCardNumber(String libraryCardNumber);
  Future<SignUpResponseDTO> updatePatronAccount(String username,String password,int memberRecordID);
 }