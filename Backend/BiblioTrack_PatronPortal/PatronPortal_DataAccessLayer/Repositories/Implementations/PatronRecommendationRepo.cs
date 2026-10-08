using Microsoft.EntityFrameworkCore;
using PatronPortal_DataAccessLayer.Context;
using PatronPortal_DataAccessLayer.Repositories.Interfaces;

using PatronPortal_DataAccessLayer.Repository.Projections;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace PatronPortal_DataAccessLayer.Repositories.Implementations
{
    public class PatronRecommendationRepo : IPatronRecommendationRepo
    {
        private readonly BiblioTrackv1Context _context;
    

        public PatronRecommendationRepo(BiblioTrackv1Context context)
        {
            _context = context;
        }

        public async Task<List<BookCardProjection>> GetRecommendedBooks(int memberRecordID)
        {
          


            bool hasFavorites = await _context.PatronFavorites
                .AnyAsync(f => f.MemberRecordId == memberRecordID);

           

            if (!hasFavorites)
            {
                // No favorites yet — fall back to any five random books, per agreed behavior.

                var query = _context.Books.OrderBy(b => b.Title).Take(5).Select(b => new BookCardProjection
                {

                    FavoriteRecordId = null,
                    BookRecordId = b.BookRecordId,
                    Title = b.Title,
                    Authors = b.Authors,
                    CoverImage = b.CoverImage,
                    Isbn = b.Isbn


                });

                var recommendedBooks=await query.ToListAsync();

                 return recommendedBooks;
                  
            }
            else
            {

                var query1 = _context.PatronFavorites.Where(pf=>pf.MemberRecordId==memberRecordID).Select(pf => pf.BookRecordId);

                var query2 = _context.PatronFavorites.Where(pf => pf.MemberRecordId == memberRecordID).Select(pf => pf.BookRecord)
                    .SelectMany(b => b.BooksTags).Select(bt => bt.TagRecord.Tagword);
                    
                    


                var query3 =_context.Books.Where(b=>!query1.Contains(b.BookRecordId) && b.BooksTags.Any(bt=>query2.Contains(bt.TagRecord.Tagword))).OrderBy(b => b.Title).Take(5).Select(b => new BookCardProjection
                {

                    FavoriteRecordId = null,
                    BookRecordId = b.BookRecordId,
                    Title = b.Title,
                    Authors = b.Authors,
                    CoverImage = b.CoverImage,
                    Isbn = b.Isbn


                });

                var recommendedBooks = await query3.ToListAsync();

                return recommendedBooks;


            }

           

            
        }
    }
}
