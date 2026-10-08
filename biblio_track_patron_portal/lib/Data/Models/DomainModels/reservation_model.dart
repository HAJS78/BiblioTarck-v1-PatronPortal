class ReservationModel
{
  final int reservationID;
  final int libraryCardRecordID;
  final int bookCopyRecordID;
  final DateTime reservationDate;
  final int reservationStatus;
  final String? errorMessage;

  ReservationModel({
    required this.reservationID,
    required this.libraryCardRecordID,
    required this.bookCopyRecordID,
    required this.reservationDate,
    required this.reservationStatus,
    this.errorMessage
  });
}