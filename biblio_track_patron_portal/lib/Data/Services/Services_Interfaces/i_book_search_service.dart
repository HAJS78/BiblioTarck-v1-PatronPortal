import 'package:biblio_track_patron_portal/Data/Models/DTOs/catalog_search_result_dto.dart';

abstract class IBookSearchService 
{

Future<CatalogSearchResultDTO> searchCatalog(int memberRecordId, String searchFilter, String searchKeyword);
}