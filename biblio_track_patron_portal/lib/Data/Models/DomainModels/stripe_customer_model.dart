class StripeCustomerModel
{
  final String stripeCustomerId;
  final String? errorMessage;

  StripeCustomerModel({
    required this.stripeCustomerId,
    this.errorMessage
  });
}