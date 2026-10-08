using Microsoft.EntityFrameworkCore;
using PatronPortal_DataAccessLayer.Context;
using PatronPortal_DataAccessLayer.Repositories.Interfaces;


namespace PatronPortal_DataAccessLayer.Repositories.Implementations
{
    public class PasswordRecoveryRepo : IPasswordRecoveryRepo
    {
        private readonly BiblioTrackv1Context _context;

        public PasswordRecoveryRepo(BiblioTrackv1Context context)
        {
            _context = context;
        }

        public async Task<int> FindPatronByEmail(string email)
        {

            var query = _context.People.Join(_context.LibraryMembers, p => p.PersonRecordId, m => m.PersonRecordId,
                 (people, member) => new { member.MemberRecordId, people.Email }).Where(p => p.Email == email);

            var member = await query.FirstOrDefaultAsync();


            if (member == null)
            {
                return -1;

            }

            return member.MemberRecordId;


        }


       public async Task<bool> UpdatePassword(int memberRecordID, string newPassword) 
       {

            var member = await _context.LibraryMembers.FindAsync(memberRecordID);

            if (member == null)
            {
                return false;
            }

            member.Password = newPassword;

            try 
            {

                await _context.SaveChangesAsync();
                return true;
            
            }
            catch 
            {
            
            return false;
            
            }
        
        
       }

    }
}
