import 'package:biblio_track_patron_portal/Data/Models/DomainModels/patron_lookup_by_library_card_model.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/sign_up_response_model.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/user_name_availability_model.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_patron_registeration_repo.dart';
import 'package:flutter/material.dart';


class SignUpViewModel extends ChangeNotifier
{

final IPatronRegisterationRepo registerationRepo;



SignUpViewModel({required this.registerationRepo});

late bool _isUserNameTaken=false;

late String? _userNameIsTakenErrorMessage;

String? get userNameIsTakenErrorMessage

{
  if(_isUserNameTaken)
  {
   _userNameIsTakenErrorMessage="User Name Is already Taken";
   return  _userNameIsTakenErrorMessage;
  }
  return "None";
}






Future<void> isUserNameTaken(String usrName) async
{

  UserNameAvailabilityModel model=await registerationRepo.isUserNameTaken(usrName);
  _isUserNameTaken= model.isTaken;
  _userNameIsTakenErrorMessage=model.errorMessage;
   notifyListeners();
  
}






late bool _patronAccountIsFound=false;
bool get  patronAccountIsFound=>_patronAccountIsFound;

late PatronLookupByLibraryCardModel _patronLookupByLibraryCardModel;

int get  _currentPatronMemberRecordID => _patronLookupByLibraryCardModel.memberRecordID;

String? _errorMessageForPatronLookupByLibraryCardResponse;

String? get errorMessageForPatronLookupByLibraryCardResponse=> _errorMessageForPatronLookupByLibraryCardResponse;

Future<void> findPatronByLibraryCardNumber( String libraryCardNumber)async
{
 
 _patronLookupByLibraryCardModel=await registerationRepo.findPatronByLibraryCardNumber(libraryCardNumber);
 
 if(_patronLookupByLibraryCardModel.memberRecordID!=-1)
 {
 _patronAccountIsFound=true;
  notifyListeners();
 }
 else
 {
  _patronAccountIsFound=false;
  _errorMessageForPatronLookupByLibraryCardResponse=_patronLookupByLibraryCardModel.errorMessage;
  notifyListeners();

 }

}
bool _isSignedupStatus=false;
bool get isSignedupStatus=>_isSignedupStatus;

String? _signupErroMsg="";
String? get signupErroMsg=>_signupErroMsg;
Future<void> updatePatronAccount(String username,String password)async
{

SignUpResponseModel model=await  registerationRepo.updatePatronAccount(username,password,_currentPatronMemberRecordID);
_isSignedupStatus=model.isSignedUp;
_signupErroMsg=model.errorMessage;

}

 void resetPatronAccountIsFound()
{
  _patronAccountIsFound=false;


}


}