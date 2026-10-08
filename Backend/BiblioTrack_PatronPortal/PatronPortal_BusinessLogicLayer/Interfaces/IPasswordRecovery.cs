

namespace PatronPortal_BusinessLogicLayer.Interfaces
{

    public interface IPasswordRecovery
    {

        Task<Dictionary<string, int>> FindPatronByEmail(string email);
        Task<bool> UpdatePassword(int memberRecordID, string newPassword);
    }


}
