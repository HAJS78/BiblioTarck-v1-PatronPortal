import 'package:biblio_track_patron_portal/Data/Models/DTOs/change_password_result_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/patron_lookup_by_email_dto.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_password_recovery_service.dart';

class MockPasswordRecoveryService implements IPasswordRecoveryService
{
  // Mock "database" — the single patron account this recovery flow knows
  // about. Mutable so a successful changePassword() call actually persists
  // for the rest of the app run, mirroring a real UPDATE statement.
  final Map<String, dynamic> _patronAccount =
  {
    "memberRecordID": 1,
    "email": "lina@email.com",
    "password": "1234",
  };

  // ---- findPatronByEmail response templates ----

  final Map<String, dynamic> _findByEmailSuccessResponse =
  {
    "data": { "memberRecordID": 1 },
    "error": null,
    "success": true,
  };

  final Map<String, dynamic> _findByEmailFailedResponse =
  {
    "data": null,
    "error": "No account found for that email.",
    "success": false,
  };

  @override
  Future<PatronLookupByEmailDTO> findPatronByEmail(String email) async
  {
    await Future.delayed(const Duration(milliseconds: 500));

    if (email == _patronAccount["email"])
    {
      return PatronLookupByEmailDTO.fromJson(_findByEmailSuccessResponse);
    }

    return PatronLookupByEmailDTO.fromJson(_findByEmailFailedResponse);
  }

  // ---- changePassword response templates ----
  // No dedicated DTO exists for this action yet — interface returns a raw
  // bool — so these shapes just document what a real ApiResponse<bool>
  // payload would look like. Flagging in case you want a proper response
  // model here later for consistency with the rest of the app.

  final Map<String, dynamic> _changePasswordSuccessResponse =
  {
    "data": true,
    "error": null,
    "success": true,
  };

  final Map<String, dynamic> _changePasswordFailedResponse =
  {
    "data": false,
    "error": "Unable to update password.",
    "success": false,
  };

  @override
  Future<ChangePasswordResultDTO> changePassword(int memberRecordID, String newPassword) async
  {
    await Future.delayed(const Duration(milliseconds: 500));

    bool memberExists = memberRecordID == _patronAccount["memberRecordID"];

    if (memberExists && newPassword.isNotEmpty)
    {
      // Actual mutation — the mock "record" is updated, not just a bool
      // returned in isolation.
      _patronAccount["password"] = newPassword;

      return ChangePasswordResultDTO.fromJson(_changePasswordSuccessResponse);
    }

    return ChangePasswordResultDTO.fromJson(_changePasswordFailedResponse);
  }
}