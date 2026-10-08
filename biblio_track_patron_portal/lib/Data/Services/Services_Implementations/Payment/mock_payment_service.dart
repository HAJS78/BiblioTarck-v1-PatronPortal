import 'package:biblio_track_patron_portal/Data/Models/DTOs/stripe_customer_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/payment_intent_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/finalize_payment_result_dto.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_payment_service.dart';

class MockPaymentService implements IPaymentService
{

@override
Future<StripeCustomerDTO> getOrCreateStripeCustomer(int memberRecordID)async
{
  await Future.delayed(const Duration(seconds: 1));

  Map<String,dynamic> response;

  if(memberRecordID == -99)
  {
    response =
    {
      "data": null,
      "error": "Unable to reach payment provider. Please try again.",
      "success": false,
    };
  }
  else
  {
    response =
    {
      "data": { "stripeCustomerId": "cus_MockCustomer123" },
      "error": null,
      "success": true,
    };
  }

  return StripeCustomerDTO.fromJson(response);
}

@override
Future<PaymentIntentDTO> createPaymentIntent(String stripeCustomerId,double amountDue)async
{
  await Future.delayed(const Duration(seconds: 1));

  Map<String,dynamic> response=
  {
    "data":
    {
      "paymentIntentId": "pi_MockIntent123",
      "clientSecret": "pi_MockIntent123_secret_mockToken"
    },
    "error": null,
    "success": true,
  };

  return PaymentIntentDTO.fromJson(response);
}

@override
Future<FinalizePaymentResultDTO> finalizePayment(int memberRecordID,int fineRecordID,String paymentIntentId)async
{
  await Future.delayed(const Duration(seconds: 1));

  Map<String,dynamic> response=
  {
    "data":
    {
      "success": true,
      "paymentRecordID": 9,
      "stripePaymentRecordID": 4,
      "errorMessage": null
    },
    "error": null,
    "success": true,
  };

  return FinalizePaymentResultDTO.fromJson(response);
}

}