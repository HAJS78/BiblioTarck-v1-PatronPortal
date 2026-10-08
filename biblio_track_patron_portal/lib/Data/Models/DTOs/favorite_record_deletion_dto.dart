class FavoriteRecordDeletionDTO 
{
  final bool isDeleted;
  final String? errorMessage;

  FavoriteRecordDeletionDTO({
    required this.isDeleted,
    this.errorMessage,
  });

  static FavoriteRecordDeletionDTO fromJson(Map<String, dynamic> json) {
    try {
      if (json['success'] == true && json['data'] != null) {
        return FavoriteRecordDeletionDTO(
          isDeleted: json['data']['isDeleted'] ?? false,
        );
      } else {
        return FavoriteRecordDeletionDTO(
          isDeleted: false,
          errorMessage: json['error'] ?? 'Unknown error',
        );
      }
    } catch (e) {
      return FavoriteRecordDeletionDTO(
        isDeleted: false,
        errorMessage: 'Failed to parse server response: $e',
      );
    }
  }
}