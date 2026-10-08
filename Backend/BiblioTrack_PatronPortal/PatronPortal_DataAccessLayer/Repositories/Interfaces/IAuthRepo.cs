using PatronPortal_DataAccessLayer.Entities;
using PatronPortal_DataAccessLayer.Repositories.Projections;


namespace PatronPortal_DataAccessLayer.Repositories.Interfaces
{
    public interface IAuthRepo
    {
      Task<LoggedInPatronProjection?> FindPatronByUsernameAndPasswordAsync(string username,string  password);

    }
}
