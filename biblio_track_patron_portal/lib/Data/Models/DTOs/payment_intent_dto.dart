class PaymentIntentDTO
{
  final String paymentIntentId;
  final String clientSecret;
  final String? errorMessage;

  PaymentIntentDTO({
    required this.paymentIntentId,
    required this.clientSecret,
    this.errorMessage
  });

  static PaymentIntentDTO fromJson(Map<String, dynamic> json)
   {
    if (json['success'] == true && json['data'] != null)
    {
      return PaymentIntentDTO(
        paymentIntentId: json['data']['paymentIntentId'],
        clientSecret: json['data']['clientSecret'],
      );
    }
    else
    {
      return PaymentIntentDTO(
        paymentIntentId: '',
        clientSecret: '',
        errorMessage: json['error'] ?? 'Unknown error');
    }
  }
}