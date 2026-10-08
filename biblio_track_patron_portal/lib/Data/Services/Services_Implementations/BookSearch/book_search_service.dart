import 'package:biblio_track_patron_portal/Data/Models/DTOs/catalog_search_result_dto.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_book_search_service.dart';
import 'package:dio/dio.dart';

class BookSearchService implements IBookSearchService
{
  
  Dio dio;

  BookSearchService({required this.dio});

  
  @override
  Future<CatalogSearchResultDTO> searchCatalog(int memberRecordId,String searchFilter, String searchKeyword) async
  {


   final response = await dio.get(
      '/Books/SearchCatalog',
      queryParameters: 
      {
         'memberRecordId': memberRecordId,
         'searchFilter': searchFilter,
         'searchKeyword': searchKeyword
      }
    );
    return CatalogSearchResultDTO.fromJson(response.data);


  }

}