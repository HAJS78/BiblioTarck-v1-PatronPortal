using PatronPortal_BusinessLogicLayer.DTOs;
using PatronPortal_BusinessLogicLayer.Interfaces;
using PatronPortal_BusinessLogicLayer.Mappers;
using PatronPortal_DataAccessLayer.Repositories.Interfaces;

namespace PatronPortal_BusinessLogicLayer.Implementations
{
    public class PatronFavorites : IPatronFavorites
    {
        private readonly IPatronFavoritesRepo _repo;

        public PatronFavorites(IPatronFavoritesRepo repo)
        {
            _repo = repo;
        }

        public async Task<Dictionary<string, int>> AddFavorite(int memberRecordID, int bookRecordID)
        {
            int favoriteRecordId = await _repo.AddFavorite(memberRecordID, bookRecordID);

            return new Dictionary<string, int> { ["favoriteRecordID"] = favoriteRecordId };
        }

        public async Task<Dictionary<string, bool>> DeleteFavorite(int favoriteRecordID)
        {
            bool isDeleted = await _repo.DeleteFavorite(favoriteRecordID);

            return new Dictionary<string, bool> { ["isDeleted"] = isDeleted };
        }

        public async Task<Dictionary<string, List<BookCardDTO>>> GetFavorites(int memberRecordID)
        {
            var projections = await _repo.GetFavorites(memberRecordID);

            var books = BookCardMapper.FromProjectionList(projections);

            return new Dictionary<string, List<BookCardDTO>> { ["favorites"] = books };
        }
    }
}