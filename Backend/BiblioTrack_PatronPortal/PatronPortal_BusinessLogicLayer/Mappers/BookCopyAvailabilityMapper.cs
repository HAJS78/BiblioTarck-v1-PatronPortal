using PatronPortal_BusinessLogicLayer.DTOs;
using PatronPortal_DataAccessLayer.Repository.Projections;

namespace PatronPortal_BusinessLogicLayer.Mappers
{
    public static class BookCopyAvailabilityMapper
    {
        public static BookCopyAvailabilityDTO FromProjection(BookCopyAvailabilityProjection projection)
        {
            return new BookCopyAvailabilityDTO
            {
                AvailableBookCopyID = projection.AvailableBookCopyId,
                BorrowedCopies = projection.BorrowedCopies.Select(c => new BorrowedCopyDTO
                {
                    BookCopyRecordID = c.BookCopyRecordId,
                    BarcodeNumber = c.BookCopyBarcodeNumber,
                    ExpectedReturnDate = c.ExpectedReturnDate
                }).ToList()
            };
        }
    }
}
