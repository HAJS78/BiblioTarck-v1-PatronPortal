using BiblioTrack_PatronPortal.APIResponseWrapper;
using BiblioTrack_PatronPortal.Controllers;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using PatronPortal_BusinessLogicLayer.DTOs;
using PatronPortal_BusinessLogicLayer.Interfaces;

namespace BiblioTrack_PatronPortal.Controllers
{

[ApiController]
[Route("api/[controller]")]
public class LibraryCardController : BaseController
{
    private readonly ILibraryCard _card;

    public LibraryCardController(ILibraryCard card)
    {
       _card = card;
    }

    [ProducesResponseType(typeof(ApiResponse<Dictionary<string, int?>>), StatusCodes.Status200OK)]
    [ProducesResponseType(typeof(ApiResponse<string>), StatusCodes.Status400BadRequest)]
    [ProducesResponseType(typeof(ApiResponse<string>), StatusCodes.Status500InternalServerError)]
    [HttpGet("{LibraryCardNumbr}")]
    public async Task<IActionResult> GetBookDetails(string LibraryCardNumbr)
    {
        if (LibraryCardNumbr.IsNullOrEmpty() || LibraryCardNumbr.Length<12)
            return BadRequest(ApiResponse<string>.Fail("A valid library card numbr is required."));

        try
        {
                var result = await _card.FindLibraryCard(LibraryCardNumbr);

            if (result["libraryCardRecordID"] == null)
                return Ok(ApiResponse<string>.Fail("Library card record was not found."));

            return Ok(ApiResponse<Dictionary<string, int?>>.Ok(result));
        }
        catch (Exception ex)
        {
            return HandleException(ex);
        }
    }
 }



}



