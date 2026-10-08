using System;
using System.Collections.Generic;

namespace PatronPortal_DataAccessLayer.Entities;

public partial class Reservation
{
    public int ReservationId { get; set; }

    public int LibraryCardRecordId { get; set; }

    public int BookCopyRecordId { get; set; }

    public DateOnly ReservationDate { get; set; }

    public byte ReservationStatus { get; set; }

    public virtual BookCopy BookCopyRecord { get; set; } = null!;

    public virtual LibraryCard LibraryCardRecord { get; set; } = null!;
}
