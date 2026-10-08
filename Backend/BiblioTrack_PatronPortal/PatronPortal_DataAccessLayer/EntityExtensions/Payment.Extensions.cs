using PatronPortal_DataAccessLayer.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PatronPortal_DataAccessLayer.Entities
{
    public partial class Payment
    {
        public EnPaymentStatus Status => (EnPaymentStatus)PaymentStatus;

        // Alias for the DatePaied column typo — see BiblioTrack_TODO.md
        public DateOnly DatePaid => DatePaied;
    }
}
