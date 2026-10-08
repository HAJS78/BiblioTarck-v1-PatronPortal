namespace PatronPortal_BusinessLogicLayer.PaymentGateway.PaymentGatewayDTOs
{

    public class GatewayApiResponse<T>
    {
        public bool Success { get; set; }
        public T? Data { get; set; }
        public string? Error { get; set; }
        public string? Message { get; set; }
    }
}