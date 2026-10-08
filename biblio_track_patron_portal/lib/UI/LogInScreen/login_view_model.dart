import 'package:biblio_track_patron_portal/Data/Models/DomainModels/log_in_model.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/logged_in_patron_model.dart';
import 'package:flutter/material.dart';
//import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_patron_repo.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_auth_repo.dart';

class LogInViewModel extends ChangeNotifier 
{
  final IAuthRepo authRepo;

  LogInViewModel({required this.authRepo});

  // State
  late LoggedInPatronModel _patron ;
  bool _obscurePassword = true;
  bool _isLoading = false;
  String? _errorMessage='';

  // Getters
  LoggedInPatronModel get loggedInPatron => _patron;
  bool get obscurePassword=>_obscurePassword;
  bool get isLoading => _isLoading;
  String? get errorMessage=>_errorMessage;

  Future<void> findPatronByUserNameandPassword( String userName, String password) async 
  {
  
   //change to loading state
   _isLoading = true;
   notifyListeners();

    LogInModel model=  await authRepo.findPatronByUserNameAndPassword(userName.trim(), password.trim());
    
    
    _patron =model.loggedInPatron;
    _errorMessage=model.errorMessage;

    
     
  }

  void setPasswordObscurity(bool val)
  {
     _obscurePassword = !val;
     notifyListeners();

  }

  void restIsLoading()
  {
      _isLoading=false;
      
      notifyListeners();

  }

  
 
}
