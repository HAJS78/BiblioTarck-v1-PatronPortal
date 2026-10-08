using Microsoft.AspNetCore.Mvc;
using BiblioTrack_PatronPortal.APIResponseWrapper;


namespace BiblioTrack_PatronPortal.Controllers
{
    //All  controllers will inherit from this — it gives them shared behavior:
   
    [ApiController]
    public class BaseController : ControllerBase
    {
        protected IActionResult HandleException(Exception ex)
        {
          
            return StatusCode(500, ApiResponse<string>.Fail(
                $"Internal server error: {ex.Message}"));
        }
    }
}
