using Microsoft.AspNetCore.Mvc;
using BiblioTrack_PatronPortal.APIResponseWrapper;
using BiblioTrack_PatronPortal.Requests;
using PatronPortal_BusinessLogicLayer.DTOs;
using PatronPortal_BusinessLogicLayer.Interfaces;

namespace BiblioTrack_PatronPortal.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class PatronFavoritesController : BaseController
    {
        private readonly IPatronFavorites _patronFavorites;

        public PatronFavoritesController(IPatronFavorites patronFavorites)
        {
            _patronFavorites = patronFavorites;
        }

        [ProducesResponseType(typeof(ApiResponse<Dictionary<string, int>>), StatusCodes.Status200OK)]
        [ProducesResponseType(typeof(ApiResponse<string>), StatusCodes.Status400BadRequest)]
        [ProducesResponseType(typeof(ApiResponse<string>), StatusCodes.Status500InternalServerError)]
        [HttpPost]
        public async Task<IActionResult> AddFavorite([FromBody] AddFavoriteRequest request)
        {
            if (request.memberRecordID <= 0 || request.bookRecordID <= 0)
                return BadRequest(ApiResponse<string>.Fail("A valid memberRecordID and bookRecordID are required."));

            try
            {
                Dictionary<string, int> result = await _patronFavorites.AddFavorite(request.memberRecordID, request.bookRecordID);

                if (result["favoriteRecordID"] == -1)
                    return Ok(ApiResponse<string>.Fail("Unable to add this book to favorites."));

                return Ok(ApiResponse<Dictionary<string, int>>.Ok(result));
            }
            catch (Exception ex)
            {
                return HandleException(ex);
            }
        }

        [ProducesResponseType(typeof(ApiResponse<Dictionary<string, bool>>), StatusCodes.Status200OK)]
        [ProducesResponseType(typeof(ApiResponse<string>), StatusCodes.Status400BadRequest)]
        [ProducesResponseType(typeof(ApiResponse<string>), StatusCodes.Status500InternalServerError)]
        [HttpDelete("{favoriteRecordID}")]
        public async Task<IActionResult> DeleteFavorite(int favoriteRecordID)
        {
            if (favoriteRecordID <= 0)
                return BadRequest(ApiResponse<string>.Fail("A valid favoriteRecordID is required."));

            try
            {
                Dictionary<string, bool> result = await _patronFavorites.DeleteFavorite(favoriteRecordID);

                if (!result["isDeleted"])
                    return Ok(ApiResponse<string>.Fail("Unable to remove this book from favorites."));

                return Ok(ApiResponse<Dictionary<string, bool>>.Ok(result));
            }
            catch (Exception ex)
            {
                return HandleException(ex);
            }
        }

        [ProducesResponseType(typeof(ApiResponse<Dictionary<string, List<BookCardDTO>>>), StatusCodes.Status200OK)]
        [ProducesResponseType(typeof(ApiResponse<string>), StatusCodes.Status400BadRequest)]
        [ProducesResponseType(typeof(ApiResponse<string>), StatusCodes.Status500InternalServerError)]
        [HttpGet("{memberRecordID}")]
        public async Task<IActionResult> GetFavorites(int memberRecordID)
        {
            if (memberRecordID <= 0)
                return BadRequest(ApiResponse<string>.Fail("A valid memberRecordID is required."));

            try
            {
                Dictionary<string, List<BookCardDTO>> result = await _patronFavorites.GetFavorites(memberRecordID);

                return Ok(ApiResponse<Dictionary<string, List<BookCardDTO>>>.Ok(result));
            }
            catch (Exception ex)
            {
                return HandleException(ex);
            }
        }
    }
}