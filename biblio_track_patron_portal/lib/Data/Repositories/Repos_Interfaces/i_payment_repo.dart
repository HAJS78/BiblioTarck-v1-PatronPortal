import 'package:biblio_track_patron_portal/Data/Models/DomainModels/stripe_customer_model.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/payment_intent_model.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/finalize_payment_result_model.dart';

abstract interface class IPaymentRepo
{
 Future<StripeCustomerModel> getOrCreateStripeCustomer(int memberRecordID);
 Future<PaymentIntentModel> createPaymentIntent(String stripeCustomerId,double amountDue);
 Future<FinalizePaymentResultModel> finalizePayment(int memberRecordID,int fineRecordID,String paymentIntentId);
}