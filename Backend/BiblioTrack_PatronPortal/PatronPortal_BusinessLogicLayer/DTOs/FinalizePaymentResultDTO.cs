
namespace PatronPortal_BusinessLogicLayer.DTOs
{
    public class FinalizePaymentResultDTO
    {
        public bool Success { get; set; }
        public int? PaymentRecordID { get; set; }
        public int? StripePaymentRecordID { get; set; }
    }
}