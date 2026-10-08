using PatronPortal_BusinessLogicLayer.DTOs;
using PatronPortal_BusinessLogicLayer.Interfaces;
using PatronPortal_BusinessLogicLayer.Mappers;
using PatronPortal_DataAccessLayer.Repositories.Interfaces;

public class PatronRecommendation : IPatronRecommendation
{
    private readonly IPatronRecommendationRepo _repo;

    public PatronRecommendation(IPatronRecommendationRepo repo)
    {
        _repo = repo;
    }

    public async Task<Dictionary<string, List<BookCardDTO>>> GetRecommendedBooks(int memberRecordID)
    {
        var projections = await _repo.GetRecommendedBooks(memberRecordID);
        var books = BookCardMapper.FromProjectionList(projections);

        return new Dictionary<string, List<BookCardDTO>> { ["recommendedBooks"] = books };
    }
}