import 'package:biblio_track_patron_portal/Data/Models/DTOs/log_in_dto.dart';


abstract class IAuthService 
{

  
  Future<LogInDTO> findPatronByUserNameAndPassword( String username, String password);
  
}