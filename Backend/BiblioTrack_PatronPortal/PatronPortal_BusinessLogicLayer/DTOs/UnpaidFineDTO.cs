using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PatronPortal_BusinessLogicLayer.DTOs
{
    public class UnpaidFineDTO
    {
        public int FineRecordID { get; set; }

        public int LateDays { get; set; }

        public decimal AmountDue { get; set; }

        public DateOnly DateAdded { get; set; }

    }
}
