using PatronPortal_DataAccessLayer.Repository.Projections;

namespace PatronPortal_DataAccessLayer.Repositories.Interfaces
{
    public interface IPatronFavoritesRepo
    {
        Task<int> AddFavorite(int memberRecordID, int bookRecordID);
        Task<bool> DeleteFavorite(int favoriteRecordID);
        Task<List<BookCardProjection>> GetFavorites(int memberRecordID);
    }
}