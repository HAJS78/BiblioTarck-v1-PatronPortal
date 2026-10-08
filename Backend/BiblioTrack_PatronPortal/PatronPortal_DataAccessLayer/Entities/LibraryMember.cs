using System;
using System.Collections.Generic;

namespace PatronPortal_DataAccessLayer.Entities;

public partial class LibraryMember
{
    public int MemberRecordId { get; set; }

    public int PersonRecordId { get; set; }

    public string? UserName { get; set; }

    public string? Password { get; set; }

    public virtual ICollection<LibraryCard> LibraryCards { get; set; } = new List<LibraryCard>();

    public virtual ICollection<LibraryMemberNotification> LibraryMemberNotifications { get; set; } = new List<LibraryMemberNotification>();

    public virtual ICollection<PatronFavorite> PatronFavorites { get; set; } = new List<PatronFavorite>();

    public virtual Person PersonRecord { get; set; } = null!;
}
