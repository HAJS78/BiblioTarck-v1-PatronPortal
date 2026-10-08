using PatronPortal_BusinessLogicLayer.DTOs;
using PatronPortal_DataAccessLayer.Repositories.Projections;

namespace PatronPortal_BusinessLogicLayer.Mappers
{
    public static class LoggedInPatronMapper
    {
        public static LoggedInPatronDTO FromProjection(LoggedInPatronProjection projection)
        {
            return new LoggedInPatronDTO
            {
                MemberRecordID = projection.MemberRecordId,
                PersonRecordID = projection.PersonRecordId,
                UserName = projection.UserName,
                PhotoUrl = projection.PhotoUrl
            };
        }
    }
}
