

using PatronPortal_DataAccessLayer.Enums;

namespace PatronPortal_DataAccessLayer.Repositories.Interfaces
{
    public interface IPatronRegisterationRepo
    {
        Task<bool> IsUserNameTaken(string userName);
        Task<int> FindPatronByLibraryCardNumber(string libraryCardNumber);
        Task<EnAccountUpdateResult> UpdatePatronAccount(string userName, string password, int memberRecordID);
    }
}
