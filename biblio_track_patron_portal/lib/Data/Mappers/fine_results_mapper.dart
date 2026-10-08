import 'package:biblio_track_patron_portal/Data/Mappers/fine_list_item_mapper.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/fine_results_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/fine_results_model.dart';

class FineResultsMapper
{

  static FineResultsModel fromDTO(FineResultsDTO dto)
  {
    if(dto.errorMessage==null)
    {
    return FineResultsModel(
      fines: FineListItemMapper.toFineModelList(dto.fines)
    );
    }
   else
   {
   return FineResultsModel(
      fines: List.empty(),
      errorMessage: dto.errorMessage,
      );
   }
  }

}