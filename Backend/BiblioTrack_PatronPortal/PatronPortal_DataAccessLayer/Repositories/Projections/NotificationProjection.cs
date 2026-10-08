namespace PatronPortal_DataAccessLayer.Repository.Projections
{
    public class NotificationProjection
    {
        public int NotificationId { get; set; }
        public string Message { get; set; } = null!;
        public string NotificationType { get; set; } = null!;
        public bool IsRead { get; set; }
    }
}
