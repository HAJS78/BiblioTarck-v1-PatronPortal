import 'package:biblio_track_patron_portal/Data/Models/DTOs/stripe_customer_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/payment_intent_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/finalize_payment_result_dto.dart';

abstract interface class IPaymentService
{
 Future<StripeCustomerDTO> getOrCreateStripeCustomer(int memberRecordID);
 Future<PaymentIntentDTO> createPaymentIntent(String stripeCustomerId,double amountDue);
 Future<FinalizePaymentResultDTO> finalizePayment(int memberRecordID,int fineRecordID,String paymentIntentId);
}