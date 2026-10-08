using PatronPortal_BusinessLogicLayer.DTOs;

namespace PatronPortal_BusinessLogicLayer.Interfaces
{
    public interface IPatronFavorites
    {
        Task<Dictionary<string, int>> AddFavorite(int memberRecordID, int bookRecordID);
        Task<Dictionary<string, bool>> DeleteFavorite(int favoriteRecordID);
        Task<Dictionary<string, List<BookCardDTO>>> GetFavorites(int memberRecordID);
    }
}
