using System;
using System.Collections.Generic;

namespace PatronPortal_DataAccessLayer.Entities;

public partial class LibraryCard
{
    public int LibraryCardRecordId { get; set; }

    public string LibraryCardNumber { get; set; } = null!;

    public int MemberRecordId { get; set; }

    public DateOnly IssuanceDate { get; set; }

    public DateOnly ExpirationDate { get; set; }

    public byte CardStatus { get; set; }

    public virtual ICollection<BookCopiesBorrowingsReturning> BookCopiesBorrowingsReturnings { get; set; } = new List<BookCopiesBorrowingsReturning>();

    public virtual ICollection<Fine> Fines { get; set; } = new List<Fine>();

    public virtual LibraryMember MemberRecord { get; set; } = null!;

    public virtual ICollection<Payment> Payments { get; set; } = new List<Payment>();

    public virtual ICollection<Reservation> Reservations { get; set; } = new List<Reservation>();
}
