using PatronPortal_BusinessLogicLayer.DTOs;
using PatronPortal_BusinessLogicLayer.Interfaces;
using PatronPortal_BusinessLogicLayer.Utlities;
using PatronPortal_DataAccessLayer.Enums;
using PatronPortal_DataAccessLayer.Repositories.Interfaces;

namespace PatronPortal_BusinessLogicLayer.Implementations
{
    public class PatronRegisteration : IPatronRegisteration
    {
        private readonly IPatronRegisterationRepo _repo;

        public PatronRegisteration(IPatronRegisterationRepo repo)
        {
            _repo = repo;
        }

        public async Task<Dictionary<string,bool>> IsUserNameTaken(string userName)
        {
            bool taken = await _repo.IsUserNameTaken(userName);

            Dictionary<string, bool> UserNameAvailability = new() {["isTaken"]= taken };

            return  UserNameAvailability;
        }

        public async Task<Dictionary<string,int>> FindPatronByLibraryCardNumber(string libraryCardNumber)
        {
            string hashedCardNumber= HashingUtility.ConvertToHash(libraryCardNumber);


            int memberRecordId = await _repo.FindPatronByLibraryCardNumber(hashedCardNumber);


            Dictionary<string, int> dic = new()
            {
                ["memberRecordID"] = memberRecordId

            };


            return dic;
        }

        public async Task<(bool isSignedUp, string? errorMessage)> UpdatePatronAccount(string userName, string password, int memberRecordID)
        {
            EnAccountUpdateResult result = await _repo.UpdatePatronAccount(userName, password, memberRecordID);

            return result switch
            {
                EnAccountUpdateResult.Success => (true, null),
                EnAccountUpdateResult.MemberNotFound => (false, "No matching patron record found."),
                EnAccountUpdateResult.AlreadyRegistered => (false, "You have already setup your online account. Use forget password instead."),
                EnAccountUpdateResult.SaveFailed => (false, "Unable to complete sign up. Please try again."),
                _ => (false, "Unknown error.")
            };
        }
    }
}