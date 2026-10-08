using Microsoft.AspNetCore.Mvc;
using BiblioTrack_PatronPortal.APIResponseWrapper;
using BiblioTrack_PatronPortal.Requests;
using PatronPortal_BusinessLogicLayer.DTOs;
using PatronPortal_BusinessLogicLayer.Interfaces;

namespace BiblioTrack_PatronPortal.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class BookReservationController : BaseController
    {
        private readonly IBookReservation _bookReservation;

        public BookReservationController(IBookReservation bookReservation)
        {
            _bookReservation = bookReservation;
        }

        [ProducesResponseType(typeof(ApiResponse<BookCopyAvailabilityDTO>), StatusCodes.Status200OK)]
        [ProducesResponseType(typeof(ApiResponse<string>), StatusCodes.Status400BadRequest)]
        [ProducesResponseType(typeof(ApiResponse<string>), StatusCodes.Status500InternalServerError)]
        [HttpGet("{bookRecordID}/CopyAvailability")]
        public async Task<IActionResult> GetBookCopyAvailability(int bookRecordID)
        {
            if (bookRecordID <= 0)
                return BadRequest(ApiResponse<string>.Fail("A valid bookRecordID is required."));

            try
            {
                BookCopyAvailabilityDTO result = await _bookReservation.GetBookCopyAvailability(bookRecordID);

                return Ok(ApiResponse<BookCopyAvailabilityDTO>.Ok(result));
            }
            catch (Exception ex)
            {
                return HandleException(ex);
            }
        }

        [ProducesResponseType(typeof(ApiResponse<Dictionary<string, int>>), StatusCodes.Status200OK)]
        [ProducesResponseType(typeof(ApiResponse<string>), StatusCodes.Status400BadRequest)]
        [ProducesResponseType(typeof(ApiResponse<string>), StatusCodes.Status500InternalServerError)]
        [HttpPost]
        public async Task<IActionResult> ConfirmReservation([FromBody] ConfirmReservationRequest request)
        {
            if (request.LibraryCardRecordID <= 0 || request.BookCopyRecordID <= 0)
                return BadRequest(ApiResponse<string>.Fail("A valid libraryCardRecordID and bookCopyRecordID are required."));

            try
            {
                var result = await _bookReservation.ConfirmReservation(request.LibraryCardRecordID, request.BookCopyRecordID);

                if (result["reservationID"] == -1)
                    return Ok(ApiResponse<string>.Fail("Unable to confirm reservation."));

                return Ok(ApiResponse<Dictionary<string, int>>.Ok(result));
            }
            catch (Exception ex)
            {
                return HandleException(ex);
            }
        }
    }
}
