using Microsoft.EntityFrameworkCore;
using PatronPortal_DataAccessLayer.Context;
using PatronPortal_DataAccessLayer.Repositories.Interfaces;
using PatronPortal_DataAccessLayer.Repository.Projections;

namespace PatronPortal_DataAccessLayer.Repositories.Implementations
{
    public class LibraryCardRepo : ILibraryCardRepo
    {
        private readonly BiblioTrackv1Context _context;

        public LibraryCardRepo(BiblioTrackv1Context context)
        {
            _context = context;
        }


        public async Task<int?>  FindLibraryCard(string LibraryCardNumber) 
        {

            var query = _context.LibraryCards.Where(l => l.LibraryCardNumber == LibraryCardNumber).
                  Select(l =>(int?) l.LibraryCardRecordId);
           
            var LibraryCardRecordId =await query.FirstOrDefaultAsync();

            LibraryCardRecordId= LibraryCardRecordId == 0 ? null: LibraryCardRecordId;

            return LibraryCardRecordId;
        
        }


    }
}



