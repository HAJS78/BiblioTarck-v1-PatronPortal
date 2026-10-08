import 'package:biblio_track_patron_portal/Data/Mappers/logged_in_patron_mapper.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/log_in_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/log_in_model.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/logged_in_patron_model.dart';

class LogInMapper
{

  // DTO → Domain Model (used in Repo after service call)
  static LogInModel fromDTO(LogInDTO dto) 
  {
    if(dto.errorMessage==null)
    {
    return LogInModel(
     loggedInPatron: LoggedInPatronMapper.fromDTO(dto.loggedInPatronDTO)
         
      
    );
    }
   else
   {
   return LogInModel(loggedInPatron: LoggedInPatronModel(memberRecordID: -1, personRecordID:-1, userName: 'N/A',photoUrl: ''),
     
     
      errorMessage: dto.errorMessage,

      
      );


   }

  }

  
  
}