namespace BiblioTrack_PatronPortal.Requests
{
    public class AddFavoriteRequest
    {
        public int memberRecordID { get; set; }
        public int bookRecordID { get; set; }
    }
}