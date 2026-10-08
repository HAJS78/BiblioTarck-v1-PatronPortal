

namespace BiblioTrack_PatronPortal.Requests
{
    public  class UpdatePasswordRequest
    {
        public int MemberRecordID { get; set; }
        public string NewPassword { get; set; }
        
    }
}
