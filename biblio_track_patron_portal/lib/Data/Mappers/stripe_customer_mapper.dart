import 'package:biblio_track_patron_portal/Data/Models/DTOs/stripe_customer_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/stripe_customer_model.dart';

class StripeCustomerMapper
{
  static StripeCustomerModel fromDTO(StripeCustomerDTO dto)
  {
    return StripeCustomerModel(
      stripeCustomerId: dto.stripeCustomerId,
      errorMessage: dto.errorMessage
    );
  }
}