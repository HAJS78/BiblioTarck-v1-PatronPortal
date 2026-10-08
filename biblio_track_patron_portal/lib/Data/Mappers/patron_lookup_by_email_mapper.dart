
import 'package:biblio_track_patron_portal/Data/Models/DTOs/patron_lookup_by_email_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/patron_lookup_by_email_model.dart';

class PatronLookupByEmailMapper
{

  // DTO → Domain Model (used in Repo after service call)
  static PatronLookupByEmailModel fromDTO(PatronLookupByEmailDTO dto) 
  {
    if(dto.errorMessage==null)
    {
    return PatronLookupByEmailModel(
      memberRecordID: dto.memberRecordID,
     
      
    );
    }
   else
   {
   return  PatronLookupByEmailModel(
      memberRecordID: -1,
       errorMessage: dto.errorMessage 
      
      );
     


   }

  }

  
  
}