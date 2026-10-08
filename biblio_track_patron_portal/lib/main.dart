
import 'package:biblio_track_patron_portal/Data/Network/dio_client.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Implementation/book_reservation_repo.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Implementation/book_search_repo.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Implementation/notification_summary_repo.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Implementation/password_recovery_repo.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Implementation/auth_repo.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Implementation/fine_repo.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Implementation/library_card_repo.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Implementation/patron_favorites_management_repo.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Implementation/patron_favorites_query_repo.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Implementation/patron_notifications_repo.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Implementation/patron_profile_data_repo.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Implementation/patron_recommendation_repo.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Implementation/patron_registeration_repo.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Implementation/payment_repo.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_book_reservation_repo.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_book_search_repo.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_notification_summary_repo.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_password_recovery_repo.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_auth_repo.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_book_repo.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_fine_repo.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_library_card_repo.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_patron_favorites_management_repo.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_patron_favorites_query_repo.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_patron_notifications_repo.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_patron_profile_data_repo.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Implementation/book_repo.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_patron_recommendation_repo.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_patron_registeration_repo.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_payment_repo.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Implementations/Account_Management/password_recovery_service.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Implementations/Authentication/authentication_service.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Implementations/Book/book_service.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Implementations/BookSearch/book_search_service.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Implementations/Book_Reservation/book_reservation_service.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Implementations/Fine/fine_service.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Implementations/LibraryCardNumber/library_card_service.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Implementations/Notifications/notification_summary_service.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Implementations/Notifications/patron_notifications_service.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Implementations/Patron/mock_patron_profile_data_service.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Implementations/Patron/patron_recommendation_service.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Implementations/PatronRegisteration/patron_registeration_service.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Implementations/Payment/payment_service.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Implementations/favorites/patron_favorites_management_service.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Implementations/favorites/patron_favorites_query_service.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_book_reservation_service.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_book_search_service.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_notification_summary_service.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_password_recovery_service.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_auth_service.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_fine_service.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_library_card_service.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_patron_favorites_management_service.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_patron_favorites_query_service.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_patron_notifications_service.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_patron_profile_data_service.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_book_service.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_patron_recommendation_service.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_patron_registeration_service.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_payment_service.dart';
import 'package:biblio_track_patron_portal/UI/BookDetailsScreen/book_details_view_model.dart';
import 'package:biblio_track_patron_portal/UI/CatalogSearch/catalog_view_model.dart';
import 'package:biblio_track_patron_portal/UI/DashboardScreen/dashboard_view_model.dart';
import 'package:biblio_track_patron_portal/UI/FavoritesScreen/favorite_view_model.dart';
import 'package:biblio_track_patron_portal/UI/FinesScreen/fines_view_model.dart';
import 'package:biblio_track_patron_portal/UI/LogInScreen/login_view_model.dart';
import 'package:biblio_track_patron_portal/UI/NotificationScreen/member_notifications_view_model.dart';
import 'package:biblio_track_patron_portal/UI/PaymentScreen/payment_view_model.dart';
import 'package:biblio_track_patron_portal/UI/ReservationScreen/reservation_view_model.dart';
import 'package:biblio_track_patron_portal/UI/ResetPasswordScreen/reset_password_view_model.dart';
import 'package:biblio_track_patron_portal/UI/Router/app_router.dart';
import 'package:biblio_track_patron_portal/UI/SignUpScreen/signup_view_model.dart';
import 'package:biblio_track_patron_portal/UI/Theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async 
 {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = "pk_test_xxxxxxxxxxxx"; 
  await Stripe.instance.applySettings();

  runApp(
    MultiProvider(
      providers: [
        // Services
        
           
        //1
        Provider<IAuthService>(
          create: (_) => AuthenticationService(dio: DioClient.instance)),
        //2
        Provider<IPasswordRecoveryService>(
          create: (_) => PasswordRecoveryService(dio: DioClient.instance)), 
        //3
        Provider<IPatronProfileDataService>(
          create: (_) => MockPatronProfileDataService()),
       //4
        Provider<IPatronRegisterationService>(
          create: (_) => PatronRegisterationService(dio: DioClient.instance)),

      //5
       Provider<IPatronRecommendationsService>(
          create: (_) => PatronRecommendationService(dio: DioClient.instance)),

      //6     
        Provider<INotificationSummaryService>(
          create: (_) => NotificationSummaryService(dio: DioClient.instance)),   
       
       
           Provider<IBookService>(
             create: (_) => BookService(dio: DioClient.instance)),
         
         //7

           Provider<IBookSearchService>(
             create: (_) => BookSearchService(dio: DioClient.instance)),
         
        //8 
          Provider<IPatronFavoritesManagementService>(
             create: (_) => PatronFavoritesManagementService(dio: DioClient.instance)),


        //9

           Provider<IPatronFavoritesQueryService>(
             create: (_) =>  PatronFavoritesQueryService(dio: DioClient.instance)),


       //10
          Provider<IPatronNotificationsService>(
             create: (_) => PatronNotificationsService(dio: DioClient.instance)),

      //11
          Provider<IBookReservationService>(
             create: (_) => BookReservationService(dio: DioClient.instance)),
       

           Provider<ILibraryCardService>(
               create: (_) => LibraryCardService(dio: DioClient.instance)),
          Provider<IFineService>(
               create: (_) => FineService(dio: DioClient.instance)),
          Provider<IPaymentService>(
               create: (_) => PaymentService(dio: DioClient.instance)),

        // Repositories
        
        
      //1
       Provider<IAuthRepo>(create: (context) =>AuthRepo(service:  context.read<IAuthService>())),
      //2 
       Provider<IPasswordRecoveryRepo>(create: (context) => PasswordRecoveryRepo(service: context.read<IPasswordRecoveryService>())),
      
      //3

       Provider<IPatronProfileDataRepo>(create: (context) =>PatronProfileDataRepo(service: context.read<IPatronProfileDataService>())),
       
       //4
       Provider<IPatronRegisterationRepo>(create: (context) =>PatronRegisterationRepo(service: context.read<IPatronRegisterationService>())),
       
      //5     
         Provider<IPatronRecommendationRepo>(create: (context) =>PatronRecommendationRepo(service: context.read<IPatronRecommendationsService>())),
     
     //6
         Provider<INotificationSummaryRepo>(create: (context) =>NotificationSummaryRepo(service: context.read<INotificationSummaryService>())),


        Provider<IBookRepo>(
          create: (context) => BookRepo(
            service: context.read<IBookService>())), 

    //7

     Provider<IBookSearchRepo>(
          create: (context) => BookSearchRepo(
            service: context.read<IBookSearchService>())), 
  //8

    Provider<IPatronFavoritesManagementRepo>(
          create: (context) =>PatronFavoritesManagementRepo(
            service: context.read<IPatronFavoritesManagementService>())), 

 //9

    Provider<IPatronFavoritesQueryRepo>(
          create: (context) => PatronFavoritesQueryRepo(
            service: context.read<IPatronFavoritesQueryService>())), 
//10

Provider<IPatronNotificationsRepo>(
          create: (context) => PatronNotificationsRepo(
            service: context.read<IPatronNotificationsService>())),

    //11 
            
Provider<IBookReservationRepo>(
          create: (context) => BookReservationRepo(
            service: context.read<IBookReservationService>())),

        Provider<ILibraryCardRepo>(
          create: (context) => LibraryCardRepo(
            service: context.read<ILibraryCardService>())), 

        Provider<IFineRepo>(
          create: (context) => FineRepo(
            service: context.read<IFineService>())), 

            Provider<IPaymentRepo>(
          create: (context) =>PaymentRepo(
            service: context.read<IPaymentService>())),                         

        // ViewModels
        ChangeNotifierProvider(
          create: (context) => LogInViewModel(
            authRepo: context.read<IAuthRepo>())),

        ChangeNotifierProvider(
          create: (context) => ResetPasswordViewModel(
            recoveryRepo: context.read<IPasswordRecoveryRepo>())),

        ChangeNotifierProvider(
          create: (context) => SignUpViewModel( registerationRepo: context.read<IPatronRegisterationRepo>(),
            )),

         ChangeNotifierProvider(
          create: (context) => DashboardViewModel( patronRecommendationRepo: context.read<IPatronRecommendationRepo>()
           , notificationSummaryRepo: context.read<INotificationSummaryRepo>() ,bookSearchRepo:context.read<IBookSearchRepo>(),patronFavoritesManagementRepo:context.read<IPatronFavoritesManagementRepo>())),    
          
          ChangeNotifierProvider(
          create: (context) => FavoritesViewModel(
           patronFavoritesManagementRepo:context.read<IPatronFavoritesManagementRepo>(),patronFavoritesQueryRepo: context.read<IPatronFavoritesQueryRepo>())),    
          
            ChangeNotifierProvider(
          create: (context) => MemberNotificationViewModel(
            notificationsRepo:context.read<IPatronNotificationsRepo>())),    
          
              ChangeNotifierProvider(
          create: (context) => CatalogViewModel(
            bookSearchRepo:context.read<IBookSearchRepo>(),patronFavoritesManagementRepo: context.read<IPatronFavoritesManagementRepo>())), 

             ChangeNotifierProvider(
          create: (context) => BookDetailsViewModel(
            bookRepo:context.read<IBookRepo>(),patronFavoritesManagementRepo: context.read<IPatronFavoritesManagementRepo>())),

             ChangeNotifierProvider(
          create: (context) => ReservationViewModel(
            bookReservationRepo:context.read<IBookReservationRepo>(),libraryCardRepo: context.read<ILibraryCardRepo>())),  

            ChangeNotifierProvider(
          create: (context) => FinesViewModel(
            fineRepo  : context.read<IFineRepo>())),  

            
            ChangeNotifierProvider(
          create: (context) => PaymentViewModel(
            paymentRepo  : context.read<IPaymentRepo>(),patronProfileDataRepo: context.read<IPatronProfileDataRepo>())),    
             
          

      ],
      child: const BiblioTrack(),
    ),
  );
}

class BiblioTrack extends StatelessWidget 
{
  const BiblioTrack({super.key});

  final Size designSize = const Size(360, 800);

  @override
  Widget build(BuildContext context) 
  {
    return ScreenUtilInit(
      designSize: designSize,
      minTextAdapt: true,
      builder: (context, child)
      {
        return MaterialApp.router(
          routerConfig: appRouter,
          theme: AppTheme.light,
          debugShowCheckedModeBanner: false,
          title: 'BiblioTrack Patron Portal',
        );
      },
    );
  }
}