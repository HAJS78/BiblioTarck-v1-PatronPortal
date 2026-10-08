import 'package:biblio_track_patron_portal/Data/Models/DTOs/change_password_result_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/patron_lookup_by_email_dto.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_password_recovery_service.dart';
import 'package:dio/dio.dart';

class PasswordRecoveryService implements IPasswordRecoveryService
{
  final Dio dio;

  PasswordRecoveryService({required this.dio});

  @override
  Future<PatronLookupByEmailDTO> findPatronByEmail(String email) async
  {
    final response = await dio.post(
      '/PasswordRecovery/Email',
      data: {'email': email},
    );

    return PatronLookupByEmailDTO.fromJson(response.data);
  } 
  
@override
  Future<ChangePasswordResultDTO> changePassword(int memberRecordID, String newPassword) async
  {
    final response = await dio.put(
      '/PasswordRecovery/Password',
      data: {'memberRecordID': memberRecordID, 'newPassword': newPassword},
    );

    return ChangePasswordResultDTO.fromJson(response.data);
  }
}

  