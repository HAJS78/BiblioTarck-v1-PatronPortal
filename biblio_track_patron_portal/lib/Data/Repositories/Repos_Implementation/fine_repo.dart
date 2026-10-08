import 'package:biblio_track_patron_portal/Data/Mappers/fine_results_mapper.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/fine_results_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/fine_results_model.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_fine_repo.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_fine_service.dart';

class FineRepo implements IFineRepo
{

final IFineService service;

  FineRepo({required this.service});

@override
Future<FineResultsModel> getUnpaidFines(int memberRecordID)async
{

  FineResultsDTO dto = await service.getUnpaidFines(memberRecordID);

  return FineResultsMapper.fromDTO(dto);

}

}