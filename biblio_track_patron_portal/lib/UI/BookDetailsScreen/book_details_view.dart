import 'package:biblio_track_patron_portal/UI/BookDetailsScreen/book_details_view_model.dart';
import 'package:biblio_track_patron_portal/UI/Theme/app_colors.dart';
import 'package:biblio_track_patron_portal/UI/Theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BookDetailsView extends StatefulWidget
{
  final int bookRecordID;
  final int memberRecordID;
  

  const BookDetailsView({super.key, required this.bookRecordID, required this.memberRecordID});

  @override
  State<BookDetailsView> createState() => _BookDetailsViewState();
}

class _BookDetailsViewState extends State<BookDetailsView>
{
  late BookDetailsViewModel bookDetailsViewModel;

  @override
  void initState()
  {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async
      {
        bookDetailsViewModel = context.read<BookDetailsViewModel>();
        await bookDetailsViewModel.getBookDetails(widget.bookRecordID,widget.memberRecordID);
      },
    );
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(title: const Text("Book Details")),
      body: SafeArea(
        child: Consumer<BookDetailsViewModel>(
          builder: (context, viewModel, child)
          {
            if (viewModel.isLoading)
            {
              return Center(
                child: SizedBox(
                  height: 60.h,
                  width: 60.w,
                  child: const CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
                ),
              );
            }

            if (viewModel.bookDetails.errorMessage != null)
            {
              return Center(child: Text(viewModel.bookDetails.errorMessage!,style: AppTextStyles.errorMessage,));
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Center(
                    child: Image.network(
                      viewModel.bookDetails.bookCoverImageUrl,
                      height: 220.h,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(Icons.book, color: AppColors.textSecondary, size: 140.sp),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    viewModel.bookDetails.title,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.title,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    viewModel.bookDetails.author,
                    style: AppTextStyles.subtitle,
                  ),
                  SizedBox(height: 8.h),
                  IconButton(
                  onPressed: viewModel.bookDetails.isFavoriteLoading ? null : () => viewModel.handleFavoriteIconPressing(widget.memberRecordID),
                  icon: viewModel.bookDetails.isFavoriteLoading
                   ? const Padding(
                   padding: EdgeInsets.all(12.0),
                  child: SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.favorite)),
                   )
                      : viewModel.bookDetails.inFavorites
                    ? const Icon(Icons.favorite, color: AppColors.favorite)
                    : const Icon(Icons.favorite_border, color: AppColors.unfavorite),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    viewModel.bookDetails.summary,
                    style: AppTextStyles.body,
                  ),
                  SizedBox(height: 30.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => context.push(
                        '/Reservation',
                        extra: {
                          'bookRecordID': viewModel.bookDetails.bookRecordID,
                          'title': viewModel.bookDetails.title,
                        },
                      ),
                      child:Text("Reserve",style: AppTextStyles.button),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}