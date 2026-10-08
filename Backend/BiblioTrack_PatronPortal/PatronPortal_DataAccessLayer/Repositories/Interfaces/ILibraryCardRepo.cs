

namespace PatronPortal_DataAccessLayer.Repositories.Interfaces
{
    public interface ILibraryCardRepo
    {
        Task<int?> FindLibraryCard(string LibraryCardNumber);
    }
}