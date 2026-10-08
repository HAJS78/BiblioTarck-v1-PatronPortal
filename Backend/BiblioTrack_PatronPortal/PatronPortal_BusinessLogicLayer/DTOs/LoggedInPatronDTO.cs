

namespace PatronPortal_BusinessLogicLayer.DTOs
{
    public class LoggedInPatronDTO
    {
        public int MemberRecordID { get; set; }
        public int PersonRecordID { get; set; }
        public string UserName { get; set; } 
        public string? PhotoUrl { get; set; }
    }
}
