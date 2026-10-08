

using Microsoft.EntityFrameworkCore;
using PatronPortal_DataAccessLayer.Context;
using PatronPortal_DataAccessLayer.Repositories.Interfaces;
using PatronPortal_DataAccessLayer.Repositories.Projections;

namespace PatronPortal_DataAccessLayer.Repositories.Implementations
{
    public class  FineRepo:IFineRepo
    {


        private readonly BiblioTrackv1Context _context;

        public FineRepo(BiblioTrackv1Context context)
        {
            _context = context;
        }

        public async Task<List<UnpaidFineProjection>> GetUnpaidFines(int MemberRecordId) 
        {

            var query = _context.Fines.Where(f=>f.LibraryCardRecord.MemberRecordId==MemberRecordId && f.PaymentId == null).Select(f => new

            UnpaidFineProjection 
            {
               FineRecordID = f.FineId,
               LateDays=f.DaysPastDueDate,
               AmountDue=f.AmountDue,
               DateAdded=f.DateAdded,


            }


            );

            var unpaidFines = await query.ToListAsync();

            return unpaidFines;
        
        
        }


        public async Task<int?> GetLibraryCardRecordIdForFinePayment(int fineRecordID, int memberRecordID)
        {
            var query = _context.Fines
                .Where(f => f.FineId == fineRecordID
                         && f.LibraryCardRecord.MemberRecord.MemberRecordId == memberRecordID
                         && f.PaymentId == null
                         )
                .Select(f =>(int?) f.LibraryCardRecordId);

            var libraryCardRecordId = await query.FirstOrDefaultAsync();

            libraryCardRecordId = libraryCardRecordId == 0 ? null : libraryCardRecordId;

            return libraryCardRecordId;
        }



    }
}
