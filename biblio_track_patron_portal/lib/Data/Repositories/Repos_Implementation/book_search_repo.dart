import 'package:biblio_track_patron_portal/Data/Mappers/catalog_search_result_mapper.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/catalog_search_result_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/catalog_search_result_model.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_book_search_repo.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_book_search_service.dart';

class BookSearchRepo implements IBookSearchRepo
{
  final IBookSearchService service;

  BookSearchRepo({required this.service});


@override
Future<CatalogSearchResultModel> searchCatalog(int memberRecordId,String searchFilter, String searchKeyword) async
{
  CatalogSearchResultDTO dto = await service.searchCatalog( memberRecordId,searchFilter, searchKeyword);
  return CatalogSearchResultMapper.fromDTO(dto);
}

}