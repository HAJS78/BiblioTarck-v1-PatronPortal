import 'package:biblio_track_patron_portal/UI/SharedWidgets/book_card.dart';
import 'package:biblio_track_patron_portal/UI/FavoritesScreen/favorite_view_model.dart';
import 'package:biblio_track_patron_portal/UI/Theme/app_colors.dart';
import 'package:biblio_track_patron_portal/UI/Theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';

class FavoritesView extends StatefulWidget
 {
  final int memberRecordID;
  final String userName;
  
  const FavoritesView({super.key,required this.memberRecordID,required this.userName});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}



class _FavoritesViewState extends State<FavoritesView> 
{
  late FavoritesViewModel favoritesViewModel;
  
  @override
  void initState()
  {
   super.initState();

    

    WidgetsBinding.instance.addPostFrameCallback(
    
    (_)async 
    {
       favoritesViewModel=context.read<FavoritesViewModel>();
       await favoritesViewModel.getFavorites(widget.memberRecordID);
          
       
   
    }
    
    );
  

  }


  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      
      appBar: AppBar(
        title: Text('${widget.userName}\'s Favorites'),
      ),
      body:SafeArea(child: 
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: 
                      
            Consumer<FavoritesViewModel>(
                  builder: (context, viewModel, child) 
                  {
                    if(viewModel.isLoading)
                   {
                    return 
                                        
                    Center(
                      child: SizedBox( height: 60.h, width: 60.w,
                                child:  CircularProgressIndicator(strokeWidth: 2,color:AppColors.primary)),
                    );
                   }

                   if (viewModel.errorMessage != null)
                    {
                      return Center(child: Text(viewModel.errorMessage ?? 'Unable to load favorites.', style: AppTextStyles.errorMessage));
                    }

                    if (viewModel.favoriteBooks.isEmpty)
                    {
                      return Center(child: Text('You have no favorites yet.', style: AppTextStyles.subtitle));
                    }
                    
                    return 
                    ListView.builder(itemCount:viewModel.favoriteBooks.length , itemBuilder:(context,index)
                    { 
                      return 
                      
                            BookCard(title: viewModel.favoriteBooks[index].title, author:viewModel.favoriteBooks[index].author,bookCoverImageUrl: viewModel.favoriteBooks[index].bookCoverImageUrl,inFavorites:viewModel.favoriteBooks[index].inFavorites,isFavoriteLoading:viewModel.favoriteBooks[index].isFavoriteLoading ,onPressingFavoriteIcon: ()=>  viewModel.handleFavoriteIconPressing(viewModel.favoriteBooks[index].bookRecordID,viewModel.favoriteBooks[index].title,widget.memberRecordID,viewModel.favoriteBooks[index].favoriteRecordID),onTappingTheCard: ()async
                            {
                            await context.push('/BookDetails',extra:{'memberRecordID':widget.memberRecordID,'bookRecordID':viewModel.favoriteBooks[index].bookRecordID});
                            await favoritesViewModel.getFavorites(widget.memberRecordID);
                                                       
                            });
                    }
                    );
                  },
                ),
              ),
            
                   ),
         
      
    );
  }




}




