class FavoriteRecordCreationDTO 
{
  final int favoriteRecordID;
  final String? errorMessage;

  FavoriteRecordCreationDTO({
    required this.favoriteRecordID,
    this.errorMessage,
  });

  static FavoriteRecordCreationDTO fromJson(Map<String, dynamic> json) {
    try {
      if (json['success'] == true && json['data'] != null) {
        return FavoriteRecordCreationDTO(
          favoriteRecordID: json['data']['favoriteRecordID'] ?? -1,
        );
      } else {
        return FavoriteRecordCreationDTO(
          favoriteRecordID: -1,
          errorMessage: json['error'] ?? 'Unknown error',
        );
      }
    } catch (e) {
      return FavoriteRecordCreationDTO(
        favoriteRecordID: -1,
        errorMessage: 'Failed to parse server response: $e',
      );
    }
  }
}