import 'package:biblio_track_patron_portal/UI/Theme/app_colors.dart';
import 'package:biblio_track_patron_portal/UI/Theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:biblio_track_patron_portal/UI/SignUpScreen/signup_view_model.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';







class SignUpView extends StatefulWidget 
{
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> 
{



  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _libraryCardController = TextEditingController();
 

 
 
 
  final _formKey = GlobalKey<FormState>();
  late SignUpViewModel signUpViewModel;
  

  @override
  void initState() 
  {
    
    super.initState();
    signUpViewModel=context.read<SignUpViewModel>();
    


  }

  @override
  void dispose()
  {
    _usernameController.dispose();
    _passwordController.dispose();
    _libraryCardController.dispose();
    signUpViewModel.resetPatronAccountIsFound();
    super.dispose();
  }
  
  


  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(title:const Text("Signup")),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical:16.h),
        child:Form(key: _formKey ,child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ Text(
                'Enter your 12 digits library card number and tap the search icon. '
                'If an account is found,a check mark will appear.Then enter a username and password.',
                style:  AppTextStyles.body,
              ),
               SizedBox(height: 20.h),

              Row(children: [
              Expanded(flex: 12,
                child: TextFormField(controller: _libraryCardController,
                    decoration:  InputDecoration(
                    labelText: 'Library Card Number',
                     border: OutlineInputBorder(),
                    suffixIcon: IconButton(onPressed:_findPatronByLibraryCardNumber, icon: Icon(Icons.search))
                  ),
                 ),
              ),Consumer<SignUpViewModel>(builder: (context,model,child) 
               {
                return
                Expanded(flex: 1, child:model.patronAccountIsFound? Icon(Icons.check,color:AppColors.success):Icon(Icons.block,color: AppColors.error,));
                } 
                ), 
              ]),
              
              SizedBox(height: 4.h),
                Consumer<SignUpViewModel>(builder: (context, model, child)
                {
                  if (!model.patronAccountIsFound && model.errorMessageForPatronLookupByLibraryCardResponse != null)
                  {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Text(model.errorMessageForPatronLookupByLibraryCardResponse ?? 'Library card not found.', style: AppTextStyles.errorMessage),
                    );
                  }
                  return const SizedBox.shrink();
                }),
                
                SizedBox(height: 20.h),
                                          
              
            Consumer<SignUpViewModel>(builder: (context,signUpVM,child)
            {
              return
            TextFormField(onEditingComplete:()=> _checkUserNameAvailability(),
                controller: _usernameController,
                decoration:signUpVM.userNameIsTakenErrorMessage!="None"? InputDecoration(errorText:signUpVM.userNameIsTakenErrorMessage,  labelText: "Username",prefixIcon: const Icon(Icons.person_outline),border: const OutlineInputBorder()):InputDecoration(labelText: "Username",hintText: 'Enter a Username',prefixIcon: const Icon(Icons.person_outline),border: const OutlineInputBorder()),validator: (value)=>userNameValidator(value) 
                          );
               } ),

               SizedBox(height: 10.h),
                                  
           
            TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: "Password",hintText: 'Enter a password',prefixIcon: const Icon(Icons.lock_outline),border: const OutlineInputBorder()),
                obscureText: false,
                 validator: (value) =>passwordValidator(value)
                   ),

            SizedBox(height: 30.h),
           
            
              
                SizedBox(width: double.infinity,
                  child: Consumer<SignUpViewModel>(builder:(context,model,child) 
                  {
                    return
                  
                  ElevatedButton(
                    onPressed:model.patronAccountIsFound? _signup:null,
                    child: Text("Sign Up",style: AppTextStyles.button),
                  );
                  }
                  )
                ),
              
            SizedBox(height: 10.h),
            
           SizedBox(width: double.infinity, child: ElevatedButton(onPressed: ()=>context.go('/'), child: Text('Back To Login Screen', style: AppTextStyles.button))),
              
            
          ],
        ),
      ),
    )
    );
  }


void _findPatronByLibraryCardNumber()async
{

 
 await signUpViewModel.findPatronByLibraryCardNumber(_libraryCardController.text);

}
 
 String?  userNameValidator(String? value)
  {

     if(value == null || value.isEmpty)
     {

     return 'Username required' ;
              
     }


     return null;
              

  }
   
   String? passwordValidator(String? value)
   {
     if(value == null || value.isEmpty)
     {

     return 'Password required' ;
              
     }


     return null;
  
   }

  
  void _checkUserNameAvailability() async
  {

     await  signUpViewModel.isUserNameTaken(_usernameController.text);
    

  }


  void _signup() async
   {

    
    
    if(_formKey.currentState!.validate())
    {
      await signUpViewModel.updatePatronAccount(_usernameController.text,_passwordController.text);
    
      if (signUpViewModel.isSignedupStatus)
      {        
         _showUserAccountCreationStatus(true,null)  ; 
      }
      else
      {
         _showUserAccountCreationStatus(false,signUpViewModel.signupErroMsg)  ;

      }

           
     }
   }


   void _showUserAccountCreationStatus(bool success,String? errorMessage)
   {

              if (success) 
              {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('User online account successfully updated!', style: AppTextStyles.body.copyWith(color: Colors.white)),
                        ),
                      );
                    }
                     else 
                     {
                      ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(
                          content: Text(errorMessage ?? 'Unable to complete sign up.', style: AppTextStyles.errorMessage),
                        ),
                      );
              }



   } 



}
