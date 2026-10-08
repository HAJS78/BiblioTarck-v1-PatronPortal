namespace PatronPortal_DataAccessLayer.Repository.Projections
{
    public class BookCardProjection
    {
        public int? FavoriteRecordId { get; set; }
        public int BookRecordId { get; set; }
        public string Title { get; set; } = null!;
        public string Authors { get; set; } = null!;
        public string? CoverImage { get; set; }
        public string Isbn { get; set; } = null!;
    }
}
