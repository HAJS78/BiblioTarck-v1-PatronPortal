import 'package:biblio_track_patron_portal/Data/Models/DTOs/library_card_lookup_dto.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_library_card_service.dart';
import 'package:dio/dio.dart';

class LibraryCardService implements ILibraryCardService

{

   Dio dio;

   LibraryCardService ({required this.dio});

  @override
  Future<LibraryCardLookupDTO> findLibraryCardByNumber(String libraryCardNumber) async
  {
    final response = await dio.get('/LibraryCard/$libraryCardNumber');
   
     return LibraryCardLookupDTO.fromJson(response.data);

  }



}