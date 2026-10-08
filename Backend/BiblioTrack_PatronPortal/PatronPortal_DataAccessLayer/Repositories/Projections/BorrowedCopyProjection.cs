namespace PatronPortal_DataAccessLayer.Repository.Projections
{
    public class BorrowedCopyProjection
    {
        public int BookCopyRecordId { get; set; }
        public string BookCopyBarcodeNumber { get; set; } = null!;
        public DateOnly ExpectedReturnDate { get; set; }
    }
}