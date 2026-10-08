namespace PatronPortal_BusinessLogicLayer.DTOs
{
    public class BookDetailsDTO
    {
        public int BookRecordID { get; set; }
        public string Title { get; set; } = null!;
        public string Author { get; set; } = null!;
        public string BookCoverImageUrl { get; set; } = string.Empty;
        public string Summary { get; set; } = string.Empty;
        public bool InFavorites { get; set; }
        public int? FavoriteRecordID { get; set; }
    }
}
