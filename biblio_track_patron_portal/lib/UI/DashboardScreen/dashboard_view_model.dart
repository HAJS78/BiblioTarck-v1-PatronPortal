

import 'package:biblio_track_patron_portal/Data/Models/DomainModels/book_card_model.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/catalog_search_result_model.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/patron_recommendation_model.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/notification_summary_model.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_book_search_repo.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_notification_summary_repo.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_patron_favorites_management_repo.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_patron_recommendation_repo.dart';
import 'package:biblio_track_patron_portal/UI/Shared/Handlers/favorite_toggle_handler.dart';
import 'package:flutter/material.dart';



class DashboardViewModel extends ChangeNotifier 
{
  final IPatronRecommendationRepo  patronRecommendationRepo;
  final INotificationSummaryRepo  notificationSummaryRepo;
  
  final IBookSearchRepo bookSearchRepo;
  final IPatronFavoritesManagementRepo patronFavoritesManagementRepo;

  final FavoriteToggleHandler _favoriteToggleHandler;
  
  DashboardViewModel({required this.patronRecommendationRepo,required this.notificationSummaryRepo,required this.bookSearchRepo,required this.patronFavoritesManagementRepo}):
  _favoriteToggleHandler=FavoriteToggleHandler(patronFavoritesManagementRepo);

  
   
 String get currentDateTime=>
  
        "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year} "
       "${DateTime.now().hour}:${DateTime.now().minute}";
  
  


PatronRecommendationModel _patronRecommendationModel=PatronRecommendationModel(recommendedBooks:List.empty());


String? _recommendationErrorMessage;
String? get recommendationErrorMessage => _recommendationErrorMessage;

bool _isLoadingRecommendations = false;
bool get isLoadingRecommendations => _isLoadingRecommendations;

 Future<void> getPatronRecommendation(int memberRecordID)async
 {
   _isLoadingRecommendations=true;
  notifyListeners();
  
 _patronRecommendationModel=await patronRecommendationRepo.getRecommendedBooks(memberRecordID);
  _recommendedBooks=_patronRecommendationModel.recommendedBooks; 
  _recommendationErrorMessage=_patronRecommendationModel.errorMessage;
  notifyListeners();

  _isLoadingRecommendations=false;
  notifyListeners();
 }
 
 

 NotificationSummaryModel _notificationSummaryModel= NotificationSummaryModel(overdueItemsCount: 0, reservedItemsCount: 0);
 

Future<void> getNotificationSummary(int memberRecordID)async
{
  _notificationSummaryModel=await notificationSummaryRepo.getNotificationSummary(memberRecordID);
  notifyListeners();
}

 String get totalNumberOfNotifications
 {
   int number= _notificationSummaryModel.overdueItemsCount+_notificationSummaryModel.reservedItemsCount;
   return number.toString();


 }


 late  List<BookCardModel> _recommendedBooks=[]; 

 List<BookCardModel> get recommendedBooks=>_recommendedBooks;

 bool _showRecommendedBooksList=true;
 bool get showRecommendedBooksList=>_showRecommendedBooksList;

 void showSearchResultsList()
 {
       if(_showRecommendedBooksList)
       {
      _showRecommendedBooksList=!_showRecommendedBooksList;
       }
 }

  void hideSearchResultsList()
 {
      _showRecommendedBooksList=true;
      _iSSearching=false;
      _searchResults=[];
      notifyListeners();


 }

 late List<BookCardModel> _searchResults=[] ;
 List<BookCardModel> get searchResults=>_searchResults;

String searchFilter = "Title"; // default filter

bool _iSSearching=false;
bool get iSSearching=>_iSSearching; 

String? _searchErrorMessage;
String? get searchErrorMessage => _searchErrorMessage;

Future<void> searchBy(int memberRecordId, String filterType, String searchKeyword) async
{
    _iSSearching=true; 
     notifyListeners();

     if(filterType=='')
     {

      filterType = "Title";
     }
     //must pass memberRecordId to this VM
      CatalogSearchResultModel model=await bookSearchRepo.searchCatalog(memberRecordId,filterType,searchKeyword);
      _searchResults =  model.searchResults;
      _searchErrorMessage=model.errorMessage;
      _iSSearching=false; 
       notifyListeners();
}


Future<void> handleFavoriteIconPressing(int bookRecordID,
    String bookTitle,int memberRecordID,int? favoriteRecordID) async
   {
    
    List<BookCardModel> list = _showRecommendedBooksList ? recommendedBooks : searchResults;
    
    await _favoriteToggleHandler.handleFavoriteIconPressing(
      targetList: list,
      bookRecordID: bookRecordID,
      bookTitle: bookTitle,
      memberRecordID: memberRecordID,
      favoriteRecordID: favoriteRecordID,
      notify: notifyListeners,
    );
  }









  

  
}
