using PatronPortal_BusinessLogicLayer.DTOs;
using PatronPortal_BusinessLogicLayer.Utilities;
using PatronPortal_DataAccessLayer.Repository.Projections;

namespace PatronPortal_BusinessLogicLayer.Mappers
{
    public static class BookCardMapper
    {
        public static BookCardDTO FromProjection(BookCardProjection projection)
        {

            string coverUrl = !string.IsNullOrWhiteSpace(projection.CoverImage)
        ? projection.CoverImage!
        : BookCoverUrlBuilder.BuildCoverUrl(projection.Isbn);
            return new BookCardDTO
            {
                BookRecordID = projection.BookRecordId,
                Title = projection.Title,
                Author = projection.Authors,
                BookCoverImageUrl = coverUrl,
                InFavorites = projection.FavoriteRecordId == null ? false :true,
                FavoriteRecordID = projection.FavoriteRecordId
            };
        }

        public static List<BookCardDTO> FromProjectionList(List<BookCardProjection> projections)
        {
            List<BookCardDTO> DTOs=[];

            foreach (var p in projections)
            { 
            
             DTOs.Add(FromProjection(p));
            
            
            }

            return DTOs;

            // return projections.Select(FromFavoriteProjection).ToList();
        }
    }
}