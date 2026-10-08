import 'package:biblio_track_patron_portal/Data/Models/DTOs/logged_in_patron_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/logged_in_patron_model.dart';

class LoggedInPatronMapper 
{

static LoggedInPatronModel fromDTO (LoggedInPatronDTO dto)
{

   return LoggedInPatronModel(memberRecordID: dto.memberRecordID, personRecordID: dto.personRecordID, userName: dto.userName,photoUrl: dto.photoUrl);

}



}