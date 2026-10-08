import 'package:dio/dio.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/book_copy_availability_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/reservation_confirmation_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/reservation_dto.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_book_reservation_service.dart';

class BookReservationService implements IBookReservationService
{
  final Dio dio;

  BookReservationService({required this.dio});

  @override
  Future<BookCopyAvailabilityDTO> getBookCopyAvailability(int bookRecordID) async
  {
    final response = await dio.get('/BookReservation/$bookRecordID/CopyAvailability');

    return BookCopyAvailabilityDTO.fromJson(response.data);
  }

  @override
  Future<ReservationConfirmationDTO> confirmReservation(ReservationDto reservation) async
  {
    final response = await dio.post(
      '/BookReservation',
      data: {
        'libraryCardRecordID': reservation.libraryCardRecordID,
        'bookCopyRecordID': reservation.bookCopyRecordID,
      },
    );

    return ReservationConfirmationDTO.fromJson(response.data);
  }
}