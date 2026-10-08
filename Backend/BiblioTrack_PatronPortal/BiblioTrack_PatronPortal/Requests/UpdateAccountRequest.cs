namespace BiblioTrack_PatronPortal.Requests
{
    public class UpdateAccountRequest
    {
        public string UserName { get; set; } = null!;
        public string Password { get; set; } = null!;
        public int MemberRecordID { get; set; }
    }
}