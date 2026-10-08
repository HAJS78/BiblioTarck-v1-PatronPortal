
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/catalog_search_result_model.dart';

abstract class IBookSearchRepo 
{


Future<CatalogSearchResultModel> searchCatalog(int memberRecordId, String searchFilter, String searchKeyword);


}