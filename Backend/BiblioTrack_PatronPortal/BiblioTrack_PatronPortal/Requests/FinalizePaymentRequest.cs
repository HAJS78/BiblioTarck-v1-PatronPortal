
namespace BiblioTrack_PatronPortal.Requests
{
    public class FinalizePaymentRequest
    {
        public int MemberRecordID { get; set; }
        public int FineRecordID { get; set; }
        public string PaymentIntentId { get; set; } = null!;
    }
}