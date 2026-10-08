import 'package:biblio_track_patron_portal/Data/Models/DomainModels/borrowed_copy_model.dart';

class BookCopyAvailabilityModel
{
  final int? availableBookCopyID;
  final List<BorrowedCopyModel> borrowedCopies;
  final String? errorMessage;

  BookCopyAvailabilityModel({
    required this.availableBookCopyID,
    required this.borrowedCopies,
    this.errorMessage
  });
}