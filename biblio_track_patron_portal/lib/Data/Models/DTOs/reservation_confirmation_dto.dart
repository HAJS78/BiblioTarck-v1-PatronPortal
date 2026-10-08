class ReservationConfirmationDTO
{
  final int reservationID;
  final String? errorMessage;

  ReservationConfirmationDTO({
    required this.reservationID,
    this.errorMessage
  });

  static ReservationConfirmationDTO fromJson(Map<String, dynamic> json)
  {
    try
    {
      if (json['success'] == true && json['data'] != null)
      {
        return ReservationConfirmationDTO(
          reservationID: json['data']['reservationID'],
        );
      }
      else
      {
        return ReservationConfirmationDTO(
          reservationID: -1,
          errorMessage: json['error'] ?? 'Unknown error',
        );
      }
    }
    catch (e)
    {
      return ReservationConfirmationDTO(
        reservationID: -1,
        errorMessage: 'Failed to parse server response: $e',
      );
    }
  }
}