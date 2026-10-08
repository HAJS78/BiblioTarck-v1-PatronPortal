using PatronPortal_BusinessLogicLayer.DTOs;
using PatronPortal_BusinessLogicLayer.Interfaces;
using PatronPortal_BusinessLogicLayer.Mappers;
using PatronPortal_DataAccessLayer.Repositories.Interfaces;

namespace PatronPortal_BusinessLogicLayer.Implementations
{
    public class BookReservation : IBookReservation
    {
        private readonly IBookReservationRepo _repo;

        public BookReservation(IBookReservationRepo repo)
        {
            _repo = repo;
        }

        public async Task<BookCopyAvailabilityDTO> GetBookCopyAvailability(int bookRecordID)
        {
            var projection = await _repo.GetBookCopyAvailability(bookRecordID);

            return BookCopyAvailabilityMapper.FromProjection(projection);
        }

        public async Task<Dictionary<string, int>> ConfirmReservation(int libraryCardRecordID, int bookCopyRecordID)
        {
            int reservationId = await _repo.ConfirmReservation(libraryCardRecordID, bookCopyRecordID);

            return new Dictionary<string, int> { ["reservationID"] = reservationId };
        }
    }
}