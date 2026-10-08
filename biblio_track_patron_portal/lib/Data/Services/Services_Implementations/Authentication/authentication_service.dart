import 'package:dio/dio.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/log_in_dto.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_auth_service.dart';

class AuthenticationService implements IAuthService
{
  final Dio dio;

  AuthenticationService({required this.dio});

  @override
  Future<LogInDTO> findPatronByUserNameAndPassword(String username, String password) async
  {
    final response = await dio.post(
      '/Auth/login',
      data: {'username': username, 'password': password},
    );

    return LogInDTO.fromJson(response.data);
  }
}