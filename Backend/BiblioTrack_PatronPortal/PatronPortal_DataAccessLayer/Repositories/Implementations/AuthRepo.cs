using Microsoft.EntityFrameworkCore;
using PatronPortal_DataAccessLayer.Context;

using PatronPortal_DataAccessLayer.Repositories.Interfaces;
using PatronPortal_DataAccessLayer.Repositories.Projections;


namespace PatronPortal_DataAccessLayer.Repositories.Implementations
{
    public class AuthRepo : IAuthRepo
    {

        private BiblioTrackv1Context _context;

        public AuthRepo(BiblioTrackv1Context context)
        {

            _context = context;

        }

        public async Task<LoggedInPatronProjection?>  FindPatronByUsernameAndPasswordAsync(string username, string password) 
        {

            var query =

             _context.LibraryMembers
            .Where(m => m.UserName == username && m.Password == password)
            .Select(m => new LoggedInPatronProjection
            {
                MemberRecordId = m.MemberRecordId,
                PersonRecordId = m.PersonRecordId,
                UserName = m.UserName!,
                PhotoUrl = m.PersonRecord.PersonalPhoto
            });

             var member= await query.FirstOrDefaultAsync();
 
             return member;
        }

    }
}
