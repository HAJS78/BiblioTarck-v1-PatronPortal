class BookCardModel 
{
final int bookRecordID;
final String title;
final String author;
final String bookCoverImageUrl;
late bool inFavorites;
int? favoriteRecordID;
bool isFavoriteLoading=false;
 
  BookCardModel ({required this.bookRecordID, required this.title, required this.author,required this.bookCoverImageUrl,required this.inFavorites,this.favoriteRecordID});
   

BookCardModel.isEmpty()
      : bookRecordID=-1,
        title='N/a',
        author='N/A',
        bookCoverImageUrl='',
        inFavorites=false,
       favoriteRecordID=-1;

}