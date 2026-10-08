using PatronPortal_BusinessLogicLayer.DTOs;

namespace PatronPortal_BusinessLogicLayer.Interfaces
{
    public interface IBookReservation
    {
        Task<BookCopyAvailabilityDTO> GetBookCopyAvailability(int bookRecordID);
        Task<Dictionary<string, int>> ConfirmReservation(int libraryCardRecordID, int bookCopyRecordID);
    }
}
