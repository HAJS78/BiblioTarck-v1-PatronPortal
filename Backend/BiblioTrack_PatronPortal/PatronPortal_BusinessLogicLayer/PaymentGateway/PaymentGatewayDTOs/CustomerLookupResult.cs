using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PatronPortal_BusinessLogicLayer.PaymentGateway.PaymentGatewayDTOs
{
    public class CustomerLookupResult
    {
        public string StripeCustomerId { get; set; } = null!;
    }

}
