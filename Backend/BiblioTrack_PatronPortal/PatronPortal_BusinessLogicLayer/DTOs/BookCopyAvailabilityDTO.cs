namespace PatronPortal_BusinessLogicLayer.DTOs
{
    public class BookCopyAvailabilityDTO
    {
        public int? AvailableBookCopyID { get; set; }
        public List<BorrowedCopyDTO> BorrowedCopies { get; set; } = new();
    }
}
