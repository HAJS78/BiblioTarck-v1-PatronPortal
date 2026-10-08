import 'package:biblio_track_patron_portal/Data/Models/DomainModels/logged_in_patron_model.dart';

class LogInModel 
{
  
   final LoggedInPatronModel loggedInPatron;
   final String? errorMessage; 
 

  LogInModel({
    required this.loggedInPatron,
        this.errorMessage
    
  });

  
        

  
}
