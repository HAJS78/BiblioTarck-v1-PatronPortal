using System;
using System.Collections.Generic;

namespace PatronPortal_DataAccessLayer.Entities;

public partial class PatronFavorite
{
    public int RecordId { get; set; }

    public int MemberRecordId { get; set; }

    public int BookRecordId { get; set; }

    public DateOnly DateAdded { get; set; }

    public virtual Book BookRecord { get; set; } = null!;

    public virtual LibraryMember MemberRecord { get; set; } = null!;
}
