import 'package:biblio_track_patron_portal/Data/Models/DTOs/patron_full_name_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/patron_full_name_model.dart';

class PatronFullNameMapper 
{

// DTO → Domain Model (used in Repo after service call)
  static PatronFullNameModel fromDTO(PatronFullNameDTO dto) 
  {
    if(dto.errorMessage==null)
    {
    return PatronFullNameModel(
     patronFullName: dto.patronFullName,
     
      
    );
    }
   else
   {
   return  PatronFullNameModel(
      patronFullName:'Unknown Patron',
       errorMessage: dto.errorMessage 
      
      );
     


   }

  }


}