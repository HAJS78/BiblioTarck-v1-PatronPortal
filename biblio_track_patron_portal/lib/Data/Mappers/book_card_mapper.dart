import 'package:biblio_track_patron_portal/Data/Models/DTOs/book_card_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/book_card_model.dart';

class BookCardMapper 
{

// DTO → Domain Model (used in Repo after service call)
  static BookCardModel fromDTO(BookCardDTO dto) 
  {
    
  return BookCardModel(
    bookRecordID: dto.bookRecordID,
      title: dto.title,
      author: dto.author,
      bookCoverImageUrl: dto.bookCoverImageUrl ,
      inFavorites: dto.inFavorites , 
      favoriteRecordID: dto.favoriteRecordID  
    );
  

  }

static List<BookCardModel> toBookModelList(List<BookCardDTO> list)
{

   late List<BookCardModel> books=[];
  
   for(var b in list)
   {
      books.add(BookCardModel(bookRecordID: b.bookRecordID,  title: b.title, author: b.author, bookCoverImageUrl: b.bookCoverImageUrl,inFavorites: b.inFavorites,favoriteRecordID: b.favoriteRecordID));


   }

   return books;




}



  




}