import 'package:biblio_track_patron_portal/Data/Models/DomainModels/favorite_record_creation_model.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/favorite_record_deletion_model.dart';
import 'package:flutter/material.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/book_card_model.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/member_favorite_record_model.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_patron_favorites_management_repo.dart';

import '../Enums/en_record_status.dart';


class FavoriteToggleHandler 
{
  final IPatronFavoritesManagementRepo patronFavoritesManagementRepo;

  FavoriteToggleHandler(this.patronFavoritesManagementRepo);

  Future<void> handleFavoriteIconPressing({
    required List<BookCardModel> targetList,
    required int bookRecordID,
    required String bookTitle,
    required int memberRecordID,
    required int? favoriteRecordID,
    required VoidCallback notify,
  }) async 
  {
    _setFavoriteLoadingStatus(targetList, bookTitle, true, null, notify);

    bool inFavorites = _updateFavoriteStatus(targetList, bookTitle, notify);

    if (inFavorites) 
    {
      await _addNewFavoriteRecordInDB(
        targetList,
        bookRecordID,
        bookTitle,
        memberRecordID,
        notify,
      );
    } else 
    {
      await _deleteFavoriteRecordFromDB(
        targetList,
        favoriteRecordID,
        bookTitle,
        notify,
      );
    }
  }

  bool _updateFavoriteStatus(List<BookCardModel> list,String bookTitle,
    VoidCallback notify) 
  {
    bool inFavorites = false;
    for (var b in list) 
    {
      if (b.title == bookTitle)
      {
        b.inFavorites = !b.inFavorites;
        inFavorites = b.inFavorites;
        notify();
        break;
      }
    }
    return inFavorites;
  }

  void _setFavoriteLoadingStatus(List<BookCardModel> list,String bookTitle,
    bool isLoading, EnRecordStatus? recordStatus,
    VoidCallback notify)

  {
    for (var b in list) 
    {
      if (b.title == bookTitle) 
      {
        b.isFavoriteLoading = isLoading;
        if (recordStatus == EnRecordStatus.discarded && !b.isFavoriteLoading) 
        {
          b.favoriteRecordID = null; 
        }
        notify();
        break;
      }
    }
  }

  void _rollBackFavoriteStatus(List<BookCardModel> list,String bookTitle,
    VoidCallback notify)
     {
    for (var b in list)
     {
      if (b.title == bookTitle) 
      {
        b.inFavorites = !b.inFavorites;
        notify();
        break;
      }
    }
  }

  Future<void> _addNewFavoriteRecordInDB(List<BookCardModel> list,
    int bookRecordID,String bookTitle,int memberRecordID,
    VoidCallback notify) async 
    {
    MemberFavoriteRecordModel record = MemberFavoriteRecordModel(
      recordID: -1,
      memberRecordID: memberRecordID,
      bookRecordID: bookRecordID,
      dateAdded: DateTime.now(),
    );

    
    FavoriteRecordCreationModel model=await patronFavoritesManagementRepo.addNewFavoriteRecordInDB(record);
    int favoriteRecordID = model.favoriteRecordID;

    if (favoriteRecordID == -1) 
    {
      _rollBackFavoriteStatus(list, bookTitle, notify);
    } else
    {
      _updateFavoriteRecordID(list, favoriteRecordID, bookTitle);
    }
    _setFavoriteLoadingStatus(
      list,
      bookTitle,
      false,
      EnRecordStatus.added,
      notify,
    );
  }

  void _updateFavoriteRecordID(List<BookCardModel> list,int favoriteRecordID,
    String bookTitle)
    {
    for (var b in list) 
    {
      if (b.title == bookTitle) 
      {
        b.favoriteRecordID = favoriteRecordID;
        break;
      }
    }
  }

  Future<void> _deleteFavoriteRecordFromDB(List<BookCardModel> list,
    int? favoriteRecordID,String bookTitle,
    VoidCallback notify) async 
  
  {

    FavoriteRecordDeletionModel model=await patronFavoritesManagementRepo.deleteFavoriteRecordFromDB(favoriteRecordID!);
    bool result = model.isDeleted;

    if (!result) 
    {
      _rollBackFavoriteStatus(list, bookTitle, notify);
    }
    _setFavoriteLoadingStatus(list,bookTitle, false,
      EnRecordStatus.discarded,notify,
    );
  }
}