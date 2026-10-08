namespace PatronPortal_DataAccessLayer.Repository.Projections
{
    public class BookCopyAvailabilityProjection
    {
        public int? AvailableBookCopyId { get; set; }
        public List<BorrowedCopyProjection> BorrowedCopies { get; set; } = new();
    }
}
