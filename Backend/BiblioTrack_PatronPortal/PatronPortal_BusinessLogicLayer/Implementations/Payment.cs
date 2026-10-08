
using PatronPortal_BusinessLogicLayer.DTOs;
using PatronPortal_BusinessLogicLayer.Interfaces;
using PatronPortal_BusinessLogicLayer.PaymentGateway;
using PatronPortal_DataAccessLayer.Repositories.Interfaces;

namespace PatronPortal_BusinessLogicLayer.Implementations
{
    public class Payment : IPayment
    {
        private readonly IPaymentRepo _paymentRepo;
        private readonly IFineRepo _fineRepo;
        private readonly IPaymentGatewayClient _gatewayClient;

        public Payment(IPaymentRepo paymentRepo, IFineRepo fineRepo, IPaymentGatewayClient gatewayClient)
        {
            _paymentRepo = paymentRepo;
            _fineRepo = fineRepo;
            _gatewayClient = gatewayClient;
        }

        public async Task<Dictionary<string, string>?> GetOrCreateStripeCustomer(int memberRecordID)
        {
            var contact = await _paymentRepo.GetPatronContactInfo(memberRecordID);
            if (contact == null)
                return null; // no such patron — Controller decides how to surface this

            var existingId = await _gatewayClient.GetCustomerIdByEmailAsync(contact.Value.Email);

            var stripeCustomerId = existingId
                ?? await _gatewayClient.CreateCustomerAsync(contact.Value.Email, contact.Value.FullName);

            return new Dictionary<string, string> { ["stripeCustomerId"] = stripeCustomerId };
        }

        public async Task<PaymentIntentDTO> CreatePaymentIntent(string stripeCustomerId, decimal amountDue)
        {
            long AmountInCents =(long) amountDue * 100;
            var (clientSecret, paymentIntentId) = await _gatewayClient.CreatePaymentIntentAsync(
                AmountInCents, "usd", stripeCustomerId);

            return new PaymentIntentDTO { PaymentIntentId = paymentIntentId, ClientSecret = clientSecret };
        }

        public async Task<FinalizePaymentResultDTO> FinalizePayment(int memberRecordID, int fineRecordID, string paymentIntentId)
        {

            
            var status = await _gatewayClient.GetPaymentIntentStatusAsync(paymentIntentId);
            if (status != "succeeded")
                return new FinalizePaymentResultDTO { Success = false };

            var libraryCardRecordId = await _fineRepo.GetLibraryCardRecordIdForFinePayment(fineRecordID, memberRecordID);

            if (libraryCardRecordId == null)
                return new FinalizePaymentResultDTO { Success = false };

            
            var (paymentRecordId, stripePaymentRecordId) = await _paymentRepo.FinalizePayment(
                libraryCardRecordId.Value, fineRecordID, paymentIntentId);

            return new FinalizePaymentResultDTO
            {
                Success = true,
                PaymentRecordID = paymentRecordId,
                StripePaymentRecordID = stripePaymentRecordId
            };
        }
    }
}
