import 'package:biblio_track_patron_portal/Data/Models/DTOs/change_password_result_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/patron_lookup_by_email_dto.dart';

abstract class IPasswordRecoveryService
{
Future<PatronLookupByEmailDTO> findPatronByEmail(String email);
Future<ChangePasswordResultDTO> changePassword(int memberRecordID, String newPassword);

}
