import 'package:biblio_track_patron_portal/Data/Models/DTOs/fine_results_dto.dart';

abstract interface class IFineService
{
 Future<FineResultsDTO> getUnpaidFines(int memberRecordID);
}