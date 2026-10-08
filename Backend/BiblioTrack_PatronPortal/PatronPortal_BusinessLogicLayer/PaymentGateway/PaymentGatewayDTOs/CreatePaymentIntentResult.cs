using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PatronPortal_BusinessLogicLayer.PaymentGateway.PaymentGatewayDTOs
{
    public class CreatePaymentIntentResult
    {
        public string ClientSecret { get; set; } = null!;
        public string PaymentIntentId { get; set; } = null!;
    }
}
