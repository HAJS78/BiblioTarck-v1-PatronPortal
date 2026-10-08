import 'package:biblio_track_patron_portal/Data/Models/DomainModels/change_password_result_model.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/patron_lookup_by_email_model.dart';

abstract interface class IPasswordRecoveryRepo
{
  Future<PatronLookupByEmailModel> findPatronByEmail(String email);
  Future<ChangePasswordResultModel> changePassword(int memberRecordID, String newPassword);
  
}