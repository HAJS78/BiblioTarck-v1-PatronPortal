using BiblioTrack_PatronPortal.APIResponseWrapper;
using Microsoft.AspNetCore.Mvc;
using PatronPortal_BusinessLogicLayer.DTOs;
using PatronPortal_BusinessLogicLayer.Interfaces;

namespace BiblioTrack_PatronPortal.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class FineController : BaseController
    {
        private readonly IFine _fine;

        public FineController(IFine fine)
        {
            _fine = fine;
        }


        [ProducesResponseType(typeof(ApiResponse<Dictionary<string, List<UnpaidFineDTO>>>), StatusCodes.Status200OK)]
        [ProducesResponseType(typeof(ApiResponse<string>), StatusCodes.Status400BadRequest)]
        [ProducesResponseType(typeof(ApiResponse<string>), StatusCodes.Status500InternalServerError)]
        [HttpGet("{memberRecordID}")]
        public async Task<IActionResult> LoadUnpaidFines(int memberRecordID)
        {
            if (memberRecordID <= 0)
                return BadRequest(ApiResponse<string>.Fail("A valid memberRecordID is required."));

            try
            {
                var result = await  _fine.GetUnpaidFines(memberRecordID);

                return Ok(ApiResponse<Dictionary<string, List<UnpaidFineDTO>>>.Ok(result));
            }
            catch (Exception ex)
            {
                return HandleException(ex);
            }
        }

    }
}