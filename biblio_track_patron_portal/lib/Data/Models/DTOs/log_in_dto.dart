

import 'package:biblio_track_patron_portal/Data/Models/DTOs/logged_in_patron_dto.dart';

class LogInDTO 
{
  
  final LoggedInPatronDTO loggedInPatronDTO;
  final String? errorMessage;

  LogInDTO({
   required this.loggedInPatronDTO,
    this.errorMessage
  });

 

  static LogInDTO fromJson(Map<String, dynamic> json)
   {
    if (json['success'] == true && json['data'] != null) 
    {
      return LogInDTO(
        loggedInPatronDTO: LoggedInPatronDTO.fromJson(json)
       
      );
    }
    else 
    {
      return 
       LogInDTO(loggedInPatronDTO:  LoggedInPatronDTO.fromJson(json),errorMessage: json['error']??'unknown error');
    }
  }
}
