using System;
using System.Collections.Generic;

namespace PatronPortal_DataAccessLayer.Entities;

public partial class Fine
{
    public int FineId { get; set; }

    public int LibraryCardRecordId { get; set; }

    public int DaysPastDueDate { get; set; }

    public decimal AmountDue { get; set; }

    public DateOnly DateAdded { get; set; }

    public int AddedByLibrarianRecordId { get; set; }

    public int? PaymentId { get; set; }

    public virtual LibraryCard LibraryCardRecord { get; set; } = null!;

    public virtual Payment? Payment { get; set; }
}
