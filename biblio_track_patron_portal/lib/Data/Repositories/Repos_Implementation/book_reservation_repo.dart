import 'package:biblio_track_patron_portal/Data/Mappers/book_copy_availability_mapper.dart';
import 'package:biblio_track_patron_portal/Data/Mappers/reservation_confirmation_mapper.dart';
import 'package:biblio_track_patron_portal/Data/Mappers/reservation_mapper.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/book_copy_availability_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/reservation_confirmation_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/book_copy_availability_model.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/reservation_confirmation_model.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/reservation_model.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_book_reservation_repo.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_book_reservation_service.dart';

class BookReservationRepo implements IBookReservationRepo
{
 final IBookReservationService service;

  BookReservationRepo({required this.service});

@override
Future<BookCopyAvailabilityModel> getBookCopyAvailability(int bookRecordID) async
{
  BookCopyAvailabilityDTO dto = await service.getBookCopyAvailability(bookRecordID);
  return BookCopyAvailabilityMapper.fromDTO(dto);
}

@override
Future<ReservationConfirmationModel> confirmReservation(ReservationModel reservation) async
{
  ReservationConfirmationDTO dto = await service.confirmReservation(ReservationMapper.toDTO(reservation));
  return ReservationConfirmationMapper.fromDTO(dto);
}

}