
import 'package:biblio_track_patron_portal/UI/BookDetailsScreen/book_details_view.dart';
import 'package:biblio_track_patron_portal/UI/CatalogSearch/catalog_view.dart';
import 'package:biblio_track_patron_portal/UI/DashboardScreen/dashboard_view.dart';
import 'package:biblio_track_patron_portal/UI/FavoritesScreen/favorites_view.dart';
import 'package:biblio_track_patron_portal/UI/FinesScreen/fines_view.dart';
import 'package:biblio_track_patron_portal/UI/NotificationScreen/member_notifications_view.dart';
import 'package:biblio_track_patron_portal/UI/PaymentScreen/payment_view.dart';
import 'package:biblio_track_patron_portal/UI/ReservationScreen/reservation_view.dart';
import 'package:biblio_track_patron_portal/UI/ResetPasswordScreen/reset_password_view.dart';
import 'package:biblio_track_patron_portal/UI/SignUpScreen/signup_view.dart';
import 'package:go_router/go_router.dart';
import 'package:biblio_track_patron_portal/UI/LogInScreen/login_view.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: <GoRoute>[

    // Login
    GoRoute(
      path: '/',
      builder: (context, state) => const LogInView(),
    ),

    GoRoute(path: '/Dashboard',builder: (context, state)  
    {
         final extras=state.extra as Map<String,dynamic>;
                  final memberRecordID=extras['memberRecordID'] as int;
                  final userName=extras['userName'] as String;
                  final photoUrl=extras['photoUrl'] as String?;
                  return DashboardView(memberRecordID:memberRecordID,userName:userName,photoUrl:photoUrl);



    }
    
    
    ),
    GoRoute(path: '/ResetPassword', builder: (context, state) => ResetPasswordView()),
    GoRoute(path: '/SignUp', builder: (context, state) => SignUpView()),
    GoRoute(path: '/Favorites',builder: (context, state)  
    {
         final  member=state.extra as Map<String,dynamic> ;
                 
                  final memberRecordID=member['memberRecordID'] as int;
                  final userName=member['userName'] as String;
                  return FavoritesView(memberRecordID:memberRecordID,userName: userName,);



    }
    
    
    ),
    GoRoute(path: '/Notifications',builder: (context, state)  
    {
         final  member=state.extra as Map<String,dynamic> ;
                 
                  final memberRecordID=member['memberRecordID'] as int;
                 
                  return MemberNotificationView(memberRecordID:memberRecordID);



    }
    ),
    GoRoute(path: '/CatalogSearch',builder: (context, state)  
    {
         final  member=state.extra as Map<String,dynamic> ;
                 
                  final memberRecordID=member['memberRecordID'] as int;
                 
                  return CatalogView(memberRecordID:memberRecordID);



    }
    ),

    GoRoute(path: '/Reservation',builder: (context, state)  
    {
         final  book=state.extra as Map<String,dynamic> ;
                 
                  final bookRecordID=book['bookRecordID'] as int;
                  final title=book['title'] as String;
                  return ReservationView(bookRecordID: bookRecordID, title: title);



    }),

    GoRoute(path: '/BookDetails',builder: (context, state)  
    {
         final  data=state.extra as Map<String,dynamic> ;
                 
                  final memberRecordID=data['memberRecordID'] as int;
                  final bookRecordID=data['bookRecordID'] as int;
                  
                 return BookDetailsView(bookRecordID: bookRecordID, memberRecordID: memberRecordID);



    }),
    GoRoute(path: '/Fines',builder: (context, state)  
    {
         final  member=state.extra as Map<String,dynamic> ;
                 
                  final memberRecordID=member['memberRecordID'] as int;
                 
                  return FinesView(memberRecordID:memberRecordID);



    }
    ),
    GoRoute(path: '/Pay',builder: (context, state)  
    {
         final  data=state.extra as Map<String,dynamic> ;
                 
                  final memberRecordID=data['memberRecordID'] as int;
                 final fineRecordID=data['fineRecordID'] as int;
                 final amountDue=data['amountDue'] as double; 
                  return PaymentView(memberRecordID: memberRecordID, fineRecordID: fineRecordID, totalAmount: amountDue);



    }
    ),
    

    

  ],
);