import 'package:biblio_track_patron_portal/UI/Theme/app_colors.dart';
import 'package:biblio_track_patron_portal/UI/Theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';




class BookCard extends StatelessWidget
{
  
  final String title;
  final String author;
  final String bookCoverImageUrl;
  final bool inFavorites;
  final VoidCallback onPressingFavoriteIcon; 
  final VoidCallback onTappingTheCard;
  final bool isFavoriteLoading;
  const BookCard({super.key, required this.title, required this.author,required this.bookCoverImageUrl,required this.inFavorites,required this.isFavoriteLoading,required this.onPressingFavoriteIcon,required this.onTappingTheCard});


@override
Widget build(BuildContext context) 
{
  return InkWell(onTap:onTappingTheCard,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h), 
      child: Card(
        elevation: 4,
         child: Column(
          
          children: [
            bookCoverImage(),
            SizedBox(height: 8.h),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 12.w),
              child: Text(title, style: AppTextStyles.title.copyWith(fontSize: 12.sp),textAlign: TextAlign.center),
            ),
            Text(author, style: AppTextStyles.subtitle),
             IconButton(onPressed:isFavoriteLoading?null:onPressingFavoriteIcon,
             icon: isFavoriteLoading
                 ?SizedBox(width: 16.w, height: 16.h, child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.favorite))
                  : inFavorites? Icon(Icons.favorite,color:AppColors.favorite):Icon(Icons.favorite_outline,color:AppColors.unfavorite)),
             
            
            
          ],
        ),
      )),
    
  );
}



 Widget bookCoverImage()
{
return  
  
  
 
     Padding(
       padding: EdgeInsets.symmetric(vertical: 10.h),
       child: Image.network(
                  bookCoverImageUrl,
                  height: 120.h,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.book,color: AppColors.accent, size: 80.sp),
                ),
     );
  
  

}

}