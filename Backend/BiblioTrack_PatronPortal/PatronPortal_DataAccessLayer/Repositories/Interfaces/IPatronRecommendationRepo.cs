using PatronPortal_DataAccessLayer.Repository.Projections;

namespace PatronPortal_DataAccessLayer.Repositories.Interfaces
{
    public interface IPatronRecommendationRepo
    {
        Task<List<BookCardProjection>> GetRecommendedBooks(int memberRecordID);
    }
}
