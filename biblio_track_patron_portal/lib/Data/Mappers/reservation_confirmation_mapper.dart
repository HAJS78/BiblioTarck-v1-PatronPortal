import 'package:biblio_track_patron_portal/Data/Models/DTOs/reservation_confirmation_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/reservation_confirmation_model.dart';

class ReservationConfirmationMapper
{
  static ReservationConfirmationModel fromDTO(ReservationConfirmationDTO dto)
  {
    return ReservationConfirmationModel(
      reservationID: dto.reservationID,
      errorMessage: dto.errorMessage
    );
  }
}