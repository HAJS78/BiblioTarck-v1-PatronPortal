class LibraryCardLookupDTO
{
  final int libraryCardRecordID;
  final String? errorMessage;

  LibraryCardLookupDTO({
    required this.libraryCardRecordID,
    this.errorMessage
  });

  static LibraryCardLookupDTO fromJson(Map<String, dynamic> json)
  {
    try
    {
      if (json['success'] == true && json['data'] != null)
      {
        return LibraryCardLookupDTO(
          libraryCardRecordID: json['data']['libraryCardRecordID'],
        );
      }
      else
      {
        return LibraryCardLookupDTO(
          libraryCardRecordID: -1,
          errorMessage: json['error'] ?? 'Unknown error',
        );
      }
    }
    catch (e)
    {
      return LibraryCardLookupDTO(
        libraryCardRecordID: -1,
        errorMessage: 'Failed to parse server response: $e',
      );
    }
  }
}