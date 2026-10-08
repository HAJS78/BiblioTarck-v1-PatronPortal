import 'package:biblio_track_patron_portal/Data/Models/DTOs/borrowed_copy_dto.dart';

class BookCopyAvailabilityDTO
{
  final int? availableBookCopyID;
  final List<BorrowedCopyDTO> borrowedCopies;
  final String? errorMessage;

  BookCopyAvailabilityDTO({
    required this.availableBookCopyID,
    required this.borrowedCopies,
    this.errorMessage
  });

  static BookCopyAvailabilityDTO fromJson(Map<String, dynamic> json)
  {
    try
    {
      if (json['success'] == true && json['data'] != null)
      {
        return BookCopyAvailabilityDTO(
          availableBookCopyID: json['data']['availableBookCopyID'],
          borrowedCopies: BorrowedCopyDTO.fromJsonList(json['data']['borrowedCopies']),
        );
      }
      else
      {
        return BookCopyAvailabilityDTO(
          availableBookCopyID: null,
          borrowedCopies: List.empty(),
          errorMessage: json['error'] ?? 'Unknown error',
        );
      }
    }
    catch (e)
    {
      return BookCopyAvailabilityDTO(
        availableBookCopyID: null,
        borrowedCopies: List.empty(),
        errorMessage: 'Failed to parse server response: $e',
      );
    }
  }
}