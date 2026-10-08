using Microsoft.AspNetCore.Mvc;
using BiblioTrack_PatronPortal.APIResponseWrapper;
using BiblioTrack_PatronPortal.Requests;
using PatronPortal_BusinessLogicLayer.DTOs;
using PatronPortal_BusinessLogicLayer.Interfaces;

namespace BiblioTrack_PatronPortal.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class PatronRegisterationController : BaseController
    {
        private readonly IPatronRegisteration _patronRegisteration;

        public PatronRegisterationController(IPatronRegisteration patronRegisteration)
        {
            _patronRegisteration = patronRegisteration;
        }

        [ProducesResponseType(typeof(ApiResponse<Dictionary<string, bool>>), StatusCodes.Status200OK)]
        [ProducesResponseType(typeof(ApiResponse<string>), StatusCodes.Status400BadRequest)]
        [ProducesResponseType(typeof(ApiResponse<string>), StatusCodes.Status500InternalServerError)]
        [HttpPost("UserNameAvailability")]
        public async Task<IActionResult> IsUserNameTaken([FromBody] UserNameAvailabilityRequest request)
        {
            if (string.IsNullOrEmpty(request.UserName))
                return BadRequest(ApiResponse<string>.Fail("Username is required."));

            try
            {
                Dictionary<string,bool> result = await _patronRegisteration.IsUserNameTaken(request.UserName);

                return Ok(ApiResponse<Dictionary<string, bool>>.Ok(result));
            }
            catch (Exception ex)
            {
                return HandleException(ex);
            }
        }

        [ProducesResponseType(typeof(ApiResponse<Dictionary<string, int>>), StatusCodes.Status200OK)]
        [ProducesResponseType(typeof(ApiResponse<string>), StatusCodes.Status400BadRequest)]
        [ProducesResponseType(typeof(ApiResponse<string>), StatusCodes.Status500InternalServerError)]
        [HttpPost("LibraryCard")]
        public async Task<IActionResult> FindPatronByLibraryCardNumber([FromBody] LibraryCardRequest request)
        {
            if (string.IsNullOrEmpty( request.LibraryCardNumber))

                return BadRequest(ApiResponse<string>.Fail("Library card number is required."));

            try
            {
                Dictionary<string,int> result =
                    await _patronRegisteration.FindPatronByLibraryCardNumber(request.LibraryCardNumber);

                if (result["memberRecordID"] == -1)

                    return Ok(ApiResponse<string>.Fail("No patron record associated with this card was found"));
                
                return Ok(ApiResponse< Dictionary<string,int>>.Ok(result));
            }
            catch (Exception ex)
            {
                return HandleException(ex);
            }
        }

        [ProducesResponseType(typeof(ApiResponse<SignUpResponseDTO>), StatusCodes.Status200OK)]
        [ProducesResponseType(typeof(ApiResponse<string>), StatusCodes.Status400BadRequest)]
        [ProducesResponseType(typeof(ApiResponse<string>), StatusCodes.Status500InternalServerError)]
        [HttpPut("Account")]
        public async Task<IActionResult> UpdatePatronAccount([FromBody] UpdateAccountRequest request)
        {
            if (string.IsNullOrEmpty(request.UserName) || string.IsNullOrEmpty(request.Password))
                return BadRequest(ApiResponse<string>.Fail("Username and password are required."));

            try
            {
                var (isSignedUp, errorMessage) =
                    await _patronRegisteration.UpdatePatronAccount(request.UserName, request.Password, request.MemberRecordID);

                if (!isSignedUp)
                    return Ok(ApiResponse<string>.Fail(errorMessage ?? "Unable to complete sign up."));

                return Ok(ApiResponse<SignUpResponseDTO>.Ok(new SignUpResponseDTO { IsSignedUp = true }));
            }
            catch (Exception ex)
            {
                return HandleException(ex);
            }
        }
    }
}