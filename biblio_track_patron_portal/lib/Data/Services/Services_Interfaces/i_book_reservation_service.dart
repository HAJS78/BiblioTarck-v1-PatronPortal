import 'package:biblio_track_patron_portal/Data/Models/DTOs/book_copy_availability_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/reservation_confirmation_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/reservation_dto.dart';

abstract class IBookReservationService 
{
Future<BookCopyAvailabilityDTO> getBookCopyAvailability(int bookRecordID);
Future<ReservationConfirmationDTO> confirmReservation(ReservationDto reservation);


}