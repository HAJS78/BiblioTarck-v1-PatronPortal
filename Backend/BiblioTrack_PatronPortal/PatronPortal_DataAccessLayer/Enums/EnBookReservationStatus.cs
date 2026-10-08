

namespace PatronPortal_DataAccessLayer.Enums;

public enum EnBookReservationStatus : byte
{
    Confirmed = 1,
    OnReservationShelf = 2,
    Completed_BookPickedUp = 3,
    Cancelled = 4
}