namespace PatronPortal_BusinessLogicLayer.DTOs
{
    public class MemberNotificationMessageDTO
    {
        public int NotificationId { get; set; }
        public string Title { get; set; } = null!;
        public string Body { get; set; } = null!;
        public string Type { get; set; } = null!;
        public bool IsRead { get; set; }
    }
}