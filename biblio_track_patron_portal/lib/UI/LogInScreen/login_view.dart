import 'package:biblio_track_patron_portal/UI/Theme/app_colors.dart';
import 'package:biblio_track_patron_portal/UI/Theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:biblio_track_patron_portal/UI/LogInScreen/login_view_model.dart';


class LogInView extends StatefulWidget
{


const LogInView({super.key});

  @override
  State<LogInView> createState() => _LogInViewState();
}



class _LogInViewState extends State<LogInView> 
{
  
  
  final TextEditingController username=TextEditingController();

  final TextEditingController password=TextEditingController();

 

  @override
  void initState()
   {
     super.initState();
     

   }

    @override
  void dispose() 
  {
    username.dispose();
    password.dispose();
    super.dispose();
  }

@override
  Widget build(BuildContext context) 
  
  {
  

    return Scaffold(body: SafeArea(child: SingleChildScrollView(child: Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(children:[SizedBox(height:60.h),  Image.asset('assets/images/biblio_track_patron_portal.png', height: 100.h,fit: BoxFit.fill)
        ,SizedBox(height: 16.h),Text('Biblio Track',style: AppTextStyles.appLogoPrimaryText),
        Text('Patron Portal',style: AppTextStyles.appLogoSecondaryText),
        
        SizedBox(height:60.h),
            
        TextFormField(controller: username, decoration: InputDecoration(labelText: 'UserName',  hintText: 'Enter your Username',prefixIcon: const Icon(Icons.person_outline),border: const OutlineInputBorder())),
        
        SizedBox(height: 16.h),

        
        Consumer<LogInViewModel>(builder: (context,model,child)
        {
          return 
        TextFormField(controller: password, obscureText:model.obscurePassword,decoration: InputDecoration(labelText:'Password' ,  hintText: 'Enter your password',prefixIcon: const Icon(Icons.lock_outline) ,
        suffixIcon: IconButton(icon: Icon(model.obscurePassword ? Icons.visibility_off: Icons.visibility),
                        onPressed: ()=>model.setPasswordObscurity(model.obscurePassword)),
        
        border: const OutlineInputBorder()));
        }
        ),
        SizedBox(height:8.h), 
             
          Align(alignment: .centerRight, child: TextButton(onPressed:()=>_resetPassword() , child: Text('forget Password?',style: AppTextStyles.linkText))),
          
          SizedBox(height:16.h),
          
          SizedBox(width: double.infinity,height: 48.h, child: 
          
          Consumer<LogInViewModel>(builder: (context,model,child)
          {
          
          return
          ElevatedButton(onPressed:model.isLoading?null:()=>_checkLogInCredentials(username.text,password.text),   
          child: model.isLoading ? SizedBox( height: 16.h, width: 16.w,
                              child: const CircularProgressIndicator(strokeWidth: 2,color: AppColors.primary))
                 : Text('Log In',style: AppTextStyles.button));
         }
         )
         ),
          SizedBox(height:16.h),
          
          TextButton(onPressed: ()=> _signUp(), child: Text('Dont have an account? Sign Up',style: AppTextStyles.linkText))
         
        
        ]
        
        
        
        
        ),
      ),
    )))
    );


  }

  void _resetPassword()
  {
   
   context.go('/ResetPassword');
   
  }

void _signUp()
  {
   context.go('/SignUp');
   

  }

  void _checkLogInCredentials(String userName,String password) async
  {

 
 final LogInViewModel loginVModel=context.read<LogInViewModel>();

 await loginVModel.findPatronByUserNameandPassword(userName, password);

 if(mounted)
 {
 
      if (loginVModel.loggedInPatron.memberRecordID !=-1)
        { 
            
            loginVModel.restIsLoading();
            context.go('/Dashboard',extra: {'memberRecordID':loginVModel.loggedInPatron.memberRecordID ,'userName':loginVModel.loggedInPatron.userName ,'photoUrl':loginVModel.loggedInPatron.photoUrl});
            
        }
        else
        {
          
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Login Failed', style: AppTextStyles.title),
              content: Text(loginVModel.errorMessage ??'Invalid username or password.', style: AppTextStyles.body),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
          loginVModel.restIsLoading();

        }

   }

  
 
  


  }
}