class ReservationDto
{
  final int reservationID;
  final int libraryCardRecordID;
  final int bookCopyRecordID;
  final DateTime reservationDate;
  final int reservationStatus;
  final String? errorMessage;

  ReservationDto({
    required this.reservationID,
    required this.libraryCardRecordID,
    required this.bookCopyRecordID,
    required this.reservationDate,
    required this.reservationStatus,
    this.errorMessage
  });

  Map<String, dynamic> toJson()
  {
    return
    {
      "reservationID": -1,
      "libraryCardRecordID": libraryCardRecordID,
      "bookCopyRecordID": bookCopyRecordID,
      "reservationDate": reservationDate.toIso8601String(),
      "reservationStatus": reservationStatus,
    };
  }

  static ReservationDto fromJson(Map<String, dynamic> json)
  {
    try
    {
      if (json['success'] == true && json['data'] != null)
      {
        return ReservationDto(
          reservationID: json['data']['reservationID'],
          libraryCardRecordID: json['data']['libraryCardRecordID'],
          bookCopyRecordID: json['data']['bookCopyRecordID'],
          reservationDate: DateTime.parse(json['data']['reservationDate']),
          reservationStatus: json['data']['reservationStatus'],
        );
      }
      else
      {
        return ReservationDto(
          reservationID: -1,
          libraryCardRecordID: -1,
          bookCopyRecordID: -1,
          reservationDate: DateTime.now(),
          reservationStatus: -1,
          errorMessage: json['error'] ?? 'Unknown error',
        );
      }
    }
    catch (e)
    {
      return ReservationDto(
        reservationID: -1,
        libraryCardRecordID: -1,
        bookCopyRecordID: -1,
        reservationDate: DateTime.now(),
        reservationStatus: -1,
        errorMessage: 'Failed to parse server response: $e',
      );
    }
  }
}