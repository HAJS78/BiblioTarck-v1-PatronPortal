using PatronPortal_DataAccessLayer.Repository.Projections;

namespace PatronPortal_DataAccessLayer.Repositories.Interfaces
{
    public interface IBookRepo
    {
        Task<BookDetailsProjection?> GetBookDetails(int bookRecordID, int memberRecordID);
        Task<List<BookCardProjection>> SearchCatalog(int MemberRecordID, string SearchKeyword, string Searchfilter);
    }
}