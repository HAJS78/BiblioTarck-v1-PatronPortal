class ReservationConfirmationModel
{
  final int reservationID;
  final String? errorMessage;

  ReservationConfirmationModel({
    required this.reservationID,
    this.errorMessage
  });
}