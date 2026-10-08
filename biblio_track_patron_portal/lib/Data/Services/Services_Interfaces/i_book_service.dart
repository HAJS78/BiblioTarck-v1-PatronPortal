
import 'package:biblio_track_patron_portal/Data/Models/DTOs/book_details_dto.dart';

abstract class IBookService 
{
Future<BookDetailsDTO> getBookDetails(int bookRecordID,int memberRecordID);

}