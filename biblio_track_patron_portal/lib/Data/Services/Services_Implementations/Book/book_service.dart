import 'package:dio/dio.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/book_details_dto.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_book_service.dart';

class BookService implements IBookService
{
  final Dio dio;

  BookService({required this.dio});

  @override
  Future<BookDetailsDTO> getBookDetails(int bookRecordID, int memberRecordID) async
  {
    final response = await dio.get(
      '/Books/$bookRecordID',
      queryParameters: {'memberRecordID': memberRecordID},
    );

    return BookDetailsDTO.fromJson(response.data);
  }
}