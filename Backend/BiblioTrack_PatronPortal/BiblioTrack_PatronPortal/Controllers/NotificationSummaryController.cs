using Microsoft.AspNetCore.Mvc;
using BiblioTrack_PatronPortal.APIResponseWrapper;
using PatronPortal_BusinessLogicLayer.DTOs;
using PatronPortal_BusinessLogicLayer.Interfaces;

namespace BiblioTrack_PatronPortal.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class NotificationSummaryController : BaseController
    {
        private readonly INotificationSummary _notificationSummary;

        public NotificationSummaryController(INotificationSummary notificationSummary)
        {
            _notificationSummary = notificationSummary;
        }

        [ProducesResponseType(typeof(ApiResponse<NotificationSummaryDTO>), StatusCodes.Status200OK)]
        [ProducesResponseType(typeof(ApiResponse<string>), StatusCodes.Status400BadRequest)]
        [ProducesResponseType(typeof(ApiResponse<string>), StatusCodes.Status500InternalServerError)]
        [HttpGet("{memberRecordID}")]
        public async Task<IActionResult> GetNotificationSummary(int memberRecordID)
        {
            if (memberRecordID <= 0)
                return BadRequest(ApiResponse<string>.Fail("A valid memberRecordID is required."));

            try
            {
                NotificationSummaryDTO result = await _notificationSummary.GetNotificationSummary(memberRecordID);

                return Ok(ApiResponse<NotificationSummaryDTO>.Ok(result));
            }
            catch (Exception ex)
            {
                return HandleException(ex);
            }
        }
    }
}
