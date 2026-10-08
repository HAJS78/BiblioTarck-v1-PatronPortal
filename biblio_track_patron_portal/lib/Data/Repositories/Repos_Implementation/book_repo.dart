
import 'package:biblio_track_patron_portal/Data/Mappers/book_details_mapper.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/book_details_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/book_details_model.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_book_repo.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_book_service.dart';

class BookRepo implements IBookRepo
{

final IBookService service;

  BookRepo({required this.service});


@override
Future<BookDetailsModel> getBookDetails(int bookRecordID,int memberRecordID) async
{
  BookDetailsDTO dto = await service.getBookDetails(bookRecordID, memberRecordID);
  return BookDetailsMapper.fromDTO(dto);
}

}