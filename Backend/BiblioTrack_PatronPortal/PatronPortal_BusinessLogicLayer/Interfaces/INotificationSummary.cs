using PatronPortal_BusinessLogicLayer.DTOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

public interface INotificationSummary
{
    Task<NotificationSummaryDTO> GetNotificationSummary(int memberRecordID);
}
