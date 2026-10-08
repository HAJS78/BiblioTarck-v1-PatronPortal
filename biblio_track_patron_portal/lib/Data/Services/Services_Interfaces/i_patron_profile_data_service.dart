 
import 'package:biblio_track_patron_portal/Data/Models/DTOs/patron_full_name_dto.dart';

abstract class IPatronProfileDataService
{
   Future<PatronFullNameDTO> getPatronFullName(int memberRecordID);
}