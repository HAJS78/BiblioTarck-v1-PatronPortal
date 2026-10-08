using BiblioTrack_PatronPortal.APIResponseWrapper;
using BiblioTrack_PatronPortal.Requests;
using Microsoft.AspNetCore.Mvc;
using PatronPortal_BusinessLogicLayer.Interfaces;

namespace BiblioTrack_PatronPortal.Controllers
{
    [Route("api/[controller]")]
    public class PasswordRecoveryController : BaseController
    {

        private IPasswordRecovery _passwordRecovery;

        public PasswordRecoveryController(IPasswordRecovery passwordRecovery)
        {
            _passwordRecovery = passwordRecovery;
        }

        [ProducesResponseType(typeof(ApiResponse<Dictionary<string,int>>), StatusCodes.Status200OK)]
        [ProducesResponseType(typeof(ApiResponse<string>), StatusCodes.Status400BadRequest)]
        [ProducesResponseType(typeof(ApiResponse<string>), StatusCodes.Status500InternalServerError)]
        [HttpPost("Email")]
        public async Task<IActionResult> FindByEmail( [FromBody] PatronContactInfoRequest request)
        {

            if (string.IsNullOrEmpty(request.Email))
                return BadRequest(ApiResponse<string>.Fail("Email is required."));

            Dictionary<string,int> dic=new Dictionary<string,int>();
           
            try
            {
               dic= await _passwordRecovery.FindPatronByEmail(request.Email);

                
                if (dic["memberRecordID"] == -1)
                    return Ok(ApiResponse<Dictionary<string,int>>.Fail("No patron record associated with this email was found"));

               
                return Ok(ApiResponse<Dictionary<string, int>>.Ok(dic));
            }
            catch (Exception ex)
            {
                return HandleException(ex);
            }
        }




        [ProducesResponseType(typeof(ApiResponse<bool>), StatusCodes.Status200OK)]
        [ProducesResponseType(typeof(ApiResponse<string>), StatusCodes.Status400BadRequest)]
        [ProducesResponseType(typeof(ApiResponse<string>), StatusCodes.Status500InternalServerError)]
        [HttpPut("Password")]
        public async Task<IActionResult> UpdatePassword([FromBody] UpdatePasswordRequest request)
        {

            if (string.IsNullOrEmpty(request.NewPassword))
                return BadRequest(ApiResponse<string>.Fail(" New password is required."));



            try
            {
                bool result =
                     await _passwordRecovery.UpdatePassword(request.MemberRecordID, request.NewPassword);

                
                if (!result)
                    return Ok(ApiResponse<bool>.Fail("Unable to update password"));

               
                return Ok(ApiResponse<bool>.Ok(result));
            
            }
            
            catch (Exception ex)
            {
                return HandleException(ex);
            }
        }

    }
}
