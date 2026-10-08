namespace BiblioTrack_PatronPortal.Requests
{
    public class ConfirmReservationRequest
    {
        public int LibraryCardRecordID { get; set; }
        public int BookCopyRecordID { get; set; }
    }
}
