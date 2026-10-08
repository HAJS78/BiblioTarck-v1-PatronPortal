import 'package:biblio_track_patron_portal/Data/Mappers/stripe_customer_mapper.dart';
import 'package:biblio_track_patron_portal/Data/Mappers/payment_intent_mapper.dart';
import 'package:biblio_track_patron_portal/Data/Mappers/finalize_payment_result_mapper.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/stripe_customer_model.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/payment_intent_model.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/finalize_payment_result_model.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_payment_repo.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_payment_service.dart';

class PaymentRepo implements IPaymentRepo
{

final IPaymentService service;

  PaymentRepo({required this.service});

@override
Future<StripeCustomerModel> getOrCreateStripeCustomer(int memberRecordID)async
{
  var dto = await service.getOrCreateStripeCustomer(memberRecordID);
  return StripeCustomerMapper.fromDTO(dto);
}

@override
Future<PaymentIntentModel> createPaymentIntent(String stripeCustomerId,double amountDue)async
{
  var dto = await service.createPaymentIntent(stripeCustomerId, amountDue);
  return PaymentIntentMapper.fromDTO(dto);
}

@override
Future<FinalizePaymentResultModel> finalizePayment(int memberRecordID,int fineRecordID,String paymentIntentId)async
{
  var dto = await service.finalizePayment(memberRecordID, fineRecordID, paymentIntentId);
  return FinalizePaymentResultMapper.fromDTO(dto);
}

}