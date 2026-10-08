import 'package:biblio_track_patron_portal/UI/PaymentScreen/payment_view_model.dart';
import 'package:biblio_track_patron_portal/UI/Theme/app_colors.dart';
import 'package:biblio_track_patron_portal/UI/Theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart' hide Card;
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class PaymentView extends StatefulWidget 
{
  final int memberRecordID;
  final int fineRecordID;
  final double totalAmount;

  const PaymentView({
    super.key,
    required this.memberRecordID,
    required this.fineRecordID,
    required this.totalAmount,
  });

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView>
 {
  
  late PaymentViewModel model;
  @override
  void initState() 
  {
   super.initState();
   WidgetsBinding.instance.addPostFrameCallback(
    
    (_) 
    {
       model=context.read<PaymentViewModel>();
       model.getPatronFullName(widget.memberRecordID);
         
    });
   


  }
  @override
  void dispose() 
  {
   
    model.resetViewModelParameters();
     super.dispose();
  }


  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment")),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. CardField at the top
            Text("Enter Card Details", style: AppTextStyles.title),
            SizedBox(height: 8.h),
            
            // FIX: Added fixed height and disabled postal code to make room for CVC
            SizedBox(
              height: 60.h, 
              child: CardField(
                enablePostalCode: true, // Hides ZIP code to free up horizontal space
                onCardChanged: (card) 
                {
                  debugPrint(card.toString());
                },
              ),
            ),

            SizedBox(height: 20.h),

            // 2. Submit button
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: Consumer<PaymentViewModel>(builder:(context,model,child)
              {
                return 
              
              ElevatedButton(
                onPressed:model.isProcessingPayment?null:()=>_submitPayment() ,
               
                child:model.isProcessingPayment?SizedBox( height: 16.h, width: 16.w,
                              child: const CircularProgressIndicator(strokeWidth: 2,color: AppColors.primary))
                
                : Text("Submit Payment", style: AppTextStyles.button),
              );
              })
            ),

           SizedBox(height: 24.h),

           // ADDED: Payment info title
            Text("Payment Info", style: AppTextStyles.heading),

            // 3. Remaining details come after
            // ADDED: SizedBox to force the Card to stretch full width
            SizedBox(
              width: double.infinity,
              child: Card(
                margin: EdgeInsets.only(top: 12.h),
                child: Padding(
                padding: EdgeInsets.all(16.w), // Increased padding slightly for breathing room
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer<PaymentViewModel>(builder:(context,model,child)
                    {
                    return 
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("PaymentID:", style: AppTextStyles.label), Text("${model.paymentResultModel.paymentRecordID}", style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold)),
                      ],
                    ); //Vmodel
                    }),
                    
                    
                    SizedBox(height: 16.h), 
                    
                    Consumer<PaymentViewModel>(builder:(context,model,child)
                    {
                    return 
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("StripePaymentID:", style: AppTextStyles.label), Text("${model.paymentResultModel.stripePaymentRecordID}", style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold)),
                      ],
                    ); //Vmodel
                    }),
                    
                    SizedBox(height: 16.h),

                    // FIX: Changed Row to Column to place button under the name
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        Consumer<PaymentViewModel>(builder: (context,model,child)
                        {
                          return
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Patron Name:", style: AppTextStyles.label), Text(model.patronFullName, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold)),
                          ],
                        ); //loaded in initstate 
                        }),
                        // We use a little trick here to remove the default padding 
                        // from the TextButton so it aligns perfectly with the text above it.
                        TextButton(
                          onPressed: () {}, 
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text('Payment History', style: AppTextStyles.linkText), //late another screen showing that
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text("Total Amount (\$):", style: AppTextStyles.label),
                           
                            Text("${widget.totalAmount}", style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Date:", style: AppTextStyles.label),
                        
                        Text(DateTime.now().toString().split(' ')[0], style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    
                    
                  ],
                ),
              ),
            )
            ),
             SizedBox(height: 16.h),
             Text("Payment Status:", style: AppTextStyles.label),
             SizedBox(height: 8.h),
            
            Consumer<PaymentViewModel>(builder:(context,model,child)
            {
              return 
               Text(model.paymentStatusMessage, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold, color: model.paymentStatusMessage.contains("Success")?AppColors.success:AppColors.error));
                          
            })

          ],
        ),
      ),
    );
  }

  void _submitPayment()async
  {

   final PaymentViewModel model=context.read<PaymentViewModel>();
   await model.payFine(widget.memberRecordID,widget.fineRecordID,widget.totalAmount);

     if (!mounted) return;
   
    final bool success = model.finalResult;

    await showDialog(
    context: context,
    barrierDismissible: false, // force the patron to acknowledge the result
    builder: (dialogContext) => AlertDialog(
      title: Text(success ? 'Payment Successful' : 'Payment Failed', style: AppTextStyles.title),
      content: Text(
        success ? 'Your fine has been paid. Thank you!' : model.paymentStatusMessage,
        style: AppTextStyles.body,
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(dialogContext).pop(), child: const Text('OK')),
      ],
    ),
  );

   // Success: nothing left to do on this screen, so go back to the fines list
  if (success && mounted) context.pop();
  
  }



}