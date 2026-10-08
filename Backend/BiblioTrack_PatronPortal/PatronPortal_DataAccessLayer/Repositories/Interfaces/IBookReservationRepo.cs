using PatronPortal_DataAccessLayer.Repository.Projections;

namespace PatronPortal_DataAccessLayer.Repositories.Interfaces
{
    public interface IBookReservationRepo
    {
        Task<BookCopyAvailabilityProjection> GetBookCopyAvailability(int bookRecordID);
        Task<int> ConfirmReservation(int libraryCardRecordID, int bookCopyRecordID);
    }
}
