

namespace PatronPortal_BusinessLogicLayer.Interfaces
{
    public interface ILibraryCard
    {
        Task<Dictionary<string, int?>> FindLibraryCard(string LibraryCardNumber);
    }
}