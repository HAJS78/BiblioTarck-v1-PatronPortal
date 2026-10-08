using Microsoft.EntityFrameworkCore;
using PatronPortal_DataAccessLayer.Context;
using PatronPortal_DataAccessLayer.Entities;
using PatronPortal_DataAccessLayer.Repositories.Interfaces;
using PatronPortal_DataAccessLayer.Repository.Projections;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace PatronPortal_DataAccessLayer.Repositories.Implementations
{
    public class BookRepo : IBookRepo
    {
        private readonly BiblioTrackv1Context _context;

        public BookRepo(BiblioTrackv1Context context)
        {
            _context = context;
        }

        public async Task<BookDetailsProjection?> GetBookDetails(int bookRecordID, int memberRecordID)
        {

            //GroupJoin is genuinely the right LINQ operator for this — it's the "give me the book,
            //plus all matching favorites as a group (possibly empty)" operation
            //, which is exactly the left-join-shaped thing we want.
            
            
            
            var query = _context.Books.Where(b => b.BookRecordId == bookRecordID).GroupJoin(_context.PatronFavorites, b => b.BookRecordId, f => f.BookRecordId, (book, FavoriteRecords) =>

            new BookDetailsProjection
            {
                BookRecordId = book.BookRecordId,
                Title = book.Title,
                Authors = book.Authors,
                CoverImage = book.CoverImage,
                Isbn = book.Isbn,
                Summary = book.Summary,
                FavoriteRecordId = FavoriteRecords.Where(f=>f.MemberRecordId==memberRecordID).Select(r =>(int?) r.RecordId).FirstOrDefault(),
                

            });

            var book = await query.FirstOrDefaultAsync();

            return book;

            


        }


        public async Task<List<BookCardProjection>> SearchCatalog(int MemberRecordID,string SearchKeyword, string Searchfilter)
        {
            var query1=_context.Books.AsQueryable();

            switch (Searchfilter)
            {

                case "Title":
                    {
                         query1 = _context.Books.Where(b => b.Title.Contains(SearchKeyword));
                         break;
                    }

                case "Author":
                    {
                        query1 = _context.Books.Where(b => b.Authors.Contains(SearchKeyword) );
                        break;
                    }

                case "ISBN":
                    {
                        query1 = _context.Books.Where(b => b.Isbn==SearchKeyword);
                        break;
                    }


                case "Tag":
                    {
                        query1 = _context.Tags.Where(t => t.Tagword == SearchKeyword).SelectMany(t => t.BooksTags).Select(bt => bt.BookRecord);

                        break;
                       
                    }




            }




            var query2 = query1.Select(b => new BookCardProjection

            {

                FavoriteRecordId = b.PatronFavorites.Where(f=>f.MemberRecordId== MemberRecordID).Select(f =>(int?) f.RecordId).FirstOrDefault(),
                BookRecordId = b.BookRecordId,
                Title = b.Title,
                Authors = b.Authors,
                CoverImage = b.CoverImage,
                Isbn = b.Isbn



            }


            );


            return await query2.ToListAsync();
        }




    }
}


//for each Book row matching bookRecordID (here, exactly one, since you already filtered by ID), GroupJoin pairs it with a group — a whole collection — of every PatronFavorite row that shares its BookRecordId, whether that's zero, one, or many.
//it is : one row per book, and inside that row, an entire sub-collection (FavoriteRecords) sitting alongside the book's own fields, still waiting to be processed.
//That's the "(book, FavoriteRecords)" pair — book is a single entity, FavoriteRecords is the whole matched group, not yet narrowed down.

//"Only keep the record that match that specific memberRecordID" — precisely,
//this happens inside the projection, on that FavoriteRecords group specifically,
//not as a row-level filter on the whole query.
//FavoriteRecords.Where(f => f.MemberRecordId == memberRecordID) narrows that one book's group down to (at most) the single favorite belonging to the calling patron —
//everyone else's favorites for that same book get discarded right there, inside the projection, before .Select(...).FirstOrDefault() ever runs.


// .FirstOrDefaultAsync() is what actually triggers SQL execution —
// everything before it (Where, GroupJoin, the projection) was just building up the query's shape in memory,
// translated to SQL only at this final materializing call,
 