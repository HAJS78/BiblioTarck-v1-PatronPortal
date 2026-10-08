import 'package:biblio_track_patron_portal/Data/Models/DomainModels/book_copy_availability_model.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/reservation_confirmation_model.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/reservation_model.dart';

abstract class IBookReservationRepo 
{
 Future<BookCopyAvailabilityModel> getBookCopyAvailability(int bookRecordID);
Future<ReservationConfirmationModel> confirmReservation(ReservationModel reservation);


}