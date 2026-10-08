
using Microsoft.EntityFrameworkCore;
using PatronPortal_DataAccessLayer.Context;
using PatronPortal_DataAccessLayer.Entities;
using PatronPortal_DataAccessLayer.Enums;
using PatronPortal_DataAccessLayer.Repositories.Interfaces;

namespace PatronPortal_DataAccessLayer.Repositories.Implementations
{
    public class PaymentRepo : IPaymentRepo
    {
        private readonly BiblioTrackv1Context _context;

        public PaymentRepo(BiblioTrackv1Context context)
        {
            _context = context;
        }

        public async Task<(string Email, string FullName)?> GetPatronContactInfo(int memberRecordID)
        {
            var query = _context.LibraryMembers
                .Where(m => m.MemberRecordId == memberRecordID)
                .Select(m => new { m.PersonRecord.Email, FullName = m.PersonRecord.FirstName + " " + m.PersonRecord.LastName });

            var result = await query.FirstOrDefaultAsync();
            return result == null ? null : (result.Email, result.FullName);
        }

        public async Task<(int PaymentRecordId, int StripePaymentRecordId)> FinalizePayment(
            int libraryCardRecordID,
            int fineRecordID,
            string paymentIntentId)
        {
            using var transaction = await _context.Database.BeginTransactionAsync();

            try
            {
                var payment = new Payment
                {
                    LibraryCardRecordId = libraryCardRecordID,
                    PaymentMethod = (byte)EnPaymentMethod.Card,
                    PaymentStatus = (byte)EnPaymentStatus.Paid,
                    DatePaied = DateOnly.FromDateTime(DateTime.UtcNow)
                };

                _context.Payments.Add(payment);
                await _context.SaveChangesAsync(); // must save now — PaymentId is an identity column,
                                                   // only populated by the DB after this insert, and
                                                   // both rows below need it as a foreign key.

                var stripePayment = new StripePayment
                {
                    PaymentIntentId = paymentIntentId,
                    LibraryPaymentRecordId = payment.PaymentId,
                    DateCreated = DateTime.UtcNow
                };
                _context.StripePayments.Add(stripePayment);

                var fine = await _context.Fines.FindAsync(fineRecordID);
                fine!.PaymentId = payment.PaymentId;

                await _context.SaveChangesAsync();
                
                await transaction.CommitAsync();

                return (payment.PaymentId, stripePayment.StripePaymentRecordId);
            }
            catch
            {
                await transaction.RollbackAsync();
                throw;
            }
        }
    }
}