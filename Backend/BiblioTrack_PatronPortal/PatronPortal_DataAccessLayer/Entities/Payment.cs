using System;
using System.Collections.Generic;

namespace PatronPortal_DataAccessLayer.Entities;

public partial class Payment
{
    public int PaymentId { get; set; }

    public int LibraryCardRecordId { get; set; }

    public byte PaymentMethod { get; set; }

    public byte PaymentStatus { get; set; }

    public DateOnly DatePaied { get; set; }

    public int? ProcessedByLibrarianRecordId { get; set; }

    public virtual ICollection<Fine> Fines { get; set; } = new List<Fine>();

    public virtual LibraryCard LibraryCardRecord { get; set; } = null!;

    public virtual ICollection<StripePayment> StripePayments { get; set; } = new List<StripePayment>();
}
