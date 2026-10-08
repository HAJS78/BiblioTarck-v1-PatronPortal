import 'package:biblio_track_patron_portal/Data/Models/DTOs/change_password_result_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/change_password_result_model.dart';

class ChangePasswordResultMapper
{
  // DTO → Domain Model (used in Repo after service call)
  static ChangePasswordResultModel fromDTO(ChangePasswordResultDTO dto)
  {
    if (dto.errorMessage == null)
    {
      return ChangePasswordResultModel(
        passwordChanged: dto.passwordChanged
      );
    }
    else
    {
      return ChangePasswordResultModel(
        passwordChanged: false,
        errorMessage: dto.errorMessage
      );
    }
  }
}