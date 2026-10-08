using Microsoft.AspNetCore.Mvc;
using BiblioTrack_PatronPortal.APIResponseWrapper;
using PatronPortal_BusinessLogicLayer.DTOs;
using PatronPortal_BusinessLogicLayer.Interfaces;

namespace BiblioTrack_PatronPortal.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class PatronNotificationsController : BaseController
    {
        private readonly IPatronNotifications _patronNotifications;

        public PatronNotificationsController(IPatronNotifications patronNotifications)
        {
            _patronNotifications = patronNotifications;
        }

        [ProducesResponseType(typeof(ApiResponse<Dictionary<string, List<MemberNotificationMessageDTO>>>), StatusCodes.Status200OK)]
        [ProducesResponseType(typeof(ApiResponse<string>), StatusCodes.Status400BadRequest)]
        [ProducesResponseType(typeof(ApiResponse<string>), StatusCodes.Status500InternalServerError)]
        [HttpGet("{memberRecordID}")]
        public async Task<IActionResult> LoadNotifications(int memberRecordID)
        {
            if (memberRecordID <= 0)
                return BadRequest(ApiResponse<string>.Fail("A valid memberRecordID is required."));

            try
            {
                var result = await _patronNotifications.LoadNotifications(memberRecordID);

                return Ok(ApiResponse<Dictionary<string, List<MemberNotificationMessageDTO>>>.Ok(result));
            }
            catch (Exception ex)
            {
                return HandleException(ex);
            }
        }

        [ProducesResponseType(typeof(ApiResponse<Dictionary<string, bool>>), StatusCodes.Status200OK)]
        [ProducesResponseType(typeof(ApiResponse<string>), StatusCodes.Status400BadRequest)]
        [ProducesResponseType(typeof(ApiResponse<string>), StatusCodes.Status500InternalServerError)]
        [HttpPut("{notificationId}")]
        public async Task<IActionResult> UpdateNotificationRecord(int notificationId)
        {
            if (notificationId <= 0)
                return BadRequest(ApiResponse<string>.Fail("A valid notificationId is required."));

            try
            {
                var result = await _patronNotifications.UpdateNotificationRecord(notificationId);

                if (!result["isUpdated"])
                    return Ok(ApiResponse<string>.Fail("Unable to update notification."));

                return Ok(ApiResponse<Dictionary<string, bool>>.Ok(result));
            }
            catch (Exception ex)
            {
                return HandleException(ex);
            }
        }
    }
}
