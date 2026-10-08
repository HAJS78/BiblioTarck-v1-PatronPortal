using PatronPortal_BusinessLogicLayer.DTOs;
using PatronPortal_DataAccessLayer.Repositories.Interfaces;

public class NotificationSummary : INotificationSummary
{
    private readonly INotificationSummaryRepo _repo;

    public NotificationSummary(INotificationSummaryRepo repo)
    {
        _repo = repo;
    }

    public async Task<NotificationSummaryDTO> GetNotificationSummary(int memberRecordID)
    {
        var (overdueCount, reservedCount) = await _repo.GetNotificationSummary(memberRecordID);

        return new NotificationSummaryDTO
        {
            OverdueItemsCount = overdueCount,
            ReservedItemsCount = reservedCount
        };
    }
}