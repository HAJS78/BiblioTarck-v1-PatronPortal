import 'package:biblio_track_patron_portal/Data/Models/DTOs/finalize_payment_result_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/payment_intent_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/stripe_customer_dto.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_payment_service.dart';
import 'package:dio/dio.dart';

class PaymentService implements IPaymentService
{
  Dio dio;

  PaymentService({required this.dio});

  @override
  Future<StripeCustomerDTO> getOrCreateStripeCustomer(int memberRecordID) async
  {
    final response = await dio.post('/Payment/stripe-customer/$memberRecordID');
    return StripeCustomerDTO.fromJson(response.data);
  }

  @override
  Future<PaymentIntentDTO> createPaymentIntent(String stripeCustomerId, double amountDue) async
  {
    final response = await dio.post('/Payment/payment-intent', data: {
      'stripeCustomerId': stripeCustomerId,
      'amountDue': amountDue,
    });
    return PaymentIntentDTO.fromJson(response.data);
  }

  @override
  Future<FinalizePaymentResultDTO> finalizePayment(int memberRecordID, int fineRecordID, String paymentIntentId) async
  {
    final response = await dio.post('/Payment/finalize', data: {
      'memberRecordID': memberRecordID,
      'fineRecordID': fineRecordID,
      'paymentIntentId': paymentIntentId,
    });
    return FinalizePaymentResultDTO.fromJson(response.data);
  }
}