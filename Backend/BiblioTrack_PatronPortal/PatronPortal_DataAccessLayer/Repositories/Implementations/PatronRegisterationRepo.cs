using Microsoft.EntityFrameworkCore;
using PatronPortal_DataAccessLayer.Context;
using PatronPortal_DataAccessLayer.Enums;
using PatronPortal_DataAccessLayer.Repositories.Interfaces;


namespace PatronPortal_DataAccessLayer.Repositories.Implementations
{
    public class PatronRegisterationRepo : IPatronRegisterationRepo
    {
        private readonly BiblioTrackv1Context _context;

        public PatronRegisterationRepo(BiblioTrackv1Context context)
        {
            _context = context;
        }

        public async Task<bool> IsUserNameTaken(string userName)
        {
            var query = _context.LibraryMembers.Where(m => m.UserName == userName);

            bool exists = await query.AnyAsync();

            return exists;
        }

        public async Task<int> FindPatronByLibraryCardNumber(string libraryCardNumber)
        {
            var query = _context.LibraryCards
                .Where(c => c.LibraryCardNumber == libraryCardNumber)
                .Select(c => c.MemberRecordId);

            var memberRecordId = await query.FirstOrDefaultAsync();

            // FirstOrDefaultAsync on a non-nullable int returns 0 (not null) when no match is found —
            // 0 is never a real MemberRecordID (identity columns start at 1), so it's a safe "not found" sentinel here.
            if (memberRecordId == 0)
            {
                return -1;
            }

            return memberRecordId;
        }

        public async Task<EnAccountUpdateResult> UpdatePatronAccount(string userName, string password, int memberRecordID)
        {
            var member = await _context.LibraryMembers.FindAsync(memberRecordID);

            if (member == null)
            {
                return EnAccountUpdateResult.MemberNotFound;
            }

            if (member.UserName != null)
            {
                return EnAccountUpdateResult.AlreadyRegistered;
            }

            member.UserName = userName;
            member.Password = password;

            try
            {
                await _context.SaveChangesAsync();
                return EnAccountUpdateResult.Success;
            }
            catch
            {
                return EnAccountUpdateResult.SaveFailed;
            }
        }
    }
}