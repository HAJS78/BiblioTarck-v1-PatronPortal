import 'package:biblio_track_patron_portal/Data/Models/DomainModels/patron_lookup_by_library_card_model.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/sign_up_response_model.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/user_name_availability_model.dart';

abstract class IPatronRegisterationRepo 
{

  Future<UserNameAvailabilityModel> isUserNameTaken(String usrName);
  Future<PatronLookupByLibraryCardModel> findPatronByLibraryCardNumber(String libraryCardNumber);
Future<SignUpResponseModel> updatePatronAccount(String username, String password, int memberRecordID);
}