import 'package:biblio_track_patron_portal/Data/Models/DTOs/log_in_dto.dart';
//import 'package:biblio_track_patron_portal/Data/Models/DTOs/sign_up_response_dto.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_auth_service.dart';

class MockAuthenticationService implements IAuthService
{
//1
final Map<String,dynamic> _patronOnlineAccountAuthenticationSucessResponse=
{
   "data":
   {
         
      "memberRecordID": 1,
      "personRecordID": 1,
      "userName": 'lina_smith',
      "photoUrl": null,
     
   },
     
   "error":null,
   "success":true
 
    
};



final Map<String,dynamic> _patronOnlineAccountAuthenticationFailedResponse=
{
   "data":null,
   "error":'user not found.',
   "success":false
 
    
};




  // Auth
  //in real https scenario :this function will call
  //POST /api/auth/login end point
  @override
  Future<LogInDTO> findPatronByUserNameAndPassword(String username, String password) async 
    {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 10)); //1.this would be call to endpoint
                                                       //and JSON response would be 
                                                         //returned  

                                                        
    // Success scenario
    if (username == 'lina_smith' && password == '1234') 
    {
     
     return LogInDTO.fromJson( _patronOnlineAccountAuthenticationSucessResponse);
                                             // 2.we would use fromJson in ...._dtoclass to 
                                             //convert JSON repoense to dto
    }                                              

    // Failure scenario
    

    return LogInDTO.fromJson(_patronOnlineAccountAuthenticationFailedResponse);
  }





}