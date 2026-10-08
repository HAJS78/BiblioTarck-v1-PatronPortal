
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/patron_full_name_model.dart';

abstract interface class IPatronProfileDataRepo
{
  
  Future<PatronFullNameModel> getPatronFullName(int memberRecordID);
}