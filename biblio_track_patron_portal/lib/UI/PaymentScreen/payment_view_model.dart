import 'package:biblio_track_patron_portal/Data/Models/DomainModels/finalize_payment_result_model.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/patron_full_name_model.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/payment_intent_model.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/stripe_customer_model.dart';
//import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_patron_repo.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_payment_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_patron_profile_data_repo.dart';

class PaymentViewModel  extends ChangeNotifier
{

final IPaymentRepo paymentRepo;
final IPatronProfileDataRepo patronProfileDataRepo;

  PaymentViewModel({required this.paymentRepo,required this.patronProfileDataRepo}) ;


  String _paymentStatusMessage='Unpaid';
  String get paymentStatusMessage=>_paymentStatusMessage;
  bool _isProcessingPayment=false;
  bool get isProcessingPayment=>_isProcessingPayment;
  
  Future<void> payFine(int memberRecordID,int fineRecordID,double amountDue)async 
  {
   
   _isProcessingPayment=true;
    notifyListeners();

   //1.stripecustomer exist by email?return their cus_xxxxxxx number:create a customer/return their cus_xxx
   await getOrCreateStripeCustomer(memberRecordID);
   if(_stripeCustomerModel.errorMessage!=null)
   {
     _paymentStatusMessage=_stripeCustomerModel.errorMessage!;
     _isProcessingPayment=false;
     notifyListeners();
     return;
   }
   else
   {
    _paymentStatusMessage='Customer was found/created successfully';
     notifyListeners();

   }
   
   //2.create payment intent using cus_xxx and other required parameters 
   await createPaymentIntent(_stripeCustomerModel.stripeCustomerId,amountDue);
    if(_paymentIntentModel.errorMessage!=null)
   {
     _paymentStatusMessage=_paymentIntentModel.errorMessage!;
     _isProcessingPayment=false;
     notifyListeners();
     return;
   }
   else
   {
    _paymentStatusMessage='Payment intent was created successfully';
     notifyListeners();

   }
   
  //uncomment this part when connected to backend 
  //  // 3. Confirm the payment securely with Stripe SDK
  //  // The SDK automatically reads the entered data from the CardField widget.
    bool isConfirmed= await  _confirmPaymentWithStripe(_paymentIntentModel.clientSecret);

  //no need to execute more code since confirmation is failed 
    if(!isConfirmed)
    {
     return ;

    }
   
   //await Future.delayed(const Duration(seconds: 1)); // Mock delay simulating Stripe SDK


   //4.handle the payment result model  
      

       await getFinalizePaymentResults(
            memberRecordID, fineRecordID, _paymentIntentModel.paymentIntentId);

        if (_finalResult)
        {
          _paymentStatusMessage = 'Paid successfully';
          _isProcessingPayment=false;
          
        } 
        else 
        {
          _paymentStatusMessage = _paymentResultModel.errorMessage??'Paid, but failed to update local database.';
          _isProcessingPayment=false;
          
        }
    
       notifyListeners();
    
    

    
   
  }


//1.
  late StripeCustomerModel _stripeCustomerModel;
  StripeCustomerModel get stripeCustomerModel=>_stripeCustomerModel;

 Future<void> getOrCreateStripeCustomer(int memberRecordID)async
 {
     //this will always return success.How about failure ?put -99 for member record id to
     //test failure 
    _stripeCustomerModel=await paymentRepo.getOrCreateStripeCustomer(memberRecordID);

 }

 //2.

  late PaymentIntentModel _paymentIntentModel;
  PaymentIntentModel get paymentIntentModel=>_paymentIntentModel;
  
  Future<void> createPaymentIntent(String stripeCustomerId,double amountDue)async 
  {
       //this will always return success.How about failure ? 
      _paymentIntentModel=await paymentRepo.createPaymentIntent(stripeCustomerId,amountDue);

  }
  //3.

  Future<bool> _confirmPaymentWithStripe(String clientSecret) async
{
  try
  {
    final paymentIntent = await Stripe.instance.confirmPayment(
      paymentIntentClientSecret: clientSecret,
      data: const PaymentMethodParams.card(
        paymentMethodData: PaymentMethodData(),
      ),
    );

    if (paymentIntent.status == PaymentIntentsStatus.Succeeded)
    {
      _paymentStatusMessage = 'Payment went through Stripe, now finalizing...';
      notifyListeners();
      return true;
    }
    else
    {
      _paymentStatusMessage = 'Payment was not completed: ${paymentIntent.status}';
      notifyListeners();
      return false;
    }
  }
  on StripeException catch (e)
  {
    _paymentStatusMessage = e.error.localizedMessage ?? 'Card was declined. Please try a different card.';
    notifyListeners();
    return false;
  }
  catch (e)
  {
    _paymentStatusMessage = 'Something went wrong while processing your card.';
    notifyListeners();
    return false;
  }
}


  //4.
  late FinalizePaymentResultModel _paymentResultModel=FinalizePaymentResultModel(success: false);
  FinalizePaymentResultModel get paymentResultModel=>_paymentResultModel;
   bool _finalResult=false;
   bool get finalResult=>_finalResult;

  Future<void> getFinalizePaymentResults(int memberRecordID,int fineRecordID,String paymentIntentId)async 
  {
    //this will always return success.How about failure ? 
    _paymentResultModel=await  paymentRepo.finalizePayment(memberRecordID,fineRecordID,paymentIntentId);
    _finalResult=_paymentResultModel.success;
    
  }



  String _patronFullName='';
String get patronFullName=>_patronFullName;

Future<void> getPatronFullName(int memberRecordID)async
{

  
  if(_patronFullName =='')
  {
  PatronFullNameModel model  =await patronProfileDataRepo.getPatronFullName(memberRecordID);
  _patronFullName=model.patronFullName;
    
  notifyListeners();
  }

}

void resetViewModelParameters()
{
 _paymentStatusMessage='Unpaid';
 _paymentResultModel=FinalizePaymentResultModel(success: false);
 _isProcessingPayment=false;
 _finalResult=false;
    
}


}


// Notes on the two catch branches, since they're doing different jobs:

//1.on StripeException — this is what the SDK throws specifically for card-level failures 
//(declined, incorrect CVC, expired card, insufficient funds, etc.)
//e.error.localizedMessage is Stripe's own human-readable explanation, already written for end users — worth showing directly rather than a generic message, since it tells the patron why ("Your card was declined") rather than just that something failed.

//2.plain catch (e) — a safety net for anything else 
//(network drop mid-call, malformed clientSecret, etc.) 
//that isn't a StripeException specifically. 
//Generic message here since these aren't card-decline reasons the patron needs specifics on.

