namespace PatronPortal_DataAccessLayer.Repositories.Interfaces
{
    public interface INotificationSummaryRepo
    {
        Task<(int overdueCount, int reservedCount)> GetNotificationSummary(int memberRecordID);
    }
}
