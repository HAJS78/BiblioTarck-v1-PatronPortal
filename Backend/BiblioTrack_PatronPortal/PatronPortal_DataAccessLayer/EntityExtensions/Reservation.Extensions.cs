using PatronPortal_DataAccessLayer.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PatronPortal_DataAccessLayer.Entities
{
    public partial class Reservation
    {
        public EnBookReservationStatus Status => (EnBookReservationStatus)ReservationStatus;
    }
}
