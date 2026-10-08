import 'package:biblio_track_patron_portal/Data/Models/DTOs/fine_results_dto.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_fine_service.dart';
import 'package:dio/dio.dart';

class FineService implements IFineService
{

 Dio dio;

 FineService({required this.dio});

  @override
  Future<FineResultsDTO> getUnpaidFines(int memberRecordID) async
  {
    
      final response = await dio.get('/Fine/$memberRecordID');
      return FineResultsDTO.fromJson(response.data);
    
   
  }

}