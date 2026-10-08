
import 'package:biblio_track_patron_portal/UI/SharedWidgets/book_card.dart';
import 'package:biblio_track_patron_portal/UI/DashboardScreen/dashboard_view_model.dart';
import 'package:biblio_track_patron_portal/UI/Theme/app_colors.dart';
import 'package:biblio_track_patron_portal/UI/Theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatefulWidget
 {
  final int memberRecordID;
  final String userName;
  final String? photoUrl; 

  const DashboardView({super.key,required this.memberRecordID,required this.userName,this.photoUrl});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}



class _DashboardViewState extends State<DashboardView> 
{
  late DashboardViewModel dashboardViewModel;
  String _searchFilter='';
  final TextEditingController _searchController=TextEditingController();

  @override
  void initState()
  {
   super.initState();

    

    WidgetsBinding.instance.addPostFrameCallback(
    
    (_) 
    {
       dashboardViewModel=context.read<DashboardViewModel>();
       dashboardViewModel.getPatronRecommendation(widget.memberRecordID);
       dashboardViewModel.getNotificationSummary(widget.memberRecordID);   
       
   
    }
    
    );
  

  }


  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            Consumer<DashboardViewModel>(
              builder: (context, viewModel, child) 
              {
                return UserAccountsDrawerHeader(
                  accountName: Text(widget.userName),
                  accountEmail: Text(viewModel.currentDateTime),
                  currentAccountPicture:widget.photoUrl==null? const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/profile_pic.png')):
                    CircleAvatar(backgroundImage: AssetImage(widget.photoUrl!))                  ,
                );
              },
            ),
            ListTile(onTap: ()
            {
               Navigator.pop(context);
               context.push('/CatalogSearch',extra: { "memberRecordID": widget.memberRecordID});  
            },title: Text("Search Library Catalog", style: AppTextStyles.body)               
               ),
            
            ListTile(onTap: ()
            {
            Navigator.pop(context);  
            context.push('/Fines',extra: { "memberRecordID": widget.memberRecordID});
            },  title: Text("Fines", style: AppTextStyles.body)),

            ListTile(onTap:()
            {
              context.push('/Favorites',extra: { "memberRecordID": widget.memberRecordID,"userName":widget.userName});
            } , title: Text("My Favorites", style: AppTextStyles.body)),
            Consumer<DashboardViewModel>(
              builder: (context, viewModel, child) 
              {
                return  ListTile(
                  onTap:()async
                  {
                   Navigator.pop(context); //closing the drawer
                  await context.push('/Notifications',extra:{'memberRecordID':widget.memberRecordID});
                  dashboardViewModel.getNotificationSummary(widget.memberRecordID);
                  
                  },title:Text('Notifications(${viewModel.totalNumberOfNotifications})', style: AppTextStyles.body)
                );
              },
            ),
            ListTile(onTap: ()=>context.go('/'),  title: Text("Sign Out", style: AppTextStyles.body)),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(widget.userName),
      ),
      body:SafeArea(child: 
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Column(
            children: [
              Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: (){_searchFilter='Title';},
          child:  Text("Title", style: AppTextStyles.button),
        ),
        TextButton(
          onPressed: (){_searchFilter='Author';},
          child:  Text("Author", style: AppTextStyles.button),
        ),

       
            ]),
               TextField(
                       controller: _searchController,
                      decoration: InputDecoration(
                        labelText: "Search For Books By \n Title or Author",
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: Consumer<DashboardViewModel>(
                   builder: (context, viewModel, child)
                   {
                      return 
                       viewModel.iSSearching ? Padding(
                         padding: EdgeInsets.all(12.w),
                         child: SizedBox(
                                    width: 16.w,
                                    height: 16.w,
                                    child: CircularProgressIndicator(strokeWidth: 2,color:AppColors.primary,),
                                  ),
                       ):Icon(null);
                                
                   }),

                      ),
                      onEditingComplete: ()=> _search(widget.memberRecordID),
                    )
                  
                ,
              SizedBox(height:10.h),
             
             Consumer<DashboardViewModel>(builder:(context,model,child)
             {
              return 
               TextButton(
            onPressed:model.showRecommendedBooksList?null:()=>_showRecommendedBooksList(),
            child:  Text("Show Recommended Books", style: AppTextStyles.button),
                   );
             }),
              SizedBox(height:10.h),
              Container(width:250.w,height:30.h, decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(8)), child: Align(alignment: .center,child: Consumer<DashboardViewModel>(builder:(context,viewModel,child)
              { 
              
              return 
                Text(viewModel.showRecommendedBooksList? 'Book Collection you might like':'Search Results',style: AppTextStyles.label);
              
                })
              )),
               SizedBox(height: 30.h,),
               
          
            Expanded(
                child: Consumer<DashboardViewModel>(
                  builder: (context, viewModel, child) 
                  {

                   if (viewModel.showRecommendedBooksList)
                   {
                          if (viewModel.isLoadingRecommendations)
                          {
                            return const Center(child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary));
                          }

                          if (viewModel.recommendationErrorMessage != null)
                          {
                            return Center(child: Text(viewModel.recommendationErrorMessage ?? 'Unable to load recommendations.', style: AppTextStyles.errorMessage));
                          }

                          if (viewModel.recommendedBooks.isEmpty)
                          {
                            return Center(child: Text('No recommendations available right now.', style: AppTextStyles.subtitle));
                          }
                    }
                        
                    else
                    {
                          if (viewModel.iSSearching)
                          {
                            return const Center(child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary));
                          }

                          if (viewModel.searchErrorMessage != null)
                          {
                            return Center(child: Text(viewModel.searchErrorMessage ?? 'Unable to complete search.', style: AppTextStyles.errorMessage));
                          }

                          if (viewModel.searchResults.isEmpty)
                          {
                            return Center(child: Text('No results found. Try a different search.', style: AppTextStyles.subtitle));
                          }
                    }

                  
                    return ListView.builder(itemCount:viewModel.showRecommendedBooksList? viewModel.recommendedBooks.length:viewModel.searchResults.length, itemBuilder:(context,index)
                    { 
                      return 
                       viewModel.showRecommendedBooksList?
                            BookCard(title: viewModel.recommendedBooks[index].title, author:viewModel.recommendedBooks[index].author,bookCoverImageUrl: viewModel.recommendedBooks[index].bookCoverImageUrl,inFavorites:viewModel.recommendedBooks[index].inFavorites,isFavoriteLoading: viewModel.recommendedBooks[index].isFavoriteLoading ,onPressingFavoriteIcon: ()=>  viewModel.handleFavoriteIconPressing(viewModel.recommendedBooks[index].bookRecordID,viewModel.recommendedBooks[index].title,widget.memberRecordID,viewModel.recommendedBooks[index].favoriteRecordID),onTappingTheCard: ()async 
                            {
                               await context.push('/BookDetails',extra: {'memberRecordID':widget.memberRecordID,'bookRecordID':viewModel.recommendedBooks[index].bookRecordID});
                              dashboardViewModel.getPatronRecommendation(widget.memberRecordID);
                            
                            

                            })
                            :
                            
                             BookCard(title: viewModel.searchResults[index].title, author:viewModel.searchResults[index].author,bookCoverImageUrl: viewModel.searchResults
                             [index].bookCoverImageUrl,inFavorites:viewModel.searchResults[index].inFavorites,isFavoriteLoading: viewModel.searchResults[index].isFavoriteLoading,onPressingFavoriteIcon:()=>  viewModel.handleFavoriteIconPressing(viewModel.searchResults[index].bookRecordID ,viewModel.searchResults[index].title,widget.memberRecordID,viewModel.searchResults[index].favoriteRecordID),onTappingTheCard: ()async 
                             {
                              await context.push('/BookDetails',extra: {'memberRecordID':widget.memberRecordID,'bookRecordID':viewModel.searchResults[index].bookRecordID});
                              dashboardViewModel.getPatronRecommendation(widget.memberRecordID);
                             
                             }
                             );
                    }    
                    );
                  },
                ),
              ),
            ],
                   ),
         ),
      
    ));
  }

void _search(int memberRecordId) async
{

  dashboardViewModel.showSearchResultsList();
  await  dashboardViewModel.searchBy(memberRecordId, _searchFilter, _searchController.text);
  
  


}
void _showRecommendedBooksList()
{

 
dashboardViewModel.hideSearchResultsList();



}



}




