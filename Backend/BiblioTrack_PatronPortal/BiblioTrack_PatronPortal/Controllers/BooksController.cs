using Microsoft.AspNetCore.Mvc;
using BiblioTrack_PatronPortal.APIResponseWrapper;
using PatronPortal_BusinessLogicLayer.DTOs;
using PatronPortal_BusinessLogicLayer.Interfaces;

namespace BiblioTrack_PatronPortal.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class BooksController : BaseController
    {
        private readonly IBook _book;

        public BooksController(IBook book)
        {
            _book = book;
        }

        [ProducesResponseType(typeof(ApiResponse<BookDetailsDTO>), StatusCodes.Status200OK)]
        [ProducesResponseType(typeof(ApiResponse<string>), StatusCodes.Status400BadRequest)]
        [ProducesResponseType(typeof(ApiResponse<string>), StatusCodes.Status500InternalServerError)]
        [HttpGet("{bookRecordID}")]
        public async Task<IActionResult> GetBookDetails(int bookRecordID, [FromQuery] int memberRecordID)
        {
            if (bookRecordID <= 0 || memberRecordID <= 0)
                return BadRequest(ApiResponse<string>.Fail("A valid bookRecordID and memberRecordID are required."));

            try
            {
                BookDetailsDTO? result = await _book.GetBookDetails(bookRecordID, memberRecordID);

                if (result == null)
                    return Ok(ApiResponse<string>.Fail("Book was not found."));

                return Ok(ApiResponse<BookDetailsDTO>.Ok(result));
            }
            catch (Exception ex)
            {
                return HandleException(ex);
            }
        }


        [ProducesResponseType(typeof(ApiResponse<Dictionary<string, List<BookCardDTO>>>), StatusCodes.Status200OK)]
        [ProducesResponseType(typeof(ApiResponse<string>), StatusCodes.Status400BadRequest)]
        [ProducesResponseType(typeof(ApiResponse<string>), StatusCodes.Status500InternalServerError)]
        [HttpGet("SearchCatalog")]
        public async Task<IActionResult> SearchCatalog([FromQuery] int MemberRecordID, [FromQuery] string SearchKeyword, [FromQuery] string SearchFilter)
        {
            if (MemberRecordID <= 0)
                return BadRequest(ApiResponse<string>.Fail("A valid memberRecordID is required."));

            try
            {
                var result = await _book.SearchCatalog(MemberRecordID, SearchKeyword, SearchFilter);

                return Ok(ApiResponse<Dictionary<string, List<BookCardDTO>>>.Ok(result));
            }
            catch (Exception ex)
            {
                return HandleException(ex);
            }
        }







    }
}




//The rule REST APIs generally follow: a value goes in the route when it identifies which resource you're addressing — it's part of "what thing am I asking about," the noun the URL names.
//A value goes in the query string when it's extra context/filtering/scoping on top of an already-identified resource —
//modifying or narrowing the request, not naming the resource itself.


//Gemini:RESTful Conventions: In REST APIs, path parameters ({id}) are strictly used to point to a specific, uniquely identifiable resource (e.g., /books/123).
//Query parameters (?key=value) are the industry standard for filtering, searching, and sorting.