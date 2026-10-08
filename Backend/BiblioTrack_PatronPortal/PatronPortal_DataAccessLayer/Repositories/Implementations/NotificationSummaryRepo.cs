using Microsoft.EntityFrameworkCore;
using PatronPortal_DataAccessLayer.Context;
using PatronPortal_DataAccessLayer.Repositories.Interfaces;

using System.Diagnostics.Metrics;

namespace PatronPortal_DataAccessLayer.Repositories.Implementations
{
    public class NotificationSummaryRepo : INotificationSummaryRepo
    {
        private readonly BiblioTrackv1Context _context;

        public NotificationSummaryRepo(BiblioTrackv1Context context)
        {
            _context = context;
        }

        public async Task<(int overdueCount, int reservedCount)> GetNotificationSummary(int memberRecordID)
        {
            var query = _context.LibraryMemberNotifications.Where(n => n.IsRead == false && n.LibraryMemberRecordId == memberRecordID)
                        .GroupBy(n => n.NotificationType).Select(grp => new {NotificationType = grp.Key,NumberOfNotifications=grp.Count()});
                

            var  notifications=await query.ToListAsync();


            int overdueCount = notifications.FirstOrDefault(c => c.NotificationType == "OverdueItems")?.NumberOfNotifications??0 ;
            int reservedCount = notifications.FirstOrDefault(c => c.NotificationType == "ReservedItems")?.NumberOfNotifications??0 ;


            
            return (overdueCount, reservedCount);
        }
    }
}