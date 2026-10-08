using PatronPortal_BusinessLogicLayer.DTOs;
using PatronPortal_BusinessLogicLayer.Interfaces;
using PatronPortal_BusinessLogicLayer.Mappers;
using PatronPortal_DataAccessLayer.Repositories.Interfaces;

namespace PatronPortal_BusinessLogicLayer.Implementations
{
    public class Book : IBook
    {
        private readonly IBookRepo _repo;

        public Book(IBookRepo repo)
        {
            _repo = repo;
        }

        public async Task<BookDetailsDTO?> GetBookDetails(int bookRecordID, int memberRecordID)
        {
            var projection = await _repo.GetBookDetails(bookRecordID, memberRecordID);

            if (projection == null)
            {
                return null;
            }

            return BookDetailsMapper.FromProjection(projection);
        }


        public async Task<Dictionary<string, List<BookCardDTO>>> SearchCatalog(int MemberRecordID, string SearchKeyword, string Searchfilter) 
        {


            var projections = await _repo.SearchCatalog(MemberRecordID, SearchKeyword, Searchfilter);
            var books = BookCardMapper.FromProjectionList(projections);

            return new Dictionary<string, List<BookCardDTO>> {["searchResults"] = books };


        }




    }
}