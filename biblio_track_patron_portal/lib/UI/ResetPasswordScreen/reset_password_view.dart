import 'package:biblio_track_patron_portal/UI/Theme/app_colors.dart';
import 'package:biblio_track_patron_portal/UI/Theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:biblio_track_patron_portal/UI/ResetPasswordScreen/reset_password_view_model.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordView extends StatefulWidget 

{
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> 
{

  
   final _formKey = GlobalKey<FormState>();
   

 

   late ResetPasswordViewModel resetPasswordViewModel;


  // Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  

  @override
  void initState()
   {
    
    super.initState();

    
    resetPasswordViewModel=context.read<ResetPasswordViewModel>();
    

   
  }

  @override
  Widget build(BuildContext context) 

   
  {


    return Scaffold(
      appBar: AppBar(title: const Text('Reset Password')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w,vertical:16.h),
          child: Column(
            children: [
               Text(
                'Enter the email associated with your account and tap the search icon. '
                'If an account is found,a check mark will appear then enter a new password and confirm it.',
                style: AppTextStyles.body,
              ),
               SizedBox(height: 20.h),

              Row(children: [
              Expanded(flex: 12,
                child: TextFormField(controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration:  InputDecoration(
                    labelText: 'Email',
                    hintText: 'you@example.com',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(onPressed:_findMemberByEmail, icon: Icon(Icons.search))
                  ),
                 ),
              )
               ,Consumer<ResetPasswordViewModel>(builder: (context,resetpasswordVM,child) 
               {
                return
                Expanded(flex: 1, child:resetpasswordVM.userAccountIsFound? Icon(Icons.check,color:AppColors.success,):Icon(Icons.block,color: AppColors.error,));
                } 
                ), 
              ]),
              SizedBox(height: 4.h),
                Consumer<ResetPasswordViewModel>(builder: (context, resetpasswordVM, child)
                {
                  if (!resetpasswordVM.userAccountIsFound && resetpasswordVM.errorMessageFromResponse != null)
                  {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Text(resetpasswordVM.errorMessageFromResponse ?? 'No account found for that email.', style: AppTextStyles.errorMessage),
                    );
                  }
                  return const SizedBox.shrink();
                }),
               SizedBox(height: 12.h),

              
             
             Form( key: _formKey,  child: Consumer<ResetPasswordViewModel>(builder: (context,resetVm,childe)
             {
              return
              Column(children: [
              TextFormField(controller: _newPassController,
                obscureText: resetVm.hidePassword,
                decoration: InputDecoration(
                  labelText: 'New password',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(onPressed:()=>resetVm.changePasswordHideStatus(!resetVm.hidePassword)
                 
                       , icon:resetVm.hidePassword?   Icon(Icons.visibility):Icon(Icons.visibility_off))
                ),
             
              ),
              SizedBox(height: 12.h),

              
              TextFormField(controller: _confirmPassController,onEditingComplete:_validatePasswordsMatching,
                obscureText: resetVm.hidePassword,
                decoration:  InputDecoration(
                  labelText: 'Confirm password',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(onPressed:()=>resetVm.changePasswordHideStatus(!resetVm.hidePassword)
                 
                  , icon:resetVm.hidePassword? Icon(Icons.visibility):Icon(Icons.visibility_off))
                ),
              validator:(val)=> _validateConfirmedNewPassword(val))
              
             ]);})
             ),
               SizedBox(height: 50.h),

             
              SizedBox(
                width: double.infinity,
                child:Consumer<ResetPasswordViewModel>(builder: (context,resetPasswordVM,child)
                {
                  return 

                   ElevatedButton(
                  onPressed:resetPasswordVM.updateIsAllowed?_updateRecord:null, 
                  child:  Text('Update password',style: AppTextStyles.button),
                );
                })
              ),SizedBox(height:10.h),

              SizedBox(width:double.infinity, child: ElevatedButton(onPressed:()=> context.go('/'), child: Text('Back To Login Screen',style: AppTextStyles.button)))
             
              
            ],
          ),
        ),
      ),
    );
  }


void  _findMemberByEmail() async
{
 
  

 await resetPasswordViewModel.findPatronByEmail(_emailController.text);

 }  



//THIS WILL ATTACHED TO VALIDATOR OF THE  TextFormField(controller: _confirmPassController ..)
String? _validateConfirmedNewPassword(String? password) 
{

         
        
         if(password!=_newPassController.text )
        {
          resetPasswordViewModel.changeUpdateIsAllowedStatus(false); 
         return "Passwords dont match";

        }

        else
        {
             resetPasswordViewModel.changeUpdateIsAllowedStatus(true);
             return null;

        }

   
  }


 void _validatePasswordsMatching()
 {

  _formKey.currentState!.validate();    //CALL VALIDATOR OF ALL FORM'S CHILDREN

 }
 
 Future<void> _updateRecord() async
 {
   
     if (await resetPasswordViewModel.updatePatronPassword(_newPassController.text))
     {

       _showUserAccountCreationStatus(true,null);
   

     }
     else
     {
         
          _showUserAccountCreationStatus(false,resetPasswordViewModel.updatePatronPasswordError);

     }


  }

 

 


 






void _showUserAccountCreationStatus(bool success,String? errorMessage)
   {

              if (success) 
              {
                      ScaffoldMessenger.of(context).showSnackBar(
                       SnackBar(
                          content: Text('User account successfully updated!',style:AppTextStyles.body.copyWith(color: Colors.white)
                          )),
                        
                      );
              }
             else 
             {
                      ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(
                          content: Text(errorMessage ?? 'Unable to update password.', style: AppTextStyles.errorMessage),
                        ),
                      );
              }



   } 




}


