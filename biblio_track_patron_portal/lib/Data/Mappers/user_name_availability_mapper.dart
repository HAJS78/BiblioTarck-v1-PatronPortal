import 'package:biblio_track_patron_portal/Data/Models/DTOs/user_name_availability_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/user_name_availability_model.dart';

class UserNameAvailabilityMapper
{
  static UserNameAvailabilityModel fromDTO(UserNameAvailabilityDTO dto)
  {
    return UserNameAvailabilityModel(
      isTaken: dto.isTaken,
      errorMessage: dto.errorMessage,
    );
  }
}