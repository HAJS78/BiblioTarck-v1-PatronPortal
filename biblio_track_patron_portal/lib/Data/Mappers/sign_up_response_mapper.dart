import 'package:biblio_track_patron_portal/Data/Models/DTOs/sign_up_response_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/sign_up_response_model.dart';

class SignUpResponseMapper
{

  // DTO → Domain Model (used in Repo after service call)
  static SignUpResponseModel fromDTO(SignUpResponseDTO dto) 
  {
    if(dto.errorMessage==null)
    {
    return SignUpResponseModel(
       isSignedUp: dto.isSignedUp,
     
      
    );
    }
   else
   {
   return  SignUpResponseModel(
      isSignedUp: false,
       errorMessage: dto.errorMessage 
      
      );
     


   }

  }

  
  
}