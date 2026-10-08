
namespace PatronPortal_DataAccessLayer.Enums;

public enum EnBookCopyAvailability : byte
{
    Available = 1,
    CheckedOut = 2,
    Reserved = 3,
    Lost = 4,
    CheckedOutReserved=5
}