using System;
using System.Collections.Generic;

namespace PatronPortal_DataAccessLayer.Entities;

public partial class Book
{
    public int BookRecordId { get; set; }

    public string Title { get; set; } = null!;

    public string Authors { get; set; } = null!;

    public string Isbn { get; set; } = null!;

    public DateOnly PublicationDate { get; set; }

    public int Category { get; set; }

    public string? Publisher { get; set; }

    public int NumberOfCopies { get; set; }

    public string? Location { get; set; }

    public string? CallNumber { get; set; }

    public DateOnly DateAdded { get; set; }

    public string? Edition { get; set; }

    public string? Language { get; set; }

    public string? NumberOfPages { get; set; }

    public string? Summary { get; set; }

    public string? CoverImage { get; set; }

    public virtual ICollection<BookCopy> BookCopies { get; set; } = new List<BookCopy>();

    public virtual ICollection<BooksTag> BooksTags { get; set; } = new List<BooksTag>();

    public virtual ICollection<PatronFavorite> PatronFavorites { get; set; } = new List<PatronFavorite>();
}
