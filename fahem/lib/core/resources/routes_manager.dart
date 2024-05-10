import 'package:fahem/data/models/account_model.dart';
import 'package:fahem/data/models/category_model.dart';
import 'package:fahem/data/models/instant_consultation_model.dart';
import 'package:fahem/data/models/job_model.dart';
import 'package:fahem/data/models/main_category_model.dart';
import 'package:fahem/data/models/service_model.dart';
import 'package:fahem/data/models/user_model.dart';
import 'package:fahem/presentation/main/controllers/main_provider.dart';
import 'package:fahem/presentation/main/screens/main_screen.dart';
import 'package:fahem/presentation/screens/about_app/controllers/edit_about_app_provider.dart';
import 'package:fahem/presentation/screens/about_app/screens/edit_about_app_screen.dart';
import 'package:fahem/presentation/screens/accounts/controllers/account_details_provider.dart';
import 'package:fahem/presentation/screens/accounts/controllers/accounts_provider.dart';
import 'package:fahem/presentation/screens/accounts/screens/account_details_screen.dart';
import 'package:fahem/presentation/screens/accounts/screens/accounts_screen.dart';
import 'package:fahem/presentation/screens/admins/controllers/admins_provider.dart';
import 'package:fahem/presentation/screens/admins/controllers/insert_edit_admin_provider.dart';
import 'package:fahem/presentation/screens/admins/screens/admin_profile_screen.dart';
import 'package:fahem/presentation/screens/admins/screens/admins_screen.dart';
import 'package:fahem/presentation/screens/admins/screens/insert_edit_admin_screen.dart';
import 'package:fahem/presentation/screens/articles/controllers/insert_edit_article_provider.dart';
import 'package:fahem/presentation/screens/articles/screens/insert_edit_article_screen.dart';
import 'package:fahem/presentation/screens/authentication/screens/login_with_phone_screen.dart';
import 'package:fahem/presentation/screens/authentication/screens/register_with_phone_screen.dart';
import 'package:fahem/presentation/screens/authentication/screens/verify_phone_otp_screen.dart';
import 'package:fahem/presentation/screens/booking_appointments/controllers/booking_appointments_provider.dart';
import 'package:fahem/presentation/screens/booking_appointments/controllers/insert_edit_booking_appointment_provider.dart';
import 'package:fahem/presentation/screens/booking_appointments/screens/booking_appointments_screen.dart';
import 'package:fahem/presentation/screens/booking_appointments/screens/insert_edit_booking_appointment_screen.dart';
import 'package:fahem/presentation/screens/categories/controllers/categories_provider.dart';
import 'package:fahem/presentation/screens/categories/screens/categories_screen.dart';
import 'package:fahem/presentation/screens/chats/screens/chat_room_screen.dart';
import 'package:fahem/presentation/screens/complaints/controllers/complaints_provider.dart';
import 'package:fahem/presentation/screens/complaints/screens/complaints_screen.dart';
import 'package:fahem/presentation/screens/employment_applications/controllers/employment_applications_provider.dart';
import 'package:fahem/presentation/screens/employment_applications/screens/employment_applications_screen.dart';
import 'package:fahem/presentation/screens/faqs/controllers/insert_edit_faq_provider.dart';
import 'package:fahem/presentation/screens/faqs/screens/insert_edit_faq_screen.dart';
import 'package:fahem/presentation/screens/features/controllers/features_provider.dart';
import 'package:fahem/presentation/screens/features/controllers/insert_edit_feature_provider.dart';
import 'package:fahem/presentation/screens/features/screens/features_screen.dart';
import 'package:fahem/presentation/screens/features/screens/insert_edit_feature_screen.dart';
import 'package:fahem/presentation/screens/financial_accounts/controllers/revenues_provider.dart';
import 'package:fahem/presentation/screens/financial_accounts/controllers/expenses_provider.dart';
import 'package:fahem/presentation/screens/financial_accounts/screens/expenses_screen.dart';
import 'package:fahem/presentation/screens/financial_accounts/screens/financial_accounts_screen.dart';
import 'package:fahem/presentation/screens/financial_accounts/screens/revenues_screen.dart';
import 'package:fahem/presentation/screens/home/controllers/home_provider.dart';
import 'package:fahem/presentation/screens/instant_consultations_comments/controllers/insert_edit_instant_consultation_comment_provider.dart';
import 'package:fahem/presentation/screens/instant_consultations_comments/controllers/instant_consultations_comments_provider.dart';
import 'package:fahem/presentation/screens/instant_consultations_comments/screens/insert_edit_instant_consultation_comment_screen.dart';
import 'package:fahem/presentation/screens/instant_consultations_comments/screens/instant_consultations_comments_screen.dart';
import 'package:fahem/presentation/screens/jobs/controllers/insert_edit_job_provider.dart';
import 'package:fahem/presentation/screens/jobs/controllers/job_apply_provider.dart';
import 'package:fahem/presentation/screens/jobs/screens/insert_edit_job_screen.dart';
import 'package:fahem/presentation/screens/jobs/controllers/jobs_provider.dart';
import 'package:fahem/presentation/screens/jobs/screens/job_apply_screen.dart';
import 'package:fahem/presentation/screens/jobs/screens/job_details_screen.dart';
import 'package:fahem/presentation/screens/jobs/screens/jobs_screen.dart';
import 'package:fahem/presentation/screens/main_categories/controllers/insert_edit_main_category_provider.dart';
import 'package:fahem/presentation/screens/main_categories/controllers/main_categories_provider.dart';
import 'package:fahem/presentation/screens/main_categories/screens/insert_edit_main_category_screen.dart';
import 'package:fahem/presentation/screens/main_categories/screens/main_categories_screen.dart';
import 'package:fahem/presentation/screens/phone_number_requests/controllers/insert_edit_phone_number_request_provider.dart';
import 'package:fahem/presentation/screens/phone_number_requests/controllers/phone_number_requests_provider.dart';
import 'package:fahem/presentation/screens/phone_number_requests/screens/insert_edit_phone_number_request_screen.dart';
import 'package:fahem/presentation/screens/phone_number_requests/screens/phone_number_requests_screen.dart';
import 'package:fahem/presentation/screens/playlists/controllers/playlist_details_provider.dart';
import 'package:fahem/presentation/screens/playlists/controllers/playlists_provider.dart';
import 'package:fahem/presentation/screens/playlists/screens/playlist_details_screen.dart';
import 'package:fahem/presentation/screens/playlists/screens/playlists_screen.dart';
import 'package:fahem/presentation/screens/playlists_comments/controllers/insert_edit_playlist_comment_provider.dart';
import 'package:fahem/presentation/screens/playlists_comments/controllers/playlists_comments_provider.dart';
import 'package:fahem/presentation/screens/playlists_comments/screens/insert_edit_playlist_comment_screen.dart';
import 'package:fahem/presentation/screens/playlists_comments/screens/playlists_comments_screen.dart';
import 'package:fahem/presentation/screens/privacy_policy/controllers/edit_privacy_policy_provider.dart';
import 'package:fahem/presentation/screens/privacy_policy/screens/edit_privacy_policy_screen.dart';
import 'package:fahem/presentation/screens/authentication/screens/change_password_screen.dart';
import 'package:fahem/presentation/screens/profile/controllers/edit_user_profile_provider.dart';
import 'package:fahem/presentation/screens/profile/screens/edit_user_profile_screen.dart';
import 'package:fahem/presentation/screens/reviews/controllers/insert_edit_review_provider.dart';
import 'package:fahem/presentation/screens/reviews/controllers/reviews_provider.dart';
import 'package:fahem/presentation/screens/reviews/screens/insert_edit_review_screen.dart';
import 'package:fahem/presentation/screens/reviews/screens/reviews_screen.dart';
import 'package:fahem/presentation/screens/search/controllers/search_provider.dart';
import 'package:fahem/presentation/screens/service_description/controllers/edit_service_description_provider.dart';
import 'package:fahem/presentation/screens/service_description/controllers/service_description_provider.dart';
import 'package:fahem/presentation/screens/service_description/screens/edit_service_description_screen.dart';
import 'package:fahem/presentation/screens/service_description/screens/service_description_screen.dart';
import 'package:fahem/presentation/screens/authentication/screens/forgot_password_screen.dart';
import 'package:fahem/presentation/screens/authentication/screens/otp_screen.dart';
import 'package:fahem/presentation/screens/authentication/screens/reset_password_screen.dart';
import 'package:fahem/presentation/screens/services/controllers/instant_consultation_form_provider.dart';
import 'package:fahem/presentation/screens/services/controllers/instant_lawyers_provider.dart';
import 'package:fahem/presentation/screens/services/controllers/secret_consultation_form_provider.dart';
import 'package:fahem/presentation/screens/services/controllers/service_provider.dart';
import 'package:fahem/presentation/screens/services/controllers/services_provider.dart';
import 'package:fahem/presentation/screens/services/screens/instant_consultation_form_screen.dart';
import 'package:fahem/presentation/screens/services/screens/instant_lawyers_screen.dart';
import 'package:fahem/presentation/screens/services/screens/secret_consultation_form_screen.dart';
import 'package:fahem/presentation/screens/services/screens/service_details_screen.dart';
import 'package:fahem/presentation/screens/services/screens/service_screen.dart';
import 'package:fahem/presentation/screens/services/screens/services_screen.dart';
import 'package:fahem/presentation/screens/settings/controllers/version_provider.dart';
import 'package:fahem/presentation/screens/settings/screens/edit_version_screen.dart';
import 'package:fahem/presentation/screens/settings/screens/settings_screen.dart';
import 'package:fahem/presentation/screens/settings/screens/version_screen.dart';
import 'package:fahem/presentation/screens/sliders/controllers/insert_edit_slider_provider.dart';
import 'package:fahem/presentation/screens/sliders/controllers/sliders_provider.dart';
import 'package:fahem/presentation/screens/sliders/screens/insert_edit_slider_screen.dart';
import 'package:fahem/presentation/screens/sliders/screens/sliders_screen.dart';
import 'package:fahem/presentation/screens/social_media/controllers/insert_edit_social_media_provider.dart';
import 'package:fahem/presentation/screens/social_media/controllers/social_media_provider.dart';
import 'package:fahem/presentation/screens/social_media/screens/insert_edit_social_media_screen.dart';
import 'package:fahem/presentation/screens/social_media/screens/social_media_screen.dart';
import 'package:fahem/presentation/screens/splash/controllers/language_provider.dart';
import 'package:fahem/presentation/screens/splash/controllers/on_boarding_provider.dart';
import 'package:fahem/presentation/screens/splash/controllers/splash_provider.dart';
import 'package:fahem/presentation/screens/splash/controllers/start_provider.dart';
import 'package:fahem/presentation/screens/splash/screens/failure_screen.dart';
import 'package:fahem/presentation/screens/splash/screens/getting_started_screen.dart';
import 'package:fahem/presentation/screens/splash/screens/language_screen.dart';
import 'package:fahem/presentation/screens/splash/screens/maintenance_screen.dart';
import 'package:fahem/presentation/screens/splash/screens/on_boarding_screen.dart';
import 'package:fahem/presentation/screens/splash/screens/splash_screen.dart';
import 'package:fahem/presentation/screens/splash/screens/start_screen.dart';
import 'package:fahem/presentation/screens/splash/screens/update_screen.dart';
import 'package:fahem/presentation/screens/suggested_messages/controllers/insert_edit_suggested_message_provider.dart';
import 'package:fahem/presentation/screens/suggested_messages/controllers/suggested_messages_provider.dart';
import 'package:fahem/presentation/screens/suggested_messages/screens/insert_edit_suggested_message_screen.dart';
import 'package:fahem/presentation/screens/suggested_messages/screens/suggested_messages_screen.dart';
import 'package:fahem/presentation/screens/transactions/controllers/transactions_provider.dart';
import 'package:fahem/presentation/screens/videos/controllers/insert_edit_video_provider.dart';
import 'package:fahem/presentation/screens/videos/controllers/videos_provider.dart';
import 'package:fahem/presentation/screens/videos/screens/insert_edit_video_screen.dart';
import 'package:fahem/presentation/screens/videos/screens/videos_screen.dart';
import 'package:fahem/presentation/screens/wallet/controllers/wallet_history_provider.dart';
import 'package:fahem/presentation/screens/withdrawal_requests/controllers/insert_edit_withdrawal_request_provider.dart';
import 'package:fahem/presentation/screens/withdrawal_requests/controllers/withdrawal_requests_provider.dart';
import 'package:fahem/presentation/screens/withdrawal_requests/screens/insert_edit_withdrawal_request_screen.dart';
import 'package:fahem/presentation/screens/withdrawal_requests/screens/withdrawal_requests_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem/core/resources/constants_manager.dart';
import 'package:fahem/core/utilities/page_transition.dart';
import 'package:fahem/presentation/screens/about_app/controllers/about_app_provider.dart';
import 'package:fahem/presentation/screens/about_app/screens/about_app_screen.dart';
import 'package:fahem/presentation/screens/articles/screens/article_details_screen.dart';
import 'package:fahem/presentation/screens/faqs/controllers/faqs_provider.dart';
import 'package:fahem/presentation/screens/faqs/screens/faqs_screen.dart';
import 'package:fahem/presentation/screens/articles/controllers/articles_provider.dart';
import 'package:fahem/presentation/screens/articles/screens/articles_screen.dart';
import 'package:fahem/presentation/screens/notifications/controllers/notifications_provider.dart';
import 'package:fahem/presentation/screens/notifications/screens/notifications_screen.dart';
import 'package:fahem/presentation/screens/privacy_policy/controllers/privacy_policy_provider.dart';
import 'package:fahem/presentation/screens/privacy_policy/screens/privacy_policy_screen.dart';
import 'package:fahem/presentation/screens/show_full_image/screens/show_full_image_screen.dart';
import 'package:fahem/presentation/screens/terms_of_use/controllers/edit_terms_of_use_provider.dart';
import 'package:fahem/presentation/screens/terms_of_use/controllers/terms_of_use_provider.dart';
import 'package:fahem/presentation/screens/terms_of_use/screens/edit_terms_of_use_screen.dart';
import 'package:fahem/presentation/screens/terms_of_use/screens/terms_of_use_screen.dart';
import 'package:fahem/presentation/screens/users/controllers/insert_edit_user_provider.dart';
import 'package:fahem/presentation/screens/users/controllers/user_profile_provider.dart';
import 'package:fahem/presentation/screens/users/controllers/users_provider.dart';
import 'package:fahem/presentation/screens/users/screens/insert_edit_user_screen.dart';
import 'package:fahem/presentation/screens/users/screens/user_profile_screen.dart';
import 'package:fahem/presentation/screens/users/screens/users_screen.dart';

class Routes {

  // region Start
  static const String startScreen = '/startScreen';
  static const String languageScreen = '/languageScreen';
  static const String gettingStartedScreen = '/gettingStartedScreen';
  static const String onBoardingScreen = '/onBoardingScreen';
  static const String updateScreen = '/updateScreen';
  static const String maintenanceScreen = '/maintenanceScreen';
  static const String failureScreen = '/failureScreen';
  static const String splashScreen = '/splashScreen';
  // endregion

  // region Authentication
  // static const String loginScreen = '/loginScreen';
  // static const String registerScreen = '/registerScreen';
  static const String registerWithPhoneScreen = '/registerWithPhoneScreen';
  static const String forgotPasswordScreen = '/forgotPasswordScreen';
  static const String otpScreen = '/otpScreen';
  static const String resetPasswordScreen = '/resetPasswordScreen';
  static const String changePasswordScreen = '/changePasswordScreen';
  static const String loginWithPhoneScreen = '/loginWithPhoneScreen';
  static const String verifyPhoneOtpScreen = '/verifyPhoneOtpScreen';
  // endregion

  // region Profile
  static const String userProfileScreen = '/userProfileScreen';
  static const String editUserProfileScreen = '/editUserProfileScreen';
  // endregion

  // region Main
  static const String mainScreen = '/mainScreen';
  // endregion

  // region Admins
  static const String adminsScreen = '/adminsScreen';
  static const String insertEditAdminScreen = '/insertEditAdminScreen';
  static const String adminProfileScreen = '/adminProfileScreen';
  // endregion

  // region Users
  static const String usersScreen = '/usersScreen';
  static const String insertEditUserScreen = '/insertEditUserScreen';
  // endregion

  // region Accounts
  static const String accountsScreen = '/accountsScreen';
  static const String insertEditAccountScreen = '/insertEditAccountScreen';
  static const String accountDetailsScreen = '/accountDetailsScreen';
  // endregion

  // region Main Categories
  static const String mainCategoriesScreen = '/mainCategoriesScreen';
  static const String insertEditMainCategoryScreen = '/insertEditMainCategoryScreen';
  // endregion

  // region Categories
  static const String categoriesScreen = '/categoriesScreen';
  // endregion

  // region Services
  static const String servicesScreen = '/servicesScreen';
  static const String serviceDetailsScreen = '/serviceDetailsScreen';
  static const String serviceScreen = '/serviceScreen';
  static const String instantLawyersScreen = '/instantLawyersScreen';
  static const String instantConsultationFormScreen = '/instantConsultationFormScreen';
  static const String secretConsultationFormScreen = '/secretConsultationFormScreen';
  // endregion

  // region Sliders
  static const String slidersScreen = '/slidersScreen';
  static const String insertEditSliderScreen = '/insertEditSliderScreen';
  // endregion

  // region Articles
  static const String articlesScreen = '/articlesScreen';
  static const String insertEditArticleScreen = '/insertEditArticleScreen';
  static const String articleDetailsScreen = '/articleDetailsScreen';
  // endregion

  // region Faqs
  static const String faqsScreen = '/faqsScreen';
  static const String insertEditFaqScreen = '/insertEditFaqScreen';
  // endregion

  // region Jobs
  static const String jobsScreen = '/jobsScreen';
  static const String insertEditJobScreen = '/insertEditJobScreen';
  static const String jobDetailsScreen = '/jobDetailsScreen';
  static const String jobApplyScreen = '/jobApplyScreen';
  // endregion

  // region Employment Applications
  static const String employmentApplicationsScreen = '/employmentApplicationsScreen';
  // endregion

  // region Complaints
  static const String complaintsScreen = '/complaintsScreen';
  // endregion

  // region Reviews
  static const String reviewsScreen = '/reviewsScreen';
  static const String insertEditReviewScreen = '/insertEditReviewScreen';
  // endregion

  // region Features
  static const String featuresScreen = '/featuresScreen';
  static const String insertEditFeatureScreen = '/insertEditFeatureScreen';
  // endregion

  // region Social Media
  static const String socialMediaScreen = '/socialMediaScreen';
  static const String insertEditSocialMediaScreen = '/insertEditSocialMediaScreen';
  // endregion

  // region Playlists
  static const String playlistsScreen = '/playlistsScreen';
  static const String insertEditPlaylistScreen = '/insertEditPlaylistScreen';
  static const String playlistDetailsScreen = '/playlistDetailsScreen';
  // endregion

  // region Videos
  static const String videosScreen = '/videosScreen';
  static const String insertEditVideoScreen = '/insertEditVideoScreen';
  // endregion

  // region Playlists Comments
  static const String playlistsCommentsScreen = '/playlistsCommentsScreen';
  static const String insertEditPlaylistCommentScreen = '/insertEditPlaylistCommentScreen';
  // endregion

  // region Phone Number Requests
  static const String phoneNumberRequestsScreen = '/phoneNumberRequestsScreen';
  static const String insertEditPhoneNumberRequestScreen = '/insertEditPhoneNumberRequestScreen';
  // endregion

  // region Booking Appointments
  static const String bookingAppointmentsScreen = '/bookingAppointmentsScreen';
  static const String insertEditBookingAppointmentScreen = '/insertEditBookingAppointmentScreen';
  // endregion

  // region Instant Consultations
  static const String instantConsultationsScreen = '/instantConsultationsScreen';
  static const String insertEditInstantConsultationScreen = '/insertEditInstantConsultationScreen';
  // endregion

  // region Instant Consultations Comments
  static const String instantConsultationsCommentsScreen = '/instantConsultationsCommentsScreen';
  static const String insertEditInstantConsultationCommentScreen = '/insertEditInstantConsultationCommentScreen';
  // endregion

  // region Secret Consultations
  static const String secretConsultationsScreen = '/secretConsultationsScreen';
  static const String insertEditSecretConsultationScreen = '/insertEditSecretConsultationScreen';
  // endregion

  // region Suggested Messages
  static const String suggestedMessagesScreen = '/suggestedMessagesScreen';
  static const String insertEditSuggestedMessageScreen = '/insertEditSuggestedMessageScreen';
  // endregion

  // region Wallet History
  static const String walletHistoryScreen = '/walletHistoryScreen';
  static const String insertEditWalletHistoryScreen = '/insertEditWalletHistoryScreen';
  // endregion

  // region Withdrawal Requests
  static const String withdrawalRequestsScreen = '/withdrawalRequestsScreen';
  static const String insertEditWithdrawalRequestScreen = '/insertEditWithdrawalRequestScreen';
  // endregion

  // region Financial Accounts
  static const String financialAccountsScreen = '/financialAccountsScreen';
  static const String revenuesScreen = '/revenuesScreen';
  static const String expensesScreen = '/expensesScreen';
  // endregion

  // region About App
  static const String aboutAppScreen = '/aboutAppScreen';
  static const String editAboutAppScreen = '/editAboutAppScreen';
  // endregion

  // region Service Description
  static const String serviceDescriptionScreen = '/serviceDescriptionScreen';
  static const String editServiceDescriptionScreen = '/editServiceDescriptionScreen';
  // endregion

  // region Privacy Policy
  static const String privacyPolicyScreen = '/privacyPolicyScreen';
  static const String editPrivacyPolicyScreen = '/editPrivacyPolicyScreen';
  // endregion

  // region Terms Of Use
  static const String termsOfUseScreen = '/termsOfUseScreen';
  static const String editTermsOfUseScreen = '/editTermsOfUseScreen';
  // endregion

  // region Settings
  static const String settingsScreen = '/settingsScreen';
  // endregion

  // region Version
  static const String versionScreen = '/versionScreen';
  static const String editVersionScreen = '/editVersionScreen';
  // endregion

  // region Show Full Image
  static const String showFullImageScreen = '/showFullImageScreen';
  // endregion

  // region Notifications
  static const String notificationsScreen = '/notificationsScreen';
  // endregion

  // region Chats
  static const String chatRoomRoute = '/chatRoomRoute';
  // endregion
}

PageRouteBuilder onGenerateRoute (routeSettings) {
  List<String> noAnimationScreens = [Routes.showFullImageScreen];

  return PageRouteBuilder(
    settings: routeSettings,
    transitionDuration: const Duration(milliseconds: ConstantsManager.pageTransitionDuration),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return noAnimationScreens.contains(routeSettings.name) ? ShowFullImageScreen(
        imageUrl: routeSettings.arguments,
      ) : PageTransition.slideLeftTransition(animation: animation, child: child);
    },
    pageBuilder: (context, animation, secondaryAnimation) {
      switch (routeSettings.name) {

      // region Start
        case Routes.startScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => StartProvider()),
          ],
          child: const StartScreen(),
        );
        case Routes.languageScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => LanguageProvider()),
            ChangeNotifierProvider.value(value: StartProvider()),
          ],
          child: const LanguageScreen(),
        );
        case Routes.gettingStartedScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: StartProvider()),
          ],
          child: const GettingStartedScreen(),
        );
        case Routes.onBoardingScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => OnBoardingProvider()),
            ChangeNotifierProvider.value(value: StartProvider()),
          ],
          child: const OnBoardingScreen(),
        );
        case Routes.updateScreen: return UpdateScreen(isForceUpdate: routeSettings.arguments);
        case Routes.maintenanceScreen: return const MaintenanceScreen();
        case Routes.failureScreen: return FailureScreen(failure: routeSettings.arguments);
        case Routes.splashScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => SplashProvider()),
          ],
          child: const SplashScreen(),
        );
      // endregion

      // region Authentication
      //   case Routes.loginScreen: return const LoginScreen();
      //   case Routes.registerScreen: return const RegisterScreen();
        case Routes.registerWithPhoneScreen: return RegisterWithPhoneScreen(phoneNumber: routeSettings.arguments);
        case Routes.forgotPasswordScreen: return const ForgotPasswordScreen();
        case Routes.otpScreen: return OtpScreen(verificationCode: routeSettings.arguments);
        case Routes.resetPasswordScreen: return ResetPasswordScreen(emailAddress: routeSettings.arguments);
        case Routes.changePasswordScreen: return const ChangePasswordScreen();
        case Routes.loginWithPhoneScreen: return const LoginWithPhoneScreen();
        case Routes.verifyPhoneOtpScreen: return VerifyPhoneOtpScreen(
          verificationId: routeSettings.arguments[ConstantsManager.verificationIdArgument],
          phoneNumber: routeSettings.arguments[ConstantsManager.phoneNumberArgument],
        );
      // endregion

      // region Profile
        case Routes.userProfileScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => UserProfileProvider()),
          ],
          child: UserProfileScreen(userModel: routeSettings.arguments),
        );
        case Routes.editUserProfileScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => EditUserProfileProvider()),
          ],
          child: EditUserProfileScreen(userModel: routeSettings.arguments),
        );
      // endregion

      // region Main
        case Routes.mainScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => MainProvider()),
            ChangeNotifierProvider(create: (_) => HomeProvider()),
            ChangeNotifierProvider(create: (_) => SearchProvider()),
            ChangeNotifierProvider(create: (_) => TransactionsProvider()),
            ChangeNotifierProvider(create: (_) => WalletHistoryProvider()),
          ],
          child: const MainScreen(),
        );
      // endregion

      // region Admins
        case Routes.adminsScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AdminsProvider()),
          ],
          child: const AdminsScreen(),
        );
        case Routes.insertEditAdminScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => InsertEditAdminProvider()),
          ],
          child: InsertEditAdminScreen(adminModel: routeSettings.arguments),
        );
        case Routes.adminProfileScreen: return AdminProfileScreen(adminModel: routeSettings.arguments);
      // endregion

      // region Users
        case Routes.usersScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => UsersProvider()),
          ],
          child: const UsersScreen(),
        );
        case Routes.insertEditUserScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => InsertEditUserProvider()),
          ],
          child: InsertEditUserScreen(userModel: routeSettings.arguments),
        );
        case Routes.userProfileScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => UserProfileProvider()),
          ],
          child: UserProfileScreen(userModel: routeSettings.arguments),
        );
      // endregion

      // region Accounts
        case Routes.accountsScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AccountsProvider(accountsArgs: routeSettings.arguments)),
          ],
          child: const AccountsScreen(),
        );
        case Routes.accountDetailsScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AccountDetailsProvider(accountModel: routeSettings.arguments)),
          ],
          child: const AccountDetailsScreen(),
        );
      // endregion

      // region Main Categories
        case Routes.mainCategoriesScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => MainCategoriesProvider()),
          ],
          child: const MainCategoriesScreen(),
        );
        case Routes.insertEditMainCategoryScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => InsertEditMainCategoryProvider()),
          ],
          child: InsertEditMainCategoryScreen(mainCategoryModel: routeSettings.arguments),
        );
      // endregion

      // region Categories
        case Routes.categoriesScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => CategoriesProvider(mainCategory: routeSettings.arguments)),
          ],
          child: const CategoriesScreen(),
        );
      // endregion

      // region Services
        case Routes.servicesScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ServicesProvider()),
          ],
          child: const ServicesScreen(),
        );
        case Routes.serviceDetailsScreen: return ServiceDetailsScreen(args: routeSettings.arguments);
        case Routes.serviceScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ServiceProvider(service: routeSettings.arguments)),
          ],
          child: const ServiceScreen(),
        );
        case Routes.instantLawyersScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => InstantLawyersProvider(currentPosition: routeSettings.arguments)),
          ],
          child: const InstantLawyersScreen(),
        );
        case Routes.instantConsultationFormScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => InstantConsultationFormProvider()),
            ChangeNotifierProvider.value(value: WalletHistoryProvider()),
          ],
          child: const InstantConsultationFormScreen(),
        );
        case Routes.secretConsultationFormScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => SecretConsultationFormProvider()),
            ChangeNotifierProvider.value(value: WalletHistoryProvider()),
          ],
          child: const SecretConsultationFormScreen(),
        );
      // endregion

      // region Sliders
        case Routes.slidersScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => SlidersProvider()),
          ],
          child: const SlidersScreen(),
        );
        case Routes.insertEditSliderScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => InsertEditSliderProvider()),
          ],
          child: InsertEditSliderScreen(sliderModel: routeSettings.arguments),
        );
      // endregion

      // region Articles
        case Routes.articlesScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ArticlesProvider()),
          ],
          child: const ArticlesScreen(),
        );
        case Routes.insertEditArticleScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => InsertEditArticleProvider()),
          ],
          child: InsertEditArticleScreen(articleModel: routeSettings.arguments),
        );
        case Routes.articleDetailsScreen: return ArticleDetailsScreen(articleModel: routeSettings.arguments);
      // endregion

      // region Faqs
        case Routes.faqsScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => FaqsProvider()),
          ],
          child: const FaqsScreen(),
        );
        case Routes.insertEditFaqScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => InsertEditFaqProvider()),
          ],
          child: InsertEditFaqScreen(faqModel: routeSettings.arguments),
        );
      // endregion

      // region Jobs
        case Routes.jobsScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => JobsProvider(jobsArgs: routeSettings.arguments)),
          ],
          child: const JobsScreen(),
        );
        case Routes.insertEditJobScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => InsertEditJobProvider()),
          ],
          child: InsertEditJobScreen(jobModel: routeSettings.arguments),
        );
        case Routes.jobDetailsScreen: return JobDetailsScreen(jobModel: routeSettings.arguments);
        case Routes.jobApplyScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => JobApplyProvider()),
          ],
          child: JobApplyScreen(jobModel: routeSettings.arguments),
        );
      // endregion

      // region Employment Applications
        case Routes.employmentApplicationsScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => EmploymentApplicationsProvider(employmentApplicationsArgs: routeSettings.arguments)),
          ],
          child: const EmploymentApplicationsScreen(),
        );
      // endregion

      // region Complaints
        case Routes.complaintsScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ComplaintsProvider()),
          ],
          child: const ComplaintsScreen(),
        );
      // endregion

      // region Reviews
        case Routes.reviewsScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ReviewsProvider(reviewsArgs: routeSettings.arguments)),
          ],
          child: const ReviewsScreen(),
        );
        case Routes.insertEditReviewScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => InsertEditReviewProvider()),
          ],
          child: InsertEditReviewScreen(reviewModel: routeSettings.arguments),
        );
      // endregion

      // region Features
        case Routes.featuresScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => FeaturesProvider()),
          ],
          child: const FeaturesScreen(),
        );
        case Routes.insertEditFeatureScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => InsertEditFeatureProvider()),
          ],
          child: InsertEditFeatureScreen(featureModel: routeSettings.arguments),
        );
      // endregion

      // region Social Media
        case Routes.socialMediaScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => SocialMediaProvider()),
          ],
          child: const SocialMediaScreen(),
        );
        case Routes.insertEditSocialMediaScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => InsertEditSocialMediaProvider()),
          ],
          child: InsertEditSocialMediaScreen(socialMediaModel: routeSettings.arguments),
        );
      // endregion

      // region Playlists
        case Routes.playlistsScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => PlaylistsProvider()),
          ],
          child: const PlaylistsScreen(),
        );
        case Routes.playlistDetailsScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => PlaylistDetailsProvider(playlistModel: routeSettings.arguments)),
          ],
          child: const PlaylistDetailsScreen(),
        );
      // endregion

      // region Videos
        case Routes.videosScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => VideosProvider()),
          ],
          child: const VideosScreen(),
        );
        case Routes.insertEditVideoScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => InsertEditVideoProvider()),
          ],
          child: InsertEditVideoScreen(videoModel: routeSettings.arguments),
        );
      // endregion

      // region Playlists Comments
        case Routes.playlistsCommentsScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => PlaylistsCommentsProvider()),
          ],
          child: const PlaylistsCommentsScreen(),
        );
        case Routes.insertEditPlaylistCommentScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => InsertEditPlaylistCommentProvider()),
          ],
          child: InsertEditPlaylistCommentScreen(playlistCommentModel: routeSettings.arguments),
        );
      // endregion

      // region Phone Number Requests
        case Routes.phoneNumberRequestsScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => PhoneNumberRequestsProvider(phoneNumberRequestsArgs: routeSettings.arguments)),
          ],
          child: const PhoneNumberRequestsScreen(),
        );
        case Routes.insertEditPhoneNumberRequestScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => InsertEditPhoneNumberRequestProvider()),
          ],
          child: InsertEditPhoneNumberRequestScreen(phoneNumberRequestModel: routeSettings.arguments),
        );
      // endregion

      // region Booking Appointments
        case Routes.bookingAppointmentsScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => BookingAppointmentsProvider(bookingAppointmentsArgs: routeSettings.arguments)),
          ],
          child: const BookingAppointmentsScreen(),
        );
        case Routes.insertEditBookingAppointmentScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => InsertEditBookingAppointmentProvider()),
          ],
          child: InsertEditBookingAppointmentScreen(bookingAppointmentModel: routeSettings.arguments),
        );
      // endregion

      // region Instant Consultations Comments
        case Routes.instantConsultationsCommentsScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => InstantConsultationsCommentsProvider(instantConsultationsCommentsArgs: routeSettings.arguments)),
          ],
          child: const InstantConsultationsCommentsScreen(),
        );
        case Routes.insertEditInstantConsultationCommentScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => InsertEditInstantConsultationCommentProvider()),
          ],
          child: InsertEditInstantConsultationCommentScreen(instantConsultationCommentModel: routeSettings.arguments),
        );
      // endregion

      // region Suggested Messages
        case Routes.suggestedMessagesScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => SuggestedMessagesProvider()),
          ],
          child: const SuggestedMessagesScreen(),
        );
        case Routes.insertEditSuggestedMessageScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => InsertEditSuggestedMessageProvider()),
          ],
          child: InsertEditSuggestedMessageScreen(suggestedMessageModel: routeSettings.arguments),
        );
      // endregion

      // region Withdrawal Requests
        case Routes.withdrawalRequestsScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => WithdrawalRequestsProvider(withdrawalRequestsArgs: routeSettings.arguments)),
          ],
          child: const WithdrawalRequestsScreen(),
        );
        case Routes.insertEditWithdrawalRequestScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => InsertEditWithdrawalRequestProvider()),
          ],
          child: InsertEditWithdrawalRequestScreen(withdrawalRequestModel: routeSettings.arguments),
        );
      // endregion

      // region Financial Accounts
        case Routes.financialAccountsScreen: return FinancialAccountsScreen(adminStatistics: routeSettings.arguments);
        case Routes.revenuesScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => RevenuesProvider()),
          ],
          child: RevenuesScreen(adminStatistics: routeSettings.arguments),
        );
        case Routes.expensesScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: ExpensesProvider()),
          ],
          child: ExpensesScreen(adminStatistics: routeSettings.arguments),
        );
        // endregion

      // region About App
        case Routes.aboutAppScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AboutAppProvider()),
          ],
          child: const AboutAppScreen(),
        );
        case Routes.editAboutAppScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => EditAboutAppProvider()),
          ],
          child: EditAboutAppScreen(aboutAppModel: routeSettings.arguments),
        );
      // endregion

      // region Service Description
        case Routes.serviceDescriptionScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ServiceDescriptionProvider()),
          ],
          child: const ServiceDescriptionScreen(),
        );
        case Routes.editServiceDescriptionScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => EditServiceDescriptionProvider()),
          ],
          child: EditServiceDescriptionScreen(serviceDescriptionModel: routeSettings.arguments),
        );
      // endregion

      // region Privacy Policy
        case Routes.privacyPolicyScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => PrivacyPolicyProvider()),
          ],
          child: const PrivacyPolicyScreen(),
        );
        case Routes.editPrivacyPolicyScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => EditPrivacyPolicyProvider()),
          ],
          child: EditPrivacyPolicyScreen(privacyPolicyModel: routeSettings.arguments),
        );
      // endregion

      // region Terms Of Use
        case Routes.termsOfUseScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => TermsOfUseProvider()),
          ],
          child: const TermsOfUseScreen(),
        );
        case Routes.editTermsOfUseScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => EditTermsOfUseProvider()),
          ],
          child: EditTermsOfUseScreen(termsOfUseModel: routeSettings.arguments),
        );
      // endregion

      // region Settings
        case Routes.settingsScreen: return const SettingsScreen();
      // endregion

      // region Version
        case Routes.versionScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => VersionProvider()),
          ],
          child: VersionScreen(app: routeSettings.arguments),
        );
        case Routes.editVersionScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: VersionProvider()),
          ],
          child: EditVersionScreen(versionModel: routeSettings.arguments[0], app: routeSettings.arguments[1]),
        );
      // endregion

      // region Notifications
        case Routes.notificationsScreen: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => NotificationsProvider()),
          ],
          child: const NotificationsScreen(),
        );
      // endregion

      // region Chats
        case Routes.chatRoomRoute: return const ChatRoomScreen();
      // endregion

        default: return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => StartProvider()),
          ],
          child: const StartScreen(),
        );
      }
    },
  );
}

// region Args
class ReviewsArgs {
  final AccountModel? account;

  ReviewsArgs({
    this.account,
  });
}

class JobsArgs {
  final AccountModel? account;

  JobsArgs({
    this.account,
  });
}

class EmploymentApplicationsArgs {
  final JobModel? job;
  final AccountModel? account;

  EmploymentApplicationsArgs({
    this.job,
    this.account,
  });
}

class InstantConsultationsCommentsArgs {
  final InstantConsultationModel? instantConsultation;
  final AccountModel? account;

  InstantConsultationsCommentsArgs({
    this.instantConsultation,
    this.account,
  });
}

class PhoneNumberRequestsArgs {
  final AccountModel? account;

  PhoneNumberRequestsArgs({
    this.account,
  });
}

class BookingAppointmentsArgs {
  final AccountModel? account;

  BookingAppointmentsArgs({
    this.account,
  });
}

class WalletHistoryArgs {
  final AccountModel? account;
  final UserModel? user;
  final bool isRevenueOnly;

  WalletHistoryArgs({
    this.account,
    this.user,
    this.isRevenueOnly = false,
  });
}

class WithdrawalRequestsArgs {
  final AccountModel account;

  WithdrawalRequestsArgs({
    required this.account,
  });
}

class ServiceDetailsArgs {
  final ServiceModel service;
  final Color color;

  ServiceDetailsArgs({
    required this.service,
    required this.color,
  });
}

class AccountsArgs {
  final MainCategoryModel mainCategory;
  final CategoryModel? category;

  AccountsArgs({
    required this.mainCategory,
    this.category,
  });
}
// endregion