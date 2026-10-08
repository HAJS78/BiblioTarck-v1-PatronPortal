using System;
using System.Collections.Generic;

namespace PatronPortal_DataAccessLayer.Entities;

public partial class StripePayment
{
    public int StripePaymentRecordId { get; set; }

    public string PaymentIntentId { get; set; } = null!;

    public int LibraryPaymentRecordId { get; set; }

    public DateTime? DateCreated { get; set; }

    public virtual Payment LibraryPaymentRecord { get; set; } = null!;
}
