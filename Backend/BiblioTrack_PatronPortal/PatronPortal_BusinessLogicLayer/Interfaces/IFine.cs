using PatronPortal_BusinessLogicLayer.DTOs;


namespace PatronPortal_BusinessLogicLayer.Interfaces
{
    public interface IFine
    {

        Task<Dictionary<string,List<UnpaidFineDTO>>> GetUnpaidFines(int MemberRecordId);

    }
}
