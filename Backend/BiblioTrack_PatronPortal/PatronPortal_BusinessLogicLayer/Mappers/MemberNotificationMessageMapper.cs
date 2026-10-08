using PatronPortal_BusinessLogicLayer.DTOs;
using PatronPortal_BusinessLogicLayer.Utilities;
using PatronPortal_DataAccessLayer.Repository.Projections;

namespace PatronPortal_BusinessLogicLayer.Mappers
{
    public static class MemberNotificationMessageMapper
    {
        public static MemberNotificationMessageDTO FromProjection(NotificationProjection projection)
        {
            return new MemberNotificationMessageDTO
            {
                NotificationId = projection.NotificationId,
                Title = NotificationTitleBuilder.BuildTitle(projection.NotificationType),
                Body = projection.Message,
                Type = projection.NotificationType,
                IsRead = projection.IsRead
            };
        }

        public static List<MemberNotificationMessageDTO> FromProjectionList(List<NotificationProjection> projections)
        {
            return projections.Select(FromProjection).ToList();
        }
    }
}
