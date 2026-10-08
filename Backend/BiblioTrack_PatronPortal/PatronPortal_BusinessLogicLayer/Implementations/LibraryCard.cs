using PatronPortal_BusinessLogicLayer.DTOs;
using PatronPortal_BusinessLogicLayer.Interfaces;
using PatronPortal_BusinessLogicLayer.Mappers;
using PatronPortal_BusinessLogicLayer.Utlities;
using PatronPortal_DataAccessLayer.Entities;
using PatronPortal_DataAccessLayer.Repositories.Interfaces;

namespace PatronPortal_BusinessLogicLayer.Implementations
{
    public class LibraryCard : ILibraryCard
    {
        private readonly ILibraryCardRepo _repo;

        public LibraryCard(ILibraryCardRepo repo)
        {
            _repo = repo;
        }


        public async Task<Dictionary<string, int?>> FindLibraryCard(string LibraryCardNumber)
        {
            string hashedcardNumber = HashingUtility.ConvertToHash(LibraryCardNumber);

            int? LibraryCardRecordId = await _repo.FindLibraryCard(hashedcardNumber);

            return new Dictionary<string, int?> { ["libraryCardRecordID"] = LibraryCardRecordId };
        }



    }
}