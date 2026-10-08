using PatronPortal_BusinessLogicLayer.DTOs;
using PatronPortal_BusinessLogicLayer.Utilities;
using PatronPortal_DataAccessLayer.Repository.Projections;

namespace PatronPortal_BusinessLogicLayer.Mappers
{
    public static class BookDetailsMapper
    {
        public static BookDetailsDTO FromProjection(BookDetailsProjection projection)
        {
            string coverUrl = !string.IsNullOrWhiteSpace(projection.CoverImage)
                ? projection.CoverImage!
                : BookCoverUrlBuilder.BuildCoverUrl(projection.Isbn);

            return new BookDetailsDTO
            {
                BookRecordID = projection.BookRecordId,
                Title = projection.Title,
                Author = projection.Authors,
                BookCoverImageUrl = coverUrl,
                Summary = projection.Summary ?? string.Empty,
                InFavorites = projection.FavoriteRecordId != null,
                FavoriteRecordID = projection.FavoriteRecordId
            };
        }
    }
}