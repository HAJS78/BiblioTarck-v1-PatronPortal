using Microsoft.EntityFrameworkCore;
using PatronPortal_DataAccessLayer.Context;
using PatronPortal_DataAccessLayer.Repositories.Interfaces;

using PatronPortal_DataAccessLayer.Repository.Projections;

namespace PatronPortal_DataAccessLayer.Repositories.Implementations
{
    public class PatronNotificationsRepo : IPatronNotificationsRepo
    {
        private readonly BiblioTrackv1Context _context;

        public PatronNotificationsRepo(BiblioTrackv1Context context)
        {
            _context = context;
        }

        public async Task<List<NotificationProjection>> LoadNotifications(int memberRecordID)
        {
            var query = _context.LibraryMemberNotifications
                .Where(n => n.LibraryMemberRecordId == memberRecordID && n.IsRead==false)
                .Select(n => new NotificationProjection
                {
                    NotificationId = n.NotificationId,
                    Message = n.Message,
                    NotificationType = n.NotificationType,
                    IsRead = n.IsRead
                });

            var notifications = await query.ToListAsync();

            return notifications;
        }

        public async Task<bool> UpdateNotificationRecord(int notificationId)
        {
            var notification = await _context.LibraryMemberNotifications.FindAsync(notificationId);

            if (notification == null)
            {
                return false;
            }

            notification.IsRead = true;

            try
            {
                await _context.SaveChangesAsync();
                return true;
            }
            catch
            {
                return false;
            }
        }
    }
}
