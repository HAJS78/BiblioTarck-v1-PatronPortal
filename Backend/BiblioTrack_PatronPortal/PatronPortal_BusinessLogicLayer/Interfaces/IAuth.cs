

using PatronPortal_BusinessLogicLayer.DTOs;


namespace PatronPortal_BusinessLogicLayer.Interfaces
{
    public interface IAuth
    {
        Task<LoggedInPatronDTO?> FindPatronByUsernameAndPasswordAsync(string username, string password);
    }
}