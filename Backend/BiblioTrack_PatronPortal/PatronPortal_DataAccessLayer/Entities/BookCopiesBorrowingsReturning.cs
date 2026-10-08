using System;
using System.Collections.Generic;

namespace PatronPortal_DataAccessLayer.Entities;

public partial class BookCopiesBorrowingsReturning
{
    public int BookCopyBorrowingReturningId { get; set; }

    public int LibraryCardRecordId { get; set; }

    public int BookCopyRecordId { get; set; }

    public DateOnly BorrowingDate { get; set; }

    public DateOnly DueDate { get; set; }

    public int CheckoutProcessedBy { get; set; }

    public DateOnly? ReturningDate { get; set; }

    public int? ReturnProcessedBy { get; set; }

    public virtual BookCopy BookCopyRecord { get; set; } = null!;

    public virtual LibraryCard LibraryCardRecord { get; set; } = null!;
}
