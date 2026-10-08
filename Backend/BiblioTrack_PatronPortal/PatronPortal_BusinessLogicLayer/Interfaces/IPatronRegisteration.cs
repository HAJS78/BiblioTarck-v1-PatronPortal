using PatronPortal_BusinessLogicLayer.DTOs;

namespace PatronPortal_BusinessLogicLayer.Interfaces
{
    public interface IPatronRegisteration
    {
        Task<Dictionary<string, bool>> IsUserNameTaken(string userName);
        Task<Dictionary<string,int>> FindPatronByLibraryCardNumber(string libraryCardNumber);
        Task<(bool isSignedUp, string? errorMessage)> UpdatePatronAccount(string userName, string password, int memberRecordID);
    }
}
