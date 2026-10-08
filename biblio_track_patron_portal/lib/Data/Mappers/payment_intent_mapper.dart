import 'package:biblio_track_patron_portal/Data/Models/DTOs/payment_intent_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/payment_intent_model.dart';

class PaymentIntentMapper
{
  static PaymentIntentModel fromDTO(PaymentIntentDTO dto)
  {
    return PaymentIntentModel(
      paymentIntentId: dto.paymentIntentId,
      clientSecret: dto.clientSecret,
      errorMessage: dto.errorMessage
    );
  }
}