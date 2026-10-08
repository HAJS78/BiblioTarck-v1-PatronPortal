
namespace PatronPortal_DataAccessLayer.Repositories.Interfaces;

public interface IPaymentRepo
{
    Task<(string Email, string FullName)?> GetPatronContactInfo(int memberRecordID);

    Task<(int PaymentRecordId, int StripePaymentRecordId)> FinalizePayment(
        int libraryCardRecordID,
        int fineRecordID,
        string paymentIntentId);
}