using Microsoft.EntityFrameworkCore;
using PatronPortal_DataAccessLayer.Context;
using PatronPortal_DataAccessLayer.Entities;
using PatronPortal_DataAccessLayer.Repositories.Interfaces;

using PatronPortal_DataAccessLayer.Repository.Projections;

namespace PatronPortal_DataAccessLayer.Repositories.Implementations
{
    public class PatronFavoritesRepo : IPatronFavoritesRepo
    {
        private readonly BiblioTrackv1Context _context;

        public PatronFavoritesRepo(BiblioTrackv1Context context)
        {
            _context = context;
        }

        public async Task<int> AddFavorite(int memberRecordID, int bookRecordID)
        {
            var favorite = new PatronFavorite
            {
                MemberRecordId = memberRecordID,
                BookRecordId = bookRecordID,
                DateAdded = DateOnly.FromDateTime(DateTime.Now)
            };

            _context.PatronFavorites.Add(favorite);

            try
            {
                await _context.SaveChangesAsync();
                return favorite.RecordId;
            }
            catch
            {
                return -1;
            }
        }

        public async Task<bool> DeleteFavorite(int favoriteRecordID)
        {
            var favorite = await _context.PatronFavorites.FindAsync(favoriteRecordID);

            if (favorite == null)
            {
                return false;
            }

            _context.PatronFavorites.Remove(favorite);

            try
            {
                await _context.SaveChangesAsync();
                return true;
            }
            catch
            {
                return false;
            }
        }

        public async Task<List<BookCardProjection>> GetFavorites(int memberRecordID)
        {
            var query = _context.PatronFavorites
                .Where(f => f.MemberRecordId == memberRecordID)
                .Select(fb => new BookCardProjection
                {
                    FavoriteRecordId = fb.RecordId,
                    BookRecordId = fb.BookRecordId,
                    Title = fb.BookRecord.Title,
                    Authors = fb.BookRecord.Authors,
                    CoverImage = fb.BookRecord.CoverImage,
                    Isbn = fb.BookRecord.Isbn
                });

            var favorites = await query.ToListAsync();

            return favorites;
        }
    }
}
