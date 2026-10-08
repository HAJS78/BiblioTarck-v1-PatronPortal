namespace PatronPortal_BusinessLogicLayer.PaymentGateway
{

    public interface IPaymentGatewayClient
    {
        Task<string?> GetCustomerIdByEmailAsync(string email);
        Task<string> CreateCustomerAsync(string email, string fullName);
        Task<(string ClientSecret, string PaymentIntentId)> CreatePaymentIntentAsync(
            long amount, string currency, string stripeCustomerId);

        Task<string?> GetPaymentIntentStatusAsync(string paymentIntentId);
    }

}
