

namespace PatronPortal_DataAccessLayer.Repositories.Projections
{
    public class LoggedInPatronProjection
    {
        public int MemberRecordId { get; set; }
        public int PersonRecordId { get; set; }
        public string UserName { get; set; } = null!;
        public string? PhotoUrl { get; set; }
    }
}
