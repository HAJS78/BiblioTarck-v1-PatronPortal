import 'package:biblio_track_patron_portal/Data/Mappers/book_card_mapper.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/catalog_search_result_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/catalog_search_result_model.dart';

class CatalogSearchResultMapper
{
  // DTO → Domain Model (used in Repo after service call)
  static CatalogSearchResultModel fromDTO(CatalogSearchResultDTO dto)
  {
    if(dto.errorMessage==null)
    {
      return CatalogSearchResultModel(
        searchResults: BookCardMapper.toBookModelList(dto.searchResults)
      );
    }
    else
    {
      return CatalogSearchResultModel(
        searchResults: List.empty(),
        errorMessage: dto.errorMessage,
      );
    }
  }
}