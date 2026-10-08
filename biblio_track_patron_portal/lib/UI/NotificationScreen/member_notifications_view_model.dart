import 'package:biblio_track_patron_portal/Data/Models/DomainModels/member_notification_message_model.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/member_notification_model.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/notification_update_result_model.dart';
//import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_book_repo.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_patron_notifications_repo.dart';
import 'package:flutter/material.dart';



class MemberNotificationViewModel extends ChangeNotifier 
{
  
   final IPatronNotificationsRepo notificationsRepo;

   MemberNotificationViewModel({required this.notificationsRepo});
  

   List<MemberNotificationMessageModel> _messages = [];
   List<MemberNotificationMessageModel> get messages => _messages;
  
   String? _errorMessage='';
   String? get errorMessage=>_errorMessage;


   bool _isLoading =false;
   bool get isLoading=>_isLoading;
  
   Future<void> loadNotifications(int memberRecordID) async 
   {
     _messages.clear();

     _isLoading=true;
    notifyListeners();

    MemberNotificationModel model=await  notificationsRepo.loadNotifications(memberRecordID); 
    _messages=model.notifications;
    _errorMessage=model.errorMessage;
   _isLoading=false;
    notifyListeners();

   }

  

  void removeItemFromViewModelList(int id)
  {
   for(int i=0;i< _messages.length;i++)
   {
        if(_messages[i].notificationId==id)
        {

          _messages.removeAt(i);
          break;
        }

   }
  }

  
  
  String? _updateIsReadStatusErrorMsg;
  String? get  updateIsReadStatusErrorMsg=>_updateIsReadStatusErrorMsg;
// member_notifications_view_model.dart

void clearUpdateIsReadStatusErrorMessage() 
{
  _updateIsReadStatusErrorMsg =null;
   notifyListeners();
}

 void  _reinsertRemovedItem(MemberNotificationMessageModel removedMessage)
   {
      //always reinsert at 0
      _messages.insert(0, removedMessage);

   }

  void markAsRead(int notificationId)async   
   {
    //index and item to be removed
    final int index = _messages.indexWhere((m) => m.notificationId == notificationId);
    final removedMessage = _messages[index];

    //Optimistic Update: Remove from list and update UI instantly
    removeItemFromViewModelList(notificationId);
    notifyListeners();
    
   NotificationUpdateResultModel result = await notificationsRepo.updateNotificationReccord(notificationId);

      if(!result.isUpdated)
      {
          _reinsertRemovedItem(removedMessage);
          _updateIsReadStatusErrorMsg = result.errorMessage ?? 'Unable to update notification.';
      }
    
    notifyListeners();
    
    
    }
        
    
  }

