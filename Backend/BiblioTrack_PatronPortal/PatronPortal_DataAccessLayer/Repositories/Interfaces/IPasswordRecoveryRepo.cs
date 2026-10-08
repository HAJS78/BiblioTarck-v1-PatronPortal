

namespace PatronPortal_DataAccessLayer.Repositories.Interfaces
{
    public interface IPasswordRecoveryRepo
    {
        Task<int> FindPatronByEmail(string email);
        Task<bool> UpdatePassword(int memberRecordID, string newPassword);
    }
}
