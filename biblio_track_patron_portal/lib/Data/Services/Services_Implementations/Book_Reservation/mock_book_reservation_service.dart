import 'package:biblio_track_patron_portal/Data/Models/DTOs/book_copy_availability_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/reservation_confirmation_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/reservation_dto.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_book_reservation_service.dart';

class MockBookReservationService implements IBookReservationService
{

@override
Future<BookCopyAvailabilityDTO> getBookCopyAvailability(int bookRecordID) async
{
  await Future.delayed(const Duration(seconds: 2));

  
  Map<String, dynamic> successResponse;
  //Map<String, dynamic> failedResponse;

  if (bookRecordID == 2)      // if here just to test if the book
                              //has a available bookcopies to reserve
                              // we have to reserve from already lent bookcopies  
  {
    successResponse =
    {
      "data":
      {
        "availableBookCopyID": null,
        "borrowedCopies":
        [
          {
            "bookCopyRecordID": 12,
            "barcodeNumber": "3e97fa14e850",
            "expectedReturnDate": "2026-08-10",
          },
          {
            "bookCopyRecordID": 13,
            "barcodeNumber": "9a41cb02f317",
            "expectedReturnDate": "2026-08-20",
          },
        ],
      },
      "error": null,
      "success": true,
    };
  }
  else
  {
    successResponse =
    {
      "data":
      {
        "availableBookCopyID": 21,
        "borrowedCopies": [],
      },
      "error": null,
      "success": true,
    };
  }

  //  failedResponse =
  //   {
  //     "data":null,
     
  //     "error": "Error processing the request",
  //     "success": true,
  //   };
  
  

  return BookCopyAvailabilityDTO.fromJson(successResponse);  //simulate success
  //return BookCopyAvailabilityDTO.fromJson(failedResponse);  //simulate failure

}

// Simulates the raw JSON body the real POST /api/reservations
  // endpoint would return.
  Map<String, dynamic> reservationConfirmationsuccessResponse =
  {
    "data":
    {
      "reservationID": 101,
      
    },
    "error": null,
    "success": true,
  };

  //  Map<String, dynamic> reservationConfirmationfailedResponse =
  // {
  //   "data":null,
    
  //   "error": "Reservation record was not created",
  //   "success": true,
  // };

@override
Future<ReservationConfirmationDTO> confirmReservation(ReservationDto reservation) async
{
   await Future.delayed(const Duration(seconds: 2));

  
  
  //ReservationConfirmationDTO dto = ReservationDto.fromJson(reservationConfirmationfailedResponse); //simulate failure 
  ReservationConfirmationDTO dto = ReservationConfirmationDTO.fromJson(reservationConfirmationsuccessResponse);//Simulate success
  return dto;
}



}