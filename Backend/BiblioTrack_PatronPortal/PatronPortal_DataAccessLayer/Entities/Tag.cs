using System;
using System.Collections.Generic;

namespace PatronPortal_DataAccessLayer.Entities;

public partial class Tag
{
    public int TagRecordId { get; set; }

    public string Tagword { get; set; } = null!;

    public virtual ICollection<BooksTag> BooksTags { get; set; } = new List<BooksTag>();
}
