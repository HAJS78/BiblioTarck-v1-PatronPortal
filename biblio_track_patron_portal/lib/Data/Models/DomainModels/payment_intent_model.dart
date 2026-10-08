class PaymentIntentModel
{
  final String paymentIntentId;
  final String clientSecret;
  final String? errorMessage;

  PaymentIntentModel({
    required this.paymentIntentId,
    required this.clientSecret,
    this.errorMessage
  });
}