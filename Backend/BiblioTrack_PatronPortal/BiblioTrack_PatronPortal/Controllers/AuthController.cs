using Microsoft.AspNetCore.Mvc;
using BiblioTrack_PatronPortal.APIResponseWrapper;
using BiblioTrack_PatronPortal.Requests;
using PatronPortal_BusinessLogicLayer.DTOs;
using PatronPortal_BusinessLogicLayer.Interfaces;

namespace BiblioTrack_PatronPortal.Controllers
{
    
    [Route("api/[controller]")]
    public class AuthController : BaseController
    {
        private readonly IAuth _auth;

        public AuthController(IAuth auth)
        {
            _auth = auth;
        }

        [ProducesResponseType(typeof(ApiResponse<LoggedInPatronDTO>), StatusCodes.Status200OK)]
        [ProducesResponseType(typeof(ApiResponse<string>), StatusCodes.Status400BadRequest)]
        [ProducesResponseType(typeof(ApiResponse<string>), StatusCodes.Status500InternalServerError)]
        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] LoginRequest request)
        {
            
            if (string.IsNullOrEmpty(request.Username) || string.IsNullOrEmpty(request.Password))
                return BadRequest(ApiResponse<string>.Fail("Username and password are required."));

            try
            {
                LoggedInPatronDTO? result =
                    await _auth.FindPatronByUsernameAndPasswordAsync(request.Username, request.Password);

                // 200 + success:false — expected business outcome, not a client/server error
                if (result == null)
                    return Ok(ApiResponse<LoggedInPatronDTO>.Fail("Invalid username or password."));

                // 200 + success:true
                return Ok(ApiResponse<LoggedInPatronDTO>.Ok(result));
            }
            catch (Exception ex)
            {
                return HandleException(ex);
            }
        }
    }
}