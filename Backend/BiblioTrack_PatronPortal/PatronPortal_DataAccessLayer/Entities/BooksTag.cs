using System;
using System.Collections.Generic;

namespace PatronPortal_DataAccessLayer.Entities;

public partial class BooksTag
{
    public int BookTagRecordId { get; set; }

    public int BookRecordId { get; set; }

    public int TagRecordId { get; set; }

    public virtual Book BookRecord { get; set; } = null!;

    public virtual Tag TagRecord { get; set; } = null!;
}
