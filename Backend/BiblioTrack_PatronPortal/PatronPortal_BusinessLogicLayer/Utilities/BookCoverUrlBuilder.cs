namespace PatronPortal_BusinessLogicLayer.Utilities
{
    public static class BookCoverUrlBuilder
    {
        // Open Library Covers API — free, no API key, keyed by ISBN.
        // "-M" = medium size. Testing/placeholder use only; not guaranteed
        // to have coverage for every title, and not intended as the final
        // production image source (see BiblioTrack_TODO.md).
        private const string BaseUrl = "https://covers.openlibrary.org/b/isbn";

        public static string BuildCoverUrl(string? isbn)
        {
            if (string.IsNullOrWhiteSpace(isbn))
            {
                return string.Empty;
            }

            return $"{BaseUrl}/{isbn}-M.jpg";
        }
    }
}
