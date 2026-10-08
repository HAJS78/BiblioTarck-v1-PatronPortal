import 'package:biblio_track_patron_portal/Data/Models/DomainModels/book_card_model.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/catalog_search_result_model.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_book_search_repo.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_patron_favorites_management_repo.dart';
import 'package:biblio_track_patron_portal/UI/Shared/Handlers/favorite_toggle_handler.dart';
import 'package:flutter/material.dart';




enum CatalogSearchFilter 
{
  title('Title'),
  author('Author'),
  isbn('ISBN'),
  tag('Tag');
 
  // 1. Define the label property that  UI is looking for
  final String label;

  // 2. Create a constant constructor to assign the string to the label
  const CatalogSearchFilter(this.label);
}



class CatalogViewModel extends ChangeNotifier
{
  
 
  final IBookSearchRepo bookSearchRepo;
  final IPatronFavoritesManagementRepo patronFavoritesManagementRepo;

  final FavoriteToggleHandler _favoriteToggleHandler;

  CatalogViewModel({required this.bookSearchRepo,required this.patronFavoritesManagementRepo}):

_favoriteToggleHandler=FavoriteToggleHandler(patronFavoritesManagementRepo);


  CatalogSearchFilter _selectedFilter = CatalogSearchFilter.title;
  CatalogSearchFilter get selectedFilter => _selectedFilter;

  void setSearchFilter(CatalogSearchFilter filter)
  {
    _selectedFilter = filter;
    notifyListeners();
  }

  List<BookCardModel> _catalogResults = [];
  List<BookCardModel> get catalogResults => _catalogResults;

  bool _isSearching = false;
  bool get isSearching => _isSearching;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> searchCatalog(int memberRecordId, String searchKeyword) async
  {
    _isSearching = true;
    notifyListeners();
    //must pass memberRecordId to this VM
    CatalogSearchResultModel model = await bookSearchRepo.searchCatalog(memberRecordId, _selectedFilter.label, searchKeyword);

    _catalogResults = model.searchResults;
    _errorMessage = model.errorMessage;
    _isSearching = false;
    notifyListeners();
  }


Future<void> handleFavoriteIconPressing(int bookRecordID,String bookTitle,
    int memberRecordID,int? favoriteRecordID) async 
    {
    await _favoriteToggleHandler.handleFavoriteIconPressing(
      targetList: _catalogResults,
      bookRecordID: bookRecordID,
      bookTitle: bookTitle,
      memberRecordID: memberRecordID,
      favoriteRecordID: favoriteRecordID,
      notify: notifyListeners,
    );
  }



}