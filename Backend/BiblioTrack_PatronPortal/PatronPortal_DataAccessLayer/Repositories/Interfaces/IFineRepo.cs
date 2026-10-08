

using PatronPortal_DataAccessLayer.Repositories.Projections;

namespace PatronPortal_DataAccessLayer.Repositories.Interfaces
{
    public interface IFineRepo
    {
        Task<List<UnpaidFineProjection>> GetUnpaidFines(int MemberRecordId);
        Task<int?> GetLibraryCardRecordIdForFinePayment(int fineRecordID, int memberRecordID);

    }
}
