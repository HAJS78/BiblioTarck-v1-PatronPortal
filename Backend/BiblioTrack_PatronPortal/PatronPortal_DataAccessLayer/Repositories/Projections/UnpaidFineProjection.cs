
using PatronPortal_DataAccessLayer.Entities;

namespace PatronPortal_DataAccessLayer.Repositories.Projections
{
    public  class UnpaidFineProjection
    {

        public int FineRecordID { get; set; }
               
        public int LateDays { get; set; }

        public decimal AmountDue { get; set; }

        public DateOnly DateAdded { get; set; }

        


    }
}
