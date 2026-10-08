using PatronPortal_BusinessLogicLayer.DTOs;

public interface IPatronRecommendation
{
    Task<Dictionary<string, List<BookCardDTO>>> GetRecommendedBooks(int memberRecordID);
}