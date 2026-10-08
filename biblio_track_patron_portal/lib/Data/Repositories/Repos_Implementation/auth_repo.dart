import 'package:biblio_track_patron_portal/Data/Mappers/log_in_mapper.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/log_in_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/log_in_model.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_auth_repo.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_auth_service.dart';

class AuthRepo implements IAuthRepo
{
  final IAuthService service;

  AuthRepo({required this.service});


// Auth
  @override
  Future<LogInModel> findPatronByUserNameAndPassword(String username, String password) async
   {
    LogInDTO dto =
        await service.findPatronByUserNameAndPassword(username, password);

    
      return LogInMapper.fromDTO(dto);
   
  }

  


}