using Microsoft.EntityFrameworkCore;
using PatronPortal_DataAccessLayer.Context;
using PatronPortal_DataAccessLayer.Entities;
using PatronPortal_DataAccessLayer.Enums;
using PatronPortal_DataAccessLayer.Repositories.Interfaces;
using PatronPortal_DataAccessLayer.Repository.Projections;

namespace PatronPortal_DataAccessLayer.Repositories.Implementations
{
    public class BookReservationRepo : IBookReservationRepo
    {
        private readonly BiblioTrackv1Context _context;

        public BookReservationRepo(BiblioTrackv1Context context)
        {
            _context = context;
        }

        public async Task<BookCopyAvailabilityProjection> GetBookCopyAvailability(int bookRecordID)
        {
            int availableCopyId = await _context.BookCopies
                .Where(c => c.BookRecordId == bookRecordID
                         && c.AvailabilityStatus == (byte)EnBookCopyAvailability.Available)
                .Select(c => c.BookCopyRecordId)
                .FirstOrDefaultAsync();

            List<BorrowedCopyProjection> borrowedCopies = new();

            if (availableCopyId == 0)  //0 default value returned by .FirstOrDefaultAsync(); i.e No BookCopies Found
            {
                var query = _context.BookCopies.Where(bc=>bc.BookRecordId==bookRecordID && bc.AvailabilityStatus==(byte)EnBookCopyAvailability.CheckedOut).SelectMany(bc => bc.BookCopiesBorrowingsReturnings, (bc, bb) =>

                new { bc.BookCopyRecordId, bc.BookCopyBarcodeNumber, bb.DueDate,bb.ReturningDate }).Where(bb=>bb.ReturningDate==null)
                    
                     .Select(c => new BorrowedCopyProjection
                     {
                         BookCopyRecordId = c.BookCopyRecordId,
                         BookCopyBarcodeNumber = c.BookCopyBarcodeNumber,
                         ExpectedReturnDate = c.DueDate
                     });

                borrowedCopies = await query.ToListAsync();
            }

            return new BookCopyAvailabilityProjection
            {
                AvailableBookCopyId = availableCopyId==0?null:availableCopyId,
                BorrowedCopies = borrowedCopies
            };
        }

        public async Task<int> ConfirmReservation(int libraryCardRecordID, int bookCopyRecordID)
        {

            var bookCopy = await _context.BookCopies.FindAsync(bookCopyRecordID);

            if (bookCopy == null)
            {
                return -1;
            }


            var reservation = new Reservation
            {
                LibraryCardRecordId = libraryCardRecordID,
                BookCopyRecordId = bookCopyRecordID,
                ReservationDate = DateOnly.FromDateTime(DateTime.Now),
                ReservationStatus = (byte)EnBookReservationStatus.Confirmed
            };

            _context.Reservations.Add(reservation);

            if (bookCopy.AvailabilityStatus == (byte)EnBookCopyAvailability.Available)
            {
                bookCopy.AvailabilityStatus = (byte)EnBookCopyAvailability.Reserved;
            }
            else 
            {

                bookCopy.AvailabilityStatus = (byte)EnBookCopyAvailability.CheckedOutReserved;
            }


            try
            {
                await _context.SaveChangesAsync();
                return reservation.ReservationId;
            }
            catch
            {
                return -1;
            }
        }
    }
}