using System;
using System.Collections.Generic;

namespace PatronPortal_DataAccessLayer.Entities;

public partial class LibraryMemberNotification
{
    public int NotificationId { get; set; }

    public int LibraryMemberRecordId { get; set; }

    public string Message { get; set; } = null!;

    public bool IsRead { get; set; }

    public DateOnly CreatedAt { get; set; }

    public int CreatedByLibrarianRecordId { get; set; }

    public string NotificationType { get; set; } = null!;

    public virtual LibraryMember LibraryMemberRecord { get; set; } = null!;
}
