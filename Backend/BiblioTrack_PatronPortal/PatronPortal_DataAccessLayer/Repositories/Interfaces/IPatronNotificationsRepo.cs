using PatronPortal_DataAccessLayer.Repositories.Projections;
using PatronPortal_DataAccessLayer.Repository.Projections;


namespace PatronPortal_DataAccessLayer.Repositories.Interfaces
{
    public interface IPatronNotificationsRepo
    {
        Task<List<NotificationProjection>> LoadNotifications(int memberRecordID);
        Task<bool> UpdateNotificationRecord(int notificationId);
    }
}