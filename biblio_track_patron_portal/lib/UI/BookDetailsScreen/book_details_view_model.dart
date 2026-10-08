import 'package:biblio_track_patron_portal/Data/Models/DomainModels/book_details_model.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/favorite_record_creation_model.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/favorite_record_deletion_model.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/member_favorite_record_model.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_book_repo.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_patron_favorites_management_repo.dart';
import 'package:flutter/material.dart';

class BookDetailsViewModel extends ChangeNotifier
{
  final IBookRepo bookRepo;
  final IPatronFavoritesManagementRepo patronFavoritesManagementRepo;

  BookDetailsViewModel({required this.bookRepo,required this.patronFavoritesManagementRepo});

  BookDetailsModel _bookDetails = BookDetailsModel.isEmpty();
  BookDetailsModel get bookDetails => _bookDetails;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getBookDetails(int bookRecordID,int memberRecordID) async
  {
    _isLoading = true;
    notifyListeners();

    _bookDetails = await bookRepo.getBookDetails(bookRecordID, memberRecordID);

    _isLoading = false;
    notifyListeners();
  }

  bool _toggleFavoriteStatus()
  {
    _bookDetails.inFavorites = !_bookDetails.inFavorites;
    notifyListeners();
    return _bookDetails.inFavorites;
  }

  Future<void> handleFavoriteIconPressing(int memberRecordID) async
  {
    bool inFavorites = _toggleFavoriteStatus();
    _bookDetails.isFavoriteLoading = true;
    notifyListeners();

    if (inFavorites)
    {
     await  _addNewFavoriteRecordInDB(memberRecordID);
    }
    else
    {
      await _deleteFavoriteRecordFromDB();
    }

     _bookDetails.isFavoriteLoading = false;
     notifyListeners();
  }

  Future<void> _addNewFavoriteRecordInDB(int memberRecordID) async
  {
    MemberFavoriteRecordModel record = MemberFavoriteRecordModel(
      recordID: -1,
      memberRecordID: memberRecordID,
      bookRecordID: _bookDetails.bookRecordID,
      dateAdded: DateTime.now(),
    );

    FavoriteRecordCreationModel model=await patronFavoritesManagementRepo.addNewFavoriteRecordInDB(record);
    
    int favoriteRecordID =model.favoriteRecordID; 

    if (favoriteRecordID != -1)
    {
      _bookDetails.favoriteRecordID = favoriteRecordID;
      notifyListeners();
     
    }
    else
    {
       _toggleFavoriteStatus(); //roll back
    }
  }

  Future<void> _deleteFavoriteRecordFromDB() async
  {
    
    FavoriteRecordDeletionModel model=await patronFavoritesManagementRepo.deleteFavoriteRecordFromDB(_bookDetails.favoriteRecordID!);
    bool result = model.isDeleted;

    if (!result)
    {
      _toggleFavoriteStatus();
    }
  }
}