import 'package:biblio_track_patron_portal/UI/Theme/app_colors.dart';
import 'package:biblio_track_patron_portal/UI/Theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'member_notifications_view_model.dart';

class MemberNotificationView extends StatefulWidget 
{
  final int memberRecordID;

  const MemberNotificationView({super.key, required this.memberRecordID});

  @override
  State<MemberNotificationView> createState() => _MemberNotificationViewState();
}



class _MemberNotificationViewState extends State<MemberNotificationView> 
{

@override
  void initState()
  {
    
    super.initState();
   
 WidgetsBinding.instance.addPostFrameCallback(
    
    (_) 
    {
     MemberNotificationViewModel model=context.read<MemberNotificationViewModel>();
     model.loadNotifications(widget.memberRecordID); 

    });

  

  }

  @override
  Widget build(BuildContext context) 
  {
     return 
     Scaffold(
        appBar: AppBar(
          title: const Text("Notifications"),
        ),
        body: Consumer<MemberNotificationViewModel>(
          builder: (context, vm, child) 
          {
            //handling error message for update notification status
            if (vm.updateIsReadStatusErrorMsg != null && vm.updateIsReadStatusErrorMsg!.isNotEmpty) 
            {
          
                  WidgetsBinding.instance.addPostFrameCallback((_) 
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(vm.updateIsReadStatusErrorMsg!,style: AppTextStyles.errorMessage),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    
                    vm.clearUpdateIsReadStatusErrorMessage();
                  });
             }
             //handling loading, error, and empty states
             if (vm.isLoading)
             {
                    return Center(
                      child: SizedBox( height: 60.h, width: 60.w,
                                child: const CircularProgressIndicator(strokeWidth: 2,color: AppColors.primary)),
                    );
            }
            if (vm.errorMessage != null)
            {
                    return Center(child: Text(vm.errorMessage ?? 'Unable to load notifications.', style: AppTextStyles.errorMessage));
            }

            if (vm.messages.isEmpty)
            {
                  return Center(child: Text("No new notifications", style: AppTextStyles.subtitle));
            }
            return
               ListView.builder(
              itemCount: vm.messages.length,
              itemBuilder: (context, index) 
              {
                             
                  return 
                               
                  Dismissible(
                  key: ValueKey(vm.messages[index].notificationId),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (_) => vm.markAsRead(vm.messages[index].notificationId),
                  background: Container(
                    color:AppColors.accent,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.done, color: Colors.white),
                  ),
                  child: ListTile(
                    leading: Icon(
                      vm.messages[index].type == "OverdueItems"
                          ? Icons.warning
                          : Icons.bookmark,
                      color: vm.messages[index].type == "OverdueItems"
                          ? Colors.red
                          : Colors.blue,
                    ),
                    title: Text(vm.messages[index].title,style: AppTextStyles.title),
                    subtitle: Text(vm.messages[index].body, style: AppTextStyles.body),
                  ),
                );
              },
            );
          },
        ),
      
    );
  }
}
