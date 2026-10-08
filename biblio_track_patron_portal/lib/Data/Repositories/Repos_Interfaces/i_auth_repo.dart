import 'package:biblio_track_patron_portal/Data/Models/DomainModels/log_in_model.dart';
//import 'package:biblio_track_patron_portal/Data/Models/DomainModels/sign_up_response_model.dart';

abstract interface class IAuthRepo
{
  Future<LogInModel> findPatronByUserNameAndPassword(String username, String password);
  
}