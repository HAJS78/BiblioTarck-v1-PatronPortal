import 'package:biblio_track_patron_portal/Data/Models/DTOs/fine_results_dto.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_fine_service.dart';

class MockFineService implements IFineService
{

  
  final Map<String, dynamic> _unpaidFinesSuccessResponse = 
  {
    "data": {"fines": [
      {
        "fineRecordID": 1,
        "lateDays": 5,
        "amountDue": 15,
        "dateAdded": "2026-07-20T00:00:00.000",
        "addedByName": "Kami Lord"
      },
      {
        "fineRecordID": 2,
        "lateDays": 12,
        "amountDue": 24,
        "dateAdded": "2026-07-10T00:00:00.000",
        "addedByName": "Sarah Ahmad"
      },
      {
        "fineRecordID": 3,
        "lateDays": 2,
        "amountDue": 6,
        "dateAdded": "2026-07-28T00:00:00.000",
        "addedByName": "Kami Lord"
      }
    ]},
    "error": null,
    "success": true
  };

  // // 2. Failure Mock Response
  // final Map<String, dynamic> _unpaidFinesFailedResponse = {
  //   "data": null,
  //   "error": "Failed to retrieve unpaid fines record.",
  //   "success": false
  // };

      @override
      Future<FineResultsDTO> getUnpaidFines(int memberRecordID)async
      {

        await Future.delayed(const Duration(seconds: 2));

         FineResultsDTO dto=FineResultsDTO.fromJson(_unpaidFinesSuccessResponse); //sccuess
         //FineResultsDTO dto=FineResultsDTO.fromJson(_unpaidFinesFailedResponse); //failure
         return dto;
      }

}

