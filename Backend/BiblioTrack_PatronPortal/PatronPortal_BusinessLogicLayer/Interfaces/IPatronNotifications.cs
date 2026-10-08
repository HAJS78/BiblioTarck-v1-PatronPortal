using PatronPortal_BusinessLogicLayer.DTOs;

namespace PatronPortal_BusinessLogicLayer.Interfaces
{
    public interface IPatronNotifications
    {
        Task<Dictionary<string, List<MemberNotificationMessageDTO>>> LoadNotifications(int memberRecordID);
        Task<Dictionary<string,bool>> UpdateNotificationRecord(int notificationId);
    }
}
