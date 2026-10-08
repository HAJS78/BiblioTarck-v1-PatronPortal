using System;
using System.Collections.Generic;

namespace PatronPortal_DataAccessLayer.Entities;

public partial class BookCopy
{
    public int BookCopyRecordId { get; set; }

    public string BookCopyBarcodeNumber { get; set; } = null!;

    public int BookRecordId { get; set; }

    public byte? Condition { get; set; }

    public byte AvailabilityStatus { get; set; }

    public virtual ICollection<BookCopiesBorrowingsReturning> BookCopiesBorrowingsReturnings { get; set; } = new List<BookCopiesBorrowingsReturning>();

    public virtual Book BookRecord { get; set; } = null!;

    public virtual ICollection<Reservation> Reservations { get; set; } = new List<Reservation>();
}
