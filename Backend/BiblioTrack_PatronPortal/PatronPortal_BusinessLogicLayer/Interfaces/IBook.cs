using PatronPortal_BusinessLogicLayer.DTOs;
using PatronPortal_DataAccessLayer.Repository.Projections;

namespace PatronPortal_BusinessLogicLayer.Interfaces
{
    public interface IBook
    {
        Task<BookDetailsDTO?> GetBookDetails(int bookRecordID, int memberRecordID);
        Task<Dictionary<string, List<BookCardDTO>>> SearchCatalog(int MemberRecordID, string SearchKeyword, string Searchfilter);


    }
}