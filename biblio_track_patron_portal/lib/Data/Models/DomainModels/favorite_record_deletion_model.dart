class FavoriteRecordDeletionModel 
{
  final bool isDeleted;
  final String? errorMessage;

  FavoriteRecordDeletionModel({
    required this.isDeleted,
    this.errorMessage,
  });
}