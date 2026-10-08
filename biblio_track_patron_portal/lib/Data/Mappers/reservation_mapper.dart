import 'package:biblio_track_patron_portal/Data/Models/DTOs/reservation_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/reservation_model.dart';

class ReservationMapper
{
  static ReservationModel fromDTO(ReservationDto dto)
  {
    if (dto.errorMessage == null)
    {
      return ReservationModel(
        reservationID: dto.reservationID,
        libraryCardRecordID: dto.libraryCardRecordID,
        bookCopyRecordID: dto.bookCopyRecordID,
        reservationDate: dto.reservationDate,
        reservationStatus: dto.reservationStatus,
      );
    }
    else
    {
      return ReservationModel(
        reservationID: -1,
        libraryCardRecordID: -1,
        bookCopyRecordID: -1,
        reservationDate: DateTime.now(),
        reservationStatus: -1,
        errorMessage: dto.errorMessage,
      );
    }
  }

  static ReservationDto toDTO(ReservationModel model)
  {
    return ReservationDto(
      reservationID: model.reservationID,
      libraryCardRecordID: model.libraryCardRecordID,
      bookCopyRecordID: model.bookCopyRecordID,
      reservationDate: model.reservationDate,
      reservationStatus: model.reservationStatus,
    );
  }
}