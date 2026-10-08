class BookDetailsModel
{
  final int bookRecordID;
  final String title;
  final String author;
  final String bookCoverImageUrl;
  final String summary;
  late bool inFavorites;  //can this be converted into final and using static .copywith() from viewmodel 
                          //we use this style in the spendwise ,worth checking
  int? favoriteRecordID; 
  bool isFavoriteLoading=false;    
  final String? errorMessage;
  

  BookDetailsModel({
    required this.bookRecordID,
    required this.title,
    required this.author,
    required this.bookCoverImageUrl,
    required this.summary,
    required this.inFavorites,
    this.favoriteRecordID,
    this.errorMessage
  });

  BookDetailsModel.isEmpty()
      : bookRecordID = -1,
        title = 'N/a',
        author = 'N/A',
        bookCoverImageUrl = '',
        summary = '',
        inFavorites = false,
        favoriteRecordID = -1,
        errorMessage = null;
}