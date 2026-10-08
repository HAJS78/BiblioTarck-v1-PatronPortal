class BookDetailsDTO
{
  final int bookRecordID;
  final String title;
  final String author;
  final String bookCoverImageUrl;
  final String summary;
  final bool inFavorites;
  final int? favoriteRecordID;
  final String? errorMessage;

  BookDetailsDTO({
    required this.bookRecordID,
    required this.title,
    required this.author,
    required this.bookCoverImageUrl,
    required this.summary,
    required this.inFavorites,
    this.favoriteRecordID,
    this.errorMessage
  });

  static BookDetailsDTO fromJson(Map<String, dynamic> json)
  {
    try
    {
      if (json['success'] == true && json['data'] != null)
      {
        return BookDetailsDTO(
          bookRecordID: json['data']['bookRecordID'],
          title: json['data']['title'],
          author: json['data']['author'],
          bookCoverImageUrl: json['data']['bookCoverImageUrl'],
          summary: json['data']['summary'],
          inFavorites: json['data']['inFavorites'],
          favoriteRecordID: json['data']['favoriteRecordID'],
        );
      }
      else
      {
        return BookDetailsDTO(
          bookRecordID: -1,
          title: 'N/A',
          author: 'N/A',
          bookCoverImageUrl: '',
          summary: '',
          inFavorites: false,
          favoriteRecordID: null,
          errorMessage: json['error'] ?? 'Unknown error',
        );
      }
    }
    catch (e)
    {
      return BookDetailsDTO(
        bookRecordID: -1,
        title: 'N/A',
        author: 'N/A',
        bookCoverImageUrl: '',
        summary: '',
        inFavorites: false,
        favoriteRecordID: null,
        errorMessage: 'Failed to parse server response: $e',
      );
    }
  }
}