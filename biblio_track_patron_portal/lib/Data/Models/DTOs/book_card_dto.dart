class BookCardDTO 
{
final int bookRecordID;
final String title;
final String author;
final String bookCoverImageUrl;
final bool inFavorites;
int? favoriteRecordID;
 
  BookCardDTO ({required this.bookRecordID,  required this.title, required this.author,required this.bookCoverImageUrl,required this.inFavorites,this.favoriteRecordID});
     

BookCardDTO.isEmpty()

      : bookRecordID=-1,
        title='N/a',
        author='N/A',
        bookCoverImageUrl='',
        inFavorites=false,
        favoriteRecordID=-1;


static BookCardDTO fromJson(Map<String, dynamic> data) 
  {
    return BookCardDTO(
      bookRecordID:data['bookRecordID'],
      title: data['title'],
     author: data['author'],
     bookCoverImageUrl: data['bookCoverImageUrl'],
     inFavorites:data['inFavorites'] ,
     favoriteRecordID: data['favoriteRecordID']
     
    );
  }


static List<BookCardDTO> fromJsonList( List<dynamic> data) 
  {
    List<BookCardDTO> books=[];
    
    for(var item in data)
    {
      books.add(BookCardDTO(
      bookRecordID:item['bookRecordID'],
      title: item['title'],
      author:item['author'],
      bookCoverImageUrl: item['bookCoverImageUrl'] ,
      inFavorites:item['inFavorites'] ,
      favoriteRecordID: item['favoriteRecordID']
    ));
    }

    return books;
  }



}