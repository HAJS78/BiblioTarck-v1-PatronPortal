

namespace BiblioTrack_PatronPortal.Requests
{
    public class CreatePaymentIntentRequest
    {
        public string StripeCustomerId { get; set; } = null!;
        public decimal AmountDue { get; set; }
    }
}
