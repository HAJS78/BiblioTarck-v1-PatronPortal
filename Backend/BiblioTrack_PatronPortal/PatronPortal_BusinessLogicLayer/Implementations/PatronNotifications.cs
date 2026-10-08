using PatronPortal_BusinessLogicLayer.DTOs;
using PatronPortal_BusinessLogicLayer.Interfaces;
using PatronPortal_BusinessLogicLayer.Mappers;
using PatronPortal_DataAccessLayer.Repositories.Interfaces;

namespace PatronPortal_BusinessLogicLayer.Implementations
{
    public class PatronNotifications : IPatronNotifications
    {
        private readonly IPatronNotificationsRepo _repo;

        public PatronNotifications(IPatronNotificationsRepo repo)
        {
            _repo = repo;
        }

        public async Task<Dictionary<string, List<MemberNotificationMessageDTO>>> LoadNotifications(int memberRecordID)
        {
            var projections = await _repo.LoadNotifications(memberRecordID);
            var notifications = MemberNotificationMessageMapper.FromProjectionList(projections);

            return new Dictionary<string, List<MemberNotificationMessageDTO>> { ["notifications"] = notifications };
        }

        public async Task<Dictionary<string,bool>> UpdateNotificationRecord(int notificationId)
        {
            bool isUpdated = await _repo.UpdateNotificationRecord(notificationId);

            return new Dictionary<string, bool> { ["isUpdated"] = isUpdated };
        }
    }
}