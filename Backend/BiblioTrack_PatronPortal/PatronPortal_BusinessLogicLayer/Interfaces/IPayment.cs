
using PatronPortal_BusinessLogicLayer.DTOs;

namespace PatronPortal_BusinessLogicLayer.Interfaces
{

    public interface IPayment
    {
        Task<Dictionary<string, string>?> GetOrCreateStripeCustomer(int memberRecordID);
        Task<PaymentIntentDTO> CreatePaymentIntent(string stripeCustomerId, decimal amountDue);
        Task<FinalizePaymentResultDTO> FinalizePayment(int memberRecordID, int fineRecordID, string paymentIntentId);
    }

}