using PatronPortal_BusinessLogicLayer.DTOs;
using PatronPortal_BusinessLogicLayer.Interfaces;
using PatronPortal_BusinessLogicLayer.Mappers;
using PatronPortal_DataAccessLayer.Repositories.Interfaces;



namespace PatronPortal_BusinessLogicLayer.Implementations
{
    public class Auth : IAuth
    {
        private readonly IAuthRepo _authRepo;

        public Auth(IAuthRepo authRepo)
        {
            _authRepo = authRepo;
        }

        public async Task<LoggedInPatronDTO?> FindPatronByUsernameAndPasswordAsync(string username, string password)
        {
            var projection = await _authRepo.FindPatronByUsernameAndPasswordAsync(username, password);

            if (projection == null)
            {
                return null;
            }

            return LoggedInPatronMapper.FromProjection(projection);
        }
    }
}