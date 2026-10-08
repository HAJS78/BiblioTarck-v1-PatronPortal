namespace PatronPortal_DataAccessLayer.Repository.Projections
{
    public class BookDetailsProjection
    {
        public int BookRecordId { get; set; }
        public string Title { get; set; } = null!;
        public string Authors { get; set; } = null!;
        public string? CoverImage { get; set; }
        public string Isbn { get; set; } = null!;
        public string? Summary { get; set; }
        public int? FavoriteRecordId { get; set; }

       
    }
}
