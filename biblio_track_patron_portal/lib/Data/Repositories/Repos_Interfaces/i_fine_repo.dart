import 'package:biblio_track_patron_portal/Data/Models/DomainModels/fine_results_model.dart';

abstract interface class IFineRepo
{
 Future<FineResultsModel> getUnpaidFines(int memberRecordID);
}