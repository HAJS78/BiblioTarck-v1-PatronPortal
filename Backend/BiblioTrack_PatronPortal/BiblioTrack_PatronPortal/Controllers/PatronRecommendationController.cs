using Microsoft.AspNetCore.Mvc;
using BiblioTrack_PatronPortal.APIResponseWrapper;
using PatronPortal_BusinessLogicLayer.DTOs;
using PatronPortal_BusinessLogicLayer.Interfaces;

namespace BiblioTrack_PatronPortal.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class PatronRecommendationController : BaseController
    {
        private readonly IPatronRecommendation _patronRecommendation;

        public PatronRecommendationController(IPatronRecommendation patronRecommendation)
        {
            _patronRecommendation = patronRecommendation;
        }

        [ProducesResponseType(typeof(ApiResponse<Dictionary<string, List<BookCardDTO>>>), StatusCodes.Status200OK)]
        [ProducesResponseType(typeof(ApiResponse<string>), StatusCodes.Status400BadRequest)]
        [ProducesResponseType(typeof(ApiResponse<string>), StatusCodes.Status500InternalServerError)]
        [HttpGet("{memberRecordID}")]
        public async Task<IActionResult> GetRecommendedBooks(int memberRecordID)
        {
            if (memberRecordID <= 0)
                return BadRequest(ApiResponse<string>.Fail("A valid memberRecordID is required."));

            try
            {
                var result = await _patronRecommendation.GetRecommendedBooks(memberRecordID);

                return Ok(ApiResponse<Dictionary<string, List<BookCardDTO>>>.Ok(result));
            }
            catch (Exception ex)
            {
                return HandleException(ex);
            }
        }
    }
}