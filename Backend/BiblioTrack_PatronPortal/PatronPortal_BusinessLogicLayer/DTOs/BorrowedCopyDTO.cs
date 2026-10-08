namespace PatronPortal_BusinessLogicLayer.DTOs
{
    public class BorrowedCopyDTO
    {
        public int BookCopyRecordID { get; set; }
        public string BarcodeNumber { get; set; } = null!;
        public DateOnly ExpectedReturnDate { get; set; }
    }
}
