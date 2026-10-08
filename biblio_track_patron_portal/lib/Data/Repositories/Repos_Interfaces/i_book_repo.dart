import 'package:biblio_track_patron_portal/Data/Models/DomainModels/book_details_model.dart';

abstract interface class IBookRepo 
{
  Future<BookDetailsModel> getBookDetails(int bookRecordID,int memberRecordID);

}

//Interfaces should be grouped by business domain (e.g., Favorites, Auth, Catalog), 
//not restricted to a 1-to-1 relationship with single screens.