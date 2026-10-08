

import 'package:biblio_track_patron_portal/Data/Models/DomainModels/book_card_model.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/member_favorites_model.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_patron_favorites_management_repo.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_patron_favorites_query_repo.dart';
import 'package:biblio_track_patron_portal/UI/Shared/Handlers/favorite_toggle_handler.dart';
import 'package:flutter/material.dart';





class FavoritesViewModel extends ChangeNotifier 
{


 final IPatronFavoritesManagementRepo patronFavoritesManagementRepo;
 final IPatronFavoritesQueryRepo patronFavoritesQueryRepo;
 
 final FavoriteToggleHandler _favoriteToggleHandler;
 

 FavoritesViewModel({required this.patronFavoritesManagementRepo,required this.patronFavoritesQueryRepo}):
  
_favoriteToggleHandler=FavoriteToggleHandler(patronFavoritesManagementRepo);

 
 
 List<BookCardModel> _favoriteBooks=[];

 List<BookCardModel> get favoriteBooks=>_favoriteBooks;

 String? _errorMessage='';

 String? get errorMessage=>_errorMessage;

 bool _isLoading =false;

 bool get isLoading=>_isLoading;

 Future<void> getFavorites(int memberRecordID)async 
 {

  _isLoading=true;
  notifyListeners();

   MemberFavoritesModel model =await patronFavoritesQueryRepo.getFavorites(memberRecordID);
  _favoriteBooks=model.memberFavorites;
  _errorMessage=model.errorMessage;
  _isLoading=false;
  notifyListeners();

 }
 

Future<void> handleFavoriteIconPressing(int bookRecordID,
    String bookTitle,int memberRecordID,int? favoriteRecordID) async
   {
    await _favoriteToggleHandler.handleFavoriteIconPressing(
      targetList: _favoriteBooks,
      bookRecordID: bookRecordID,
      bookTitle: bookTitle,
      memberRecordID: memberRecordID,
      favoriteRecordID: favoriteRecordID,
      notify: notifyListeners,
    );
  }
  
}
