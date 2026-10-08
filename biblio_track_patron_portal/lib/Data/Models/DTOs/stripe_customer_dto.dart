class StripeCustomerDTO
{
  final String stripeCustomerId;
  final String? errorMessage;

  StripeCustomerDTO({
    required this.stripeCustomerId,
    this.errorMessage
  });

  static StripeCustomerDTO fromJson(Map<String, dynamic> json)
   {
    if (json['success'] == true && json['data'] != null)
    {
      return StripeCustomerDTO(
        stripeCustomerId: json['data']['stripeCustomerId'],
      );
    }
    else
    {
      return StripeCustomerDTO(
        stripeCustomerId: '',
        errorMessage: json['error'] ?? 'Unknown error');
    }
  }
}