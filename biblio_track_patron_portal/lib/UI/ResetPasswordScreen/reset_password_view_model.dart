import 'package:biblio_track_patron_portal/Data/Models/DomainModels/change_password_result_model.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/patron_lookup_by_email_model.dart';
import 'package:flutter/material.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_password_recovery_repo.dart';




class ResetPasswordViewModel extends ChangeNotifier 
{


final IPasswordRecoveryRepo recoveryRepo;


ResetPasswordViewModel({required this.recoveryRepo});

 

late PatronLookupByEmailModel _patronLookupByEmailModel;

int get  _currentPatronMemberRecordID =>  _patronLookupByEmailModel.memberRecordID;

String? _errorMessageFromResponse;

String? get errorMessageFromResponse=> _errorMessageFromResponse;


late bool _userAccountIsFound=false;
bool get  userAccountIsFound=>_userAccountIsFound;

late bool _hidePassword=false;
bool get hidePassword=>_hidePassword;

late bool _updateIsAllowed=false;
bool get updateIsAllowed=>_updateIsAllowed;

Future<void> findPatronByEmail(String email) async
{


 _patronLookupByEmailModel= await recoveryRepo.findPatronByEmail(email);
 
 if(_patronLookupByEmailModel.memberRecordID!=-1)
 {
   _userAccountIsFound=true;

 }

 else
 {
  _userAccountIsFound=false;
  _errorMessageFromResponse=_patronLookupByEmailModel.errorMessage;
 }

 
 notifyListeners();

}


 String? _updatePatronPasswordError="";
 String? get updatePatronPasswordError=>_updatePatronPasswordError;

 Future<bool> updatePatronPassword(String password)async
 {

  ChangePasswordResultModel model=await recoveryRepo.changePassword(_currentPatronMemberRecordID, password);
  if(model.passwordChanged)
  {
    return true;

  }
  else
  {
   _updatePatronPasswordError=model.errorMessage;
    return model.passwordChanged;
  }
 
 }

void changePasswordHideStatus(bool val)
{

   _hidePassword=val;
   notifyListeners();

}

void changeUpdateIsAllowedStatus(bool val)
{

   _updateIsAllowed=val;
   notifyListeners();
}



}