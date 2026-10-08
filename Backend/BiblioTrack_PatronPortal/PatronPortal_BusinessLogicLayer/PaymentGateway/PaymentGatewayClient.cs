
using System.Net;
using System.Net.Http.Json;
using PatronPortal_BusinessLogicLayer.PaymentGateway.PaymentGatewayDTOs;

namespace PatronPortal_BusinessLogicLayer.PaymentGateway
{
    public class PaymentGatewayClient : IPaymentGatewayClient
    {
        private readonly HttpClient _httpClient;

        public PaymentGatewayClient(HttpClient httpClient)
        {
            _httpClient = httpClient; // BaseAddress set in DI registration
        }

        public async Task<string?> GetCustomerIdByEmailAsync(string email)
        {
            var response = await _httpClient.GetAsync($"api/Customers/Email?Email={Uri.EscapeDataString(email)}");

            if (response.StatusCode == HttpStatusCode.NotFound)
                return null; // no Stripe customer yet — expected, not an error

            response.EnsureSuccessStatusCode();

            var envelope = await response.Content.ReadFromJsonAsync<GatewayApiResponse<CustomerLookupResult>>();
            return envelope?.Data?.StripeCustomerId;
        }

        public async Task<string> CreateCustomerAsync(string email, string fullName)
        {
            var response = await _httpClient.PostAsJsonAsync("api/Customers", new
            {
                Email = email,
                Name = fullName,
                CreatedAt = DateTime.UtcNow
            });
            response.EnsureSuccessStatusCode();  // throw expcetion

            var envelope = await response.Content.ReadFromJsonAsync<GatewayApiResponse<string>>();
            return envelope!.Data!; // CreateCustomer's Data is the raw stripeCustomerId string
        }

        public async Task<(string ClientSecret, string PaymentIntentId)> CreatePaymentIntentAsync(
            long amount, string currency, string stripeCustomerId)
        {
            var response = await _httpClient.PostAsJsonAsync("api/Payments", new
            {
                Amount = amount,
                Currency = currency,
                StripeCustomerId = stripeCustomerId
            });
            response.EnsureSuccessStatusCode();   // throw expcetion

            var envelope = await response.Content.ReadFromJsonAsync<GatewayApiResponse<CreatePaymentIntentResult>>();
            return (envelope!.Data!.ClientSecret, envelope!.Data!.PaymentIntentId);
        }



        public async Task<string?> GetPaymentIntentStatusAsync(string paymentIntentId)
        {
            //var response = await _httpClient.GetAsync($"api/Payments/gateway/{paymentIntentId}");

            var response = await _httpClient.GetAsync($"api/Payments/stripe/{paymentIntentId}");

            if (response.StatusCode == HttpStatusCode.NotFound)
                return null; // gateway has no record of this intent at all

            response.EnsureSuccessStatusCode();

            var envelope = await response.Content.ReadFromJsonAsync<GatewayApiResponse<PaymentIntentStatusResult>>();
            return envelope?.Data?.Status;
        }




    }

  
   

   
}
