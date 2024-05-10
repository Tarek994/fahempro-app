import 'package:fahem_dashboard/domain/usecases/accounts/delete_account_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/accounts/edit_account_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/accounts/get_accounts_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/accounts/insert_account_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/admin_notifications/set_is_viewed_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_account/change_account_password_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_account/check_account_email_to_reset_password_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_account/delete_account_account_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_account/edit_account_profile_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_account/get_account_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_account/is_account_email_exist_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_account/is_account_exist_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_account/login_account_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_account/register_account_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_account/reset_account_password_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/chats/add_chat_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/chats/add_message_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/chats/update_message_mode_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/features/delete_feature_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/features/edit_feature_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/features/get_feature_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/features/get_features_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/features/insert_feature_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/main_categories/delete_main_category_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/main_categories/edit_main_category_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/main_categories/get_main_categories_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/main_categories/get_main_category_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/main_categories/insert_main_category_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/playlists/delete_playlist_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/playlists/edit_playlist_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/playlists/get_playlist_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/playlists/get_playlists_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/playlists/insert_playlist_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/playlists_comments/delete_playlist_comment_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/playlists_comments/edit_playlist_comment_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/playlists_comments/get_playlist_comment_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/playlists_comments/get_playlists_comments_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/playlists_comments/insert_playlist_comment_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/reviews/delete_review_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/reviews/edit_review_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/reviews/get_review_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/reviews/get_reviews_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/reviews/insert_review_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/services/delete_service_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/services/edit_service_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/services/get_service_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/services/get_services_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/services/insert_service_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/suggested_messages/delete_suggested_message_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/suggested_messages/edit_suggested_message_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/suggested_messages/get_suggested_message_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/suggested_messages/get_suggested_messages_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/suggested_messages/insert_suggested_message_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/videos/delete_video_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/videos/edit_video_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/videos/get_video_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/videos/get_videos_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/videos/insert_video_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/wallet_history/delete_wallet_history_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/wallet_history/edit_wallet_history_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/wallet_history/get_wallet_history_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/wallet_history/get_wallet_history_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/wallet_history/insert_wallet_history_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/withdrawal_requests/delete_withdrawal_request_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/withdrawal_requests/edit_withdrawal_request_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/withdrawal_requests/get_withdrawal_request_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/withdrawal_requests/get_withdrawal_requests_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/withdrawal_requests/insert_withdrawal_request_usecase.dart';
import 'package:fahem_dashboard/presentation/screens/chats/controllers/chat_room_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:fahem_dashboard/core/network/network_info.dart';
import 'package:fahem_dashboard/data/data_source/remote/remote_data_source.dart';
import 'package:fahem_dashboard/data/repository/repository.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/about_app/edit_about_app_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/about_app/get_about_app_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/admins/delete_admin_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/admins/edit_admin_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/admins/get_admins_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/admins/insert_admin_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/articles/increment_article_views_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/articles/insert_article_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_user/change_user_password_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_user/check_user_email_to_reset_password_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_user/delete_user_account_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_user/edit_user_profile_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_user/get_user_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_user/is_user_email_exist_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_user/is_user_exist_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_user/login_user_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_user/register_user_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_user/reset_user_password_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_admin/change_admin_password_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_admin/check_admin_email_to_reset_password_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_admin/delete_admin_account_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_admin/edit_admin_profile_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_admin/get_admin_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_admin/is_admin_email_exist_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_admin/is_admin_exist_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_admin/login_admin_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_admin/reset_admin_password_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/categories/delete_category_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/categories/edit_category_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/categories/get_categories_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/categories/get_category_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/categories/insert_category_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/jobs/change_job_status_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/jobs/delete_job_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/jobs/edit_job_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/jobs/get_jobs_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/jobs/get_job_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/jobs/increment_job_views_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/jobs/insert_job_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/employment_applications/delete_employment_application_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/employment_applications/edit_employment_application_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/employment_applications/get_employment_applications_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/employment_applications/get_employment_application_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/employment_applications/insert_employment_application_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/complaints/delete_complaint_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/complaints/get_complaint_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/complaints/get_complaints_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/complaints/insert_complaint_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/faqs/delete_faq_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/faqs/edit_faq_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/faqs/get_faq_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/faqs/get_faqs_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/faqs/insert_faq_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/phone_number_requests/delete_phone_number_request_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/phone_number_requests/edit_phone_number_request_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/phone_number_requests/get_phone_number_request_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/phone_number_requests/get_phone_number_requests_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/phone_number_requests/insert_phone_number_request_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/booking_appointments/delete_booking_appointment_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/booking_appointments/edit_booking_appointment_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/booking_appointments/get_booking_appointment_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/booking_appointments/get_booking_appointments_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/booking_appointments/insert_booking_appointment_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/instant_consultations/delete_instant_consultation_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/instant_consultations/edit_instant_consultation_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/instant_consultations/get_instant_consultation_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/instant_consultations/get_instant_consultations_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/instant_consultations/insert_instant_consultation_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/instant_consultations_comments/delete_instant_consultation_comment_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/instant_consultations_comments/edit_instant_consultation_comment_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/instant_consultations_comments/get_instant_consultation_comment_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/instant_consultations_comments/get_instant_consultations_comments_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/instant_consultations_comments/insert_instant_consultation_comment_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/secret_consultations/delete_secret_consultation_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/secret_consultations/edit_secret_consultation_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/secret_consultations/get_secret_consultation_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/secret_consultations/get_secret_consultations_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/secret_consultations/insert_secret_consultation_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/articles/delete_article_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/articles/edit_article_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/articles/get_article_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/articles/get_articles_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/notifications/delete_notification_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/notifications/get_notification_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/notifications/get_notifications_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/notifications/insert_notification_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/admin_notifications/delete_admin_notification_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/admin_notifications/get_admin_notification_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/admin_notifications/get_admin_notifications_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/admin_notifications/insert_admin_notification_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/privacy_policy/edit_privacy_policy_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/service_description/edit_service_description_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/service_description/get_service_description_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/sliders/delete_slider_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/sliders/edit_slider_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/sliders/get_slider_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/sliders/get_sliders_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/sliders/insert_slider_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/social_media/delete_social_media_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/social_media/edit_social_media_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/social_media/get_social_media_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/social_media/get_social_media_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/social_media/insert_social_media_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/statistics/get_admin_statistics_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/terms_of_use/edit_terms_of_use_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/privacy_policy/get_privacy_policy_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/terms_of_use/get_terms_of_use_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/upload_file/upload_file_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/users/delete_user_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/users/edit_user_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/users/get_users_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/users/insert_user_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/version/edit_version_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/version/get_version_usecase.dart';

class DependencyInjection {
  static final GetIt getIt = GetIt.instance;

  static void init() {

    getIt.registerFactory(() => ChatRoomProvider(getIt(), getIt(), getIt()));

    getIt.registerLazySingleton<AddChatUseCase>(() => AddChatUseCase(getIt()));
    getIt.registerLazySingleton<AddMessageUseCase>(() => AddMessageUseCase(getIt()));
    getIt.registerLazySingleton<UpdateMessageModeUseCase>(() => UpdateMessageModeUseCase(getIt()));



    // region Core
    getIt.registerLazySingleton<BaseNetworkInfo>(() => NetworkInfo(InternetConnection()));
    // endregion

    // region Repository
    getIt.registerLazySingleton<BaseRepository>(() => Repository(getIt(), getIt()));
    // endregion

    // region Data Source
    getIt.registerLazySingleton<BaseRemoteDataSource>(() => RemoteDataSource());
    // getIt.registerLazySingleton<BaseLocalDataSource>(() => LocalDataSource());
    // endregion

    // region Usecases

    // region Upload File
    getIt.registerLazySingleton<UploadFileUseCase>(() => UploadFileUseCase(getIt()));
    // endregion

    // region Version
    getIt.registerLazySingleton<GetVersionUseCase>(() => GetVersionUseCase(getIt()));
    getIt.registerLazySingleton<EditVersionUseCase>(() => EditVersionUseCase(getIt()));
    // endregion

    // region Authentication Admin
    getIt.registerLazySingleton<LoginAdminUseCase>(() => LoginAdminUseCase(getIt()));
    getIt.registerLazySingleton<CheckAdminEmailToResetPasswordUseCase>(() => CheckAdminEmailToResetPasswordUseCase(getIt()));
    getIt.registerLazySingleton<ResetAdminPasswordUseCase>(() => ResetAdminPasswordUseCase(getIt()));
    getIt.registerLazySingleton<ChangeAdminPasswordUseCase>(() => ChangeAdminPasswordUseCase(getIt()));
    getIt.registerLazySingleton<EditAdminProfileUseCase>(() => EditAdminProfileUseCase(getIt()));
    getIt.registerLazySingleton<GetAdminWithIdUseCase>(() => GetAdminWithIdUseCase(getIt()));
    getIt.registerLazySingleton<IsAdminExistUseCase>(() => IsAdminExistUseCase(getIt()));
    getIt.registerLazySingleton<IsAdminEmailExistUseCase>(() => IsAdminEmailExistUseCase(getIt()));
    getIt.registerLazySingleton<DeleteAdminAccountUseCase>(() => DeleteAdminAccountUseCase(getIt()));
    // endregion

    // region Authentication User
    getIt.registerLazySingleton<LoginUserUseCase>(() => LoginUserUseCase(getIt()));
    getIt.registerLazySingleton<RegisterUserUseCase>(() => RegisterUserUseCase(getIt()));
    getIt.registerLazySingleton<CheckUserEmailToResetPasswordUseCase>(() => CheckUserEmailToResetPasswordUseCase(getIt()));
    getIt.registerLazySingleton<ResetUserPasswordUseCase>(() => ResetUserPasswordUseCase(getIt()));
    getIt.registerLazySingleton<ChangeUserPasswordUseCase>(() => ChangeUserPasswordUseCase(getIt()));
    getIt.registerLazySingleton<EditUserProfileUseCase>(() => EditUserProfileUseCase(getIt()));
    getIt.registerLazySingleton<GetUserWithIdUseCase>(() => GetUserWithIdUseCase(getIt()));
    getIt.registerLazySingleton<IsUserExistUseCase>(() => IsUserExistUseCase(getIt()));
    getIt.registerLazySingleton<IsUserEmailExistUseCase>(() => IsUserEmailExistUseCase(getIt()));
    getIt.registerLazySingleton<DeleteUserAccountUseCase>(() => DeleteUserAccountUseCase(getIt()));
    // endregion

    // region Authentication Account
    getIt.registerLazySingleton<LoginAccountUseCase>(() => LoginAccountUseCase(getIt()));
    getIt.registerLazySingleton<RegisterAccountUseCase>(() => RegisterAccountUseCase(getIt()));
    getIt.registerLazySingleton<CheckAccountEmailToResetPasswordUseCase>(() => CheckAccountEmailToResetPasswordUseCase(getIt()));
    getIt.registerLazySingleton<ResetAccountPasswordUseCase>(() => ResetAccountPasswordUseCase(getIt()));
    getIt.registerLazySingleton<ChangeAccountPasswordUseCase>(() => ChangeAccountPasswordUseCase(getIt()));
    getIt.registerLazySingleton<EditAccountProfileUseCase>(() => EditAccountProfileUseCase(getIt()));
    getIt.registerLazySingleton<GetAccountWithIdUseCase>(() => GetAccountWithIdUseCase(getIt()));
    getIt.registerLazySingleton<IsAccountExistUseCase>(() => IsAccountExistUseCase(getIt()));
    getIt.registerLazySingleton<IsAccountEmailExistUseCase>(() => IsAccountEmailExistUseCase(getIt()));
    getIt.registerLazySingleton<DeleteAccountAccountUseCase>(() => DeleteAccountAccountUseCase(getIt()));
    // endregion

    // region Admins
    getIt.registerLazySingleton<GetAdminsUseCase>(() => GetAdminsUseCase(getIt()));
    getIt.registerLazySingleton<InsertAdminUseCase>(() => InsertAdminUseCase(getIt()));
    getIt.registerLazySingleton<EditAdminUseCase>(() => EditAdminUseCase(getIt()));
    getIt.registerLazySingleton<DeleteAdminUseCase>(() => DeleteAdminUseCase(getIt()));
    // endregion

    // region Users
    getIt.registerLazySingleton<GetUsersUseCase>(() => GetUsersUseCase(getIt()));
    getIt.registerLazySingleton<InsertUserUseCase>(() => InsertUserUseCase(getIt()));
    getIt.registerLazySingleton<EditUserUseCase>(() => EditUserUseCase(getIt()));
    getIt.registerLazySingleton<DeleteUserUseCase>(() => DeleteUserUseCase(getIt()));
    // endregion

    // region Accounts
    getIt.registerLazySingleton<GetAccountsUseCase>(() => GetAccountsUseCase(getIt()));
    getIt.registerLazySingleton<InsertAccountUseCase>(() => InsertAccountUseCase(getIt()));
    getIt.registerLazySingleton<EditAccountUseCase>(() => EditAccountUseCase(getIt()));
    getIt.registerLazySingleton<DeleteAccountUseCase>(() => DeleteAccountUseCase(getIt()));
    // endregion

    // region Statistics
    getIt.registerLazySingleton<GetAdminStatisticsUseCase>(() => GetAdminStatisticsUseCase(getIt()));
    // endregion

    // region About App
    getIt.registerLazySingleton<GetAboutAppUseCase>(() => GetAboutAppUseCase(getIt()));
    getIt.registerLazySingleton<EditAboutAppUseCase>(() => EditAboutAppUseCase(getIt()));
    // endregion

    // region Service Description
    getIt.registerLazySingleton<GetServiceDescriptionUseCase>(() => GetServiceDescriptionUseCase(getIt()));
    getIt.registerLazySingleton<EditServiceDescriptionUseCase>(() => EditServiceDescriptionUseCase(getIt()));
    // endregion

    // region Privacy Policy
    getIt.registerLazySingleton<GetPrivacyPolicyUseCase>(() => GetPrivacyPolicyUseCase(getIt()));
    getIt.registerLazySingleton<EditPrivacyPolicyUseCase>(() => EditPrivacyPolicyUseCase(getIt()));
    // endregion

    // region Terms Of Use
    getIt.registerLazySingleton<GetTermsOfUseUseCase>(() => GetTermsOfUseUseCase(getIt()));
    getIt.registerLazySingleton<EditTermsOfUseUseCase>(() => EditTermsOfUseUseCase(getIt()));
    // endregion

    // region Sliders
    getIt.registerLazySingleton<GetSlidersUseCase>(() => GetSlidersUseCase(getIt()));
    getIt.registerLazySingleton<GetSliderWithIdUseCase>(() => GetSliderWithIdUseCase(getIt()));
    getIt.registerLazySingleton<InsertSliderUseCase>(() => InsertSliderUseCase(getIt()));
    getIt.registerLazySingleton<EditSliderUseCase>(() => EditSliderUseCase(getIt()));
    getIt.registerLazySingleton<DeleteSliderUseCase>(() => DeleteSliderUseCase(getIt()));
    // endregion

    // region Notifications
    getIt.registerLazySingleton<GetNotificationsUseCase>(() => GetNotificationsUseCase(getIt()));
    getIt.registerLazySingleton<GetNotificationWithIdUseCase>(() => GetNotificationWithIdUseCase(getIt()));
    getIt.registerLazySingleton<InsertNotificationUseCase>(() => InsertNotificationUseCase(getIt()));
    getIt.registerLazySingleton<DeleteNotificationUseCase>(() => DeleteNotificationUseCase(getIt()));
    // endregion

    // region Admin Notifications
    getIt.registerLazySingleton<GetAdminNotificationsUseCase>(() => GetAdminNotificationsUseCase(getIt()));
    getIt.registerLazySingleton<GetAdminNotificationWithIdUseCase>(() => GetAdminNotificationWithIdUseCase(getIt()));
    getIt.registerLazySingleton<InsertAdminNotificationUseCase>(() => InsertAdminNotificationUseCase(getIt()));
    getIt.registerLazySingleton<DeleteAdminNotificationUseCase>(() => DeleteAdminNotificationUseCase(getIt()));
    getIt.registerLazySingleton<SetIsViewedUseCase>(() => SetIsViewedUseCase(getIt()));
    // endregion

    // region Complaints
    getIt.registerLazySingleton<GetComplaintsUseCase>(() => GetComplaintsUseCase(getIt()));
    getIt.registerLazySingleton<GetComplaintWithIdUseCase>(() => GetComplaintWithIdUseCase(getIt()));
    getIt.registerLazySingleton<InsertComplaintUseCase>(() => InsertComplaintUseCase(getIt()));
    getIt.registerLazySingleton<DeleteComplaintUseCase>(() => DeleteComplaintUseCase(getIt()));
    // endregion

    // region Faqs
    getIt.registerLazySingleton<GetFaqsUseCase>(() => GetFaqsUseCase(getIt()));
    getIt.registerLazySingleton<GetFaqWithIdUseCase>(() => GetFaqWithIdUseCase(getIt()));
    getIt.registerLazySingleton<InsertFaqUseCase>(() => InsertFaqUseCase(getIt()));
    getIt.registerLazySingleton<EditFaqUseCase>(() => EditFaqUseCase(getIt()));
    getIt.registerLazySingleton<DeleteFaqUseCase>(() => DeleteFaqUseCase(getIt()));
    // endregion

    // region Articles
    getIt.registerLazySingleton<GetArticlesUseCase>(() => GetArticlesUseCase(getIt()));
    getIt.registerLazySingleton<GetArticleWithIdUseCase>(() => GetArticleWithIdUseCase(getIt()));
    getIt.registerLazySingleton<InsertArticleUseCase>(() => InsertArticleUseCase(getIt()));
    getIt.registerLazySingleton<EditArticleUseCase>(() => EditArticleUseCase(getIt()));
    getIt.registerLazySingleton<DeleteArticleUseCase>(() => DeleteArticleUseCase(getIt()));
    getIt.registerLazySingleton<IncrementArticleViewsUseCase>(() => IncrementArticleViewsUseCase(getIt()));
    // endregion

    // region Social Media
    getIt.registerLazySingleton<GetSocialMediaUseCase>(() => GetSocialMediaUseCase(getIt()));
    getIt.registerLazySingleton<GetSocialMediaWithIdUseCase>(() => GetSocialMediaWithIdUseCase(getIt()));
    getIt.registerLazySingleton<InsertSocialMediaUseCase>(() => InsertSocialMediaUseCase(getIt()));
    getIt.registerLazySingleton<EditSocialMediaUseCase>(() => EditSocialMediaUseCase(getIt()));
    getIt.registerLazySingleton<DeleteSocialMediaUseCase>(() => DeleteSocialMediaUseCase(getIt()));
    // endregion

    // region Suggested Messages
    getIt.registerLazySingleton<GetSuggestedMessagesUseCase>(() => GetSuggestedMessagesUseCase(getIt()));
    getIt.registerLazySingleton<GetSuggestedMessageWithIdUseCase>(() => GetSuggestedMessageWithIdUseCase(getIt()));
    getIt.registerLazySingleton<InsertSuggestedMessageUseCase>(() => InsertSuggestedMessageUseCase(getIt()));
    getIt.registerLazySingleton<EditSuggestedMessageUseCase>(() => EditSuggestedMessageUseCase(getIt()));
    getIt.registerLazySingleton<DeleteSuggestedMessageUseCase>(() => DeleteSuggestedMessageUseCase(getIt()));
    // endregion

    // region Wallet History
    getIt.registerLazySingleton<GetWalletHistoryUseCase>(() => GetWalletHistoryUseCase(getIt()));
    getIt.registerLazySingleton<GetWalletHistoryWithIdUseCase>(() => GetWalletHistoryWithIdUseCase(getIt()));
    getIt.registerLazySingleton<InsertWalletHistoryUseCase>(() => InsertWalletHistoryUseCase(getIt()));
    getIt.registerLazySingleton<EditWalletHistoryUseCase>(() => EditWalletHistoryUseCase(getIt()));
    getIt.registerLazySingleton<DeleteWalletHistoryUseCase>(() => DeleteWalletHistoryUseCase(getIt()));
    // endregion

    // region Categories
    getIt.registerLazySingleton<GetCategoriesUseCase>(() => GetCategoriesUseCase(getIt()));
    getIt.registerLazySingleton<GetCategoryWithIdUseCase>(() => GetCategoryWithIdUseCase(getIt()));
    getIt.registerLazySingleton<InsertCategoryUseCase>(() => InsertCategoryUseCase(getIt()));
    getIt.registerLazySingleton<EditCategoryUseCase>(() => EditCategoryUseCase(getIt()));
    getIt.registerLazySingleton<DeleteCategoryUseCase>(() => DeleteCategoryUseCase(getIt()));
    // endregion

    // region Main Categories
    getIt.registerLazySingleton<GetMainCategoriesUseCase>(() => GetMainCategoriesUseCase(getIt()));
    getIt.registerLazySingleton<GetMainCategoryWithIdUseCase>(() => GetMainCategoryWithIdUseCase(getIt()));
    getIt.registerLazySingleton<InsertMainCategoryUseCase>(() => InsertMainCategoryUseCase(getIt()));
    getIt.registerLazySingleton<EditMainCategoryUseCase>(() => EditMainCategoryUseCase(getIt()));
    getIt.registerLazySingleton<DeleteMainCategoryUseCase>(() => DeleteMainCategoryUseCase(getIt()));
    // endregion

    // region Jobs
    getIt.registerLazySingleton<GetJobsUseCase>(() => GetJobsUseCase(getIt()));
    getIt.registerLazySingleton<GetJobWithIdUseCase>(() => GetJobWithIdUseCase(getIt()));
    getIt.registerLazySingleton<InsertJobUseCase>(() => InsertJobUseCase(getIt()));
    getIt.registerLazySingleton<EditJobUseCase>(() => EditJobUseCase(getIt()));
    getIt.registerLazySingleton<DeleteJobUseCase>(() => DeleteJobUseCase(getIt()));
    getIt.registerLazySingleton<IncrementJobViewsUseCase>(() => IncrementJobViewsUseCase(getIt()));
    getIt.registerLazySingleton<ChangeJobStatusUseCase>(() => ChangeJobStatusUseCase(getIt()));
    // endregion

    // region Employment Applications
    getIt.registerLazySingleton<GetEmploymentApplicationsUseCase>(() => GetEmploymentApplicationsUseCase(getIt()));
    getIt.registerLazySingleton<GetEmploymentApplicationWithIdUseCase>(() => GetEmploymentApplicationWithIdUseCase(getIt()));
    getIt.registerLazySingleton<InsertEmploymentApplicationUseCase>(() => InsertEmploymentApplicationUseCase(getIt()));
    getIt.registerLazySingleton<EditEmploymentApplicationUseCase>(() => EditEmploymentApplicationUseCase(getIt()));
    getIt.registerLazySingleton<DeleteEmploymentApplicationUseCase>(() => DeleteEmploymentApplicationUseCase(getIt()));
    // endregion

    // region Services
    getIt.registerLazySingleton<GetServicesUseCase>(() => GetServicesUseCase(getIt()));
    getIt.registerLazySingleton<GetServiceWithIdUseCase>(() => GetServiceWithIdUseCase(getIt()));
    getIt.registerLazySingleton<InsertServiceUseCase>(() => InsertServiceUseCase(getIt()));
    getIt.registerLazySingleton<EditServiceUseCase>(() => EditServiceUseCase(getIt()));
    getIt.registerLazySingleton<DeleteServiceUseCase>(() => DeleteServiceUseCase(getIt()));
    // endregion

    // region Features
    getIt.registerLazySingleton<GetFeaturesUseCase>(() => GetFeaturesUseCase(getIt()));
    getIt.registerLazySingleton<GetFeatureWithIdUseCase>(() => GetFeatureWithIdUseCase(getIt()));
    getIt.registerLazySingleton<InsertFeatureUseCase>(() => InsertFeatureUseCase(getIt()));
    getIt.registerLazySingleton<EditFeatureUseCase>(() => EditFeatureUseCase(getIt()));
    getIt.registerLazySingleton<DeleteFeatureUseCase>(() => DeleteFeatureUseCase(getIt()));
    // endregion

    // region Reviews
    getIt.registerLazySingleton<GetReviewsUseCase>(() => GetReviewsUseCase(getIt()));
    getIt.registerLazySingleton<GetReviewWithIdUseCase>(() => GetReviewWithIdUseCase(getIt()));
    getIt.registerLazySingleton<InsertReviewUseCase>(() => InsertReviewUseCase(getIt()));
    getIt.registerLazySingleton<EditReviewUseCase>(() => EditReviewUseCase(getIt()));
    getIt.registerLazySingleton<DeleteReviewUseCase>(() => DeleteReviewUseCase(getIt()));
    // endregion

    // region Playlists
    getIt.registerLazySingleton<GetPlaylistsUseCase>(() => GetPlaylistsUseCase(getIt()));
    getIt.registerLazySingleton<GetPlaylistWithIdUseCase>(() => GetPlaylistWithIdUseCase(getIt()));
    getIt.registerLazySingleton<InsertPlaylistUseCase>(() => InsertPlaylistUseCase(getIt()));
    getIt.registerLazySingleton<EditPlaylistUseCase>(() => EditPlaylistUseCase(getIt()));
    getIt.registerLazySingleton<DeletePlaylistUseCase>(() => DeletePlaylistUseCase(getIt()));
    // endregion

    // region Videos
    getIt.registerLazySingleton<GetVideosUseCase>(() => GetVideosUseCase(getIt()));
    getIt.registerLazySingleton<GetVideoWithIdUseCase>(() => GetVideoWithIdUseCase(getIt()));
    getIt.registerLazySingleton<InsertVideoUseCase>(() => InsertVideoUseCase(getIt()));
    getIt.registerLazySingleton<EditVideoUseCase>(() => EditVideoUseCase(getIt()));
    getIt.registerLazySingleton<DeleteVideoUseCase>(() => DeleteVideoUseCase(getIt()));
    // endregion

    // region Playlists Comments
    getIt.registerLazySingleton<GetPlaylistsCommentsUseCase>(() => GetPlaylistsCommentsUseCase(getIt()));
    getIt.registerLazySingleton<GetPlaylistCommentWithIdUseCase>(() => GetPlaylistCommentWithIdUseCase(getIt()));
    getIt.registerLazySingleton<InsertPlaylistCommentUseCase>(() => InsertPlaylistCommentUseCase(getIt()));
    getIt.registerLazySingleton<EditPlaylistCommentUseCase>(() => EditPlaylistCommentUseCase(getIt()));
    getIt.registerLazySingleton<DeletePlaylistCommentUseCase>(() => DeletePlaylistCommentUseCase(getIt()));
    // endregion

    // region Phone Number Requests
    getIt.registerLazySingleton<GetPhoneNumberRequestsUseCase>(() => GetPhoneNumberRequestsUseCase(getIt()));
    getIt.registerLazySingleton<GetPhoneNumberRequestWithIdUseCase>(() => GetPhoneNumberRequestWithIdUseCase(getIt()));
    getIt.registerLazySingleton<InsertPhoneNumberRequestUseCase>(() => InsertPhoneNumberRequestUseCase(getIt()));
    getIt.registerLazySingleton<EditPhoneNumberRequestUseCase>(() => EditPhoneNumberRequestUseCase(getIt()));
    getIt.registerLazySingleton<DeletePhoneNumberRequestUseCase>(() => DeletePhoneNumberRequestUseCase(getIt()));
    // endregion

    // region Booking Appointments
    getIt.registerLazySingleton<GetBookingAppointmentsUseCase>(() => GetBookingAppointmentsUseCase(getIt()));
    getIt.registerLazySingleton<GetBookingAppointmentWithIdUseCase>(() => GetBookingAppointmentWithIdUseCase(getIt()));
    getIt.registerLazySingleton<InsertBookingAppointmentUseCase>(() => InsertBookingAppointmentUseCase(getIt()));
    getIt.registerLazySingleton<EditBookingAppointmentUseCase>(() => EditBookingAppointmentUseCase(getIt()));
    getIt.registerLazySingleton<DeleteBookingAppointmentUseCase>(() => DeleteBookingAppointmentUseCase(getIt()));
    // endregion

    // region Instant Consultations
    getIt.registerLazySingleton<GetInstantConsultationsUseCase>(() => GetInstantConsultationsUseCase(getIt()));
    getIt.registerLazySingleton<GetInstantConsultationWithIdUseCase>(() => GetInstantConsultationWithIdUseCase(getIt()));
    getIt.registerLazySingleton<InsertInstantConsultationUseCase>(() => InsertInstantConsultationUseCase(getIt()));
    getIt.registerLazySingleton<EditInstantConsultationUseCase>(() => EditInstantConsultationUseCase(getIt()));
    getIt.registerLazySingleton<DeleteInstantConsultationUseCase>(() => DeleteInstantConsultationUseCase(getIt()));
    // endregion

    // region Instant Consultations Comments
    getIt.registerLazySingleton<GetInstantConsultationsCommentsUseCase>(() => GetInstantConsultationsCommentsUseCase(getIt()));
    getIt.registerLazySingleton<GetInstantConsultationCommentWithIdUseCase>(() => GetInstantConsultationCommentWithIdUseCase(getIt()));
    getIt.registerLazySingleton<InsertInstantConsultationCommentUseCase>(() => InsertInstantConsultationCommentUseCase(getIt()));
    getIt.registerLazySingleton<EditInstantConsultationCommentUseCase>(() => EditInstantConsultationCommentUseCase(getIt()));
    getIt.registerLazySingleton<DeleteInstantConsultationCommentUseCase>(() => DeleteInstantConsultationCommentUseCase(getIt()));
    // endregion

    // region Secret Consultations
    getIt.registerLazySingleton<GetSecretConsultationsUseCase>(() => GetSecretConsultationsUseCase(getIt()));
    getIt.registerLazySingleton<GetSecretConsultationWithIdUseCase>(() => GetSecretConsultationWithIdUseCase(getIt()));
    getIt.registerLazySingleton<InsertSecretConsultationUseCase>(() => InsertSecretConsultationUseCase(getIt()));
    getIt.registerLazySingleton<EditSecretConsultationUseCase>(() => EditSecretConsultationUseCase(getIt()));
    getIt.registerLazySingleton<DeleteSecretConsultationUseCase>(() => DeleteSecretConsultationUseCase(getIt()));
    // endregion

    // region Withdrawal Requests
    getIt.registerLazySingleton<GetWithdrawalRequestsUseCase>(() => GetWithdrawalRequestsUseCase(getIt()));
    getIt.registerLazySingleton<GetWithdrawalRequestWithIdUseCase>(() => GetWithdrawalRequestWithIdUseCase(getIt()));
    getIt.registerLazySingleton<InsertWithdrawalRequestUseCase>(() => InsertWithdrawalRequestUseCase(getIt()));
    getIt.registerLazySingleton<EditWithdrawalRequestUseCase>(() => EditWithdrawalRequestUseCase(getIt()));
    getIt.registerLazySingleton<DeleteWithdrawalRequestUseCase>(() => DeleteWithdrawalRequestUseCase(getIt()));
    // endregion

    // endregion
  }

  // region Get Usecase

  // region Upload File
  static UploadFileUseCase get uploadFileUseCase => getIt<UploadFileUseCase>();
  // endregion

  // region Version
  static GetVersionUseCase get getVersionUseCase => getIt<GetVersionUseCase>();
  static EditVersionUseCase get editVersionUseCase => getIt<EditVersionUseCase>();
  // endregion

  // region Authentication Admin
  static LoginAdminUseCase get loginAdminUseCase => getIt<LoginAdminUseCase>();
  static CheckAdminEmailToResetPasswordUseCase get checkAdminEmailToResetPasswordUseCase => getIt<CheckAdminEmailToResetPasswordUseCase>();
  static ResetAdminPasswordUseCase get resetAdminPasswordUseCase => getIt<ResetAdminPasswordUseCase>();
  static ChangeAdminPasswordUseCase get changeAdminPasswordUseCase => getIt<ChangeAdminPasswordUseCase>();
  static EditAdminProfileUseCase get editAdminProfileUseCase => getIt<EditAdminProfileUseCase>();
  static GetAdminWithIdUseCase get getAdminWithIdUseCase => getIt<GetAdminWithIdUseCase>();
  static IsAdminExistUseCase get isAdminExistUseCase => getIt<IsAdminExistUseCase>();
  static IsAdminEmailExistUseCase get isAdminEmailExistUseCase => getIt<IsAdminEmailExistUseCase>();
  static DeleteAdminAccountUseCase get deleteAdminAccountUseCase => getIt<DeleteAdminAccountUseCase>();
  // endregion

  // region Authentication User
  static RegisterUserUseCase get registerUserUseCase => getIt<RegisterUserUseCase>();
  static LoginUserUseCase get loginUserUseCase => getIt<LoginUserUseCase>();
  static CheckUserEmailToResetPasswordUseCase get checkUserEmailToResetPasswordUseCase => getIt<CheckUserEmailToResetPasswordUseCase>();
  static ResetUserPasswordUseCase get resetUserPasswordUseCase => getIt<ResetUserPasswordUseCase>();
  static ChangeUserPasswordUseCase get changeUserPasswordUseCase => getIt<ChangeUserPasswordUseCase>();
  static EditUserProfileUseCase get editUserProfileUseCase => getIt<EditUserProfileUseCase>();
  static GetUserWithIdUseCase get getUserWithIdUseCase => getIt<GetUserWithIdUseCase>();
  static IsUserExistUseCase get isUserExistUseCase => getIt<IsUserExistUseCase>();
  static IsUserEmailExistUseCase get isUserEmailExistUseCase => getIt<IsUserEmailExistUseCase>();
  static DeleteUserAccountUseCase get deleteUserAccountUseCase => getIt<DeleteUserAccountUseCase>();
  // endregion

  // region Authentication Account
  static RegisterAccountUseCase get registerAccountUseCase => getIt<RegisterAccountUseCase>();
  static LoginAccountUseCase get loginAccountUseCase => getIt<LoginAccountUseCase>();
  static CheckAccountEmailToResetPasswordUseCase get checkAccountEmailToResetPasswordUseCase => getIt<CheckAccountEmailToResetPasswordUseCase>();
  static ResetAccountPasswordUseCase get resetAccountPasswordUseCase => getIt<ResetAccountPasswordUseCase>();
  static ChangeAccountPasswordUseCase get changeAccountPasswordUseCase => getIt<ChangeAccountPasswordUseCase>();
  static EditAccountProfileUseCase get editAccountProfileUseCase => getIt<EditAccountProfileUseCase>();
  static GetAccountWithIdUseCase get getAccountWithIdUseCase => getIt<GetAccountWithIdUseCase>();
  static IsAccountExistUseCase get isAccountExistUseCase => getIt<IsAccountExistUseCase>();
  static IsAccountEmailExistUseCase get isAccountEmailExistUseCase => getIt<IsAccountEmailExistUseCase>();
  static DeleteAccountAccountUseCase get deleteAccountAccountUseCase => getIt<DeleteAccountAccountUseCase>();
  // endregion

  // region Admins
  static GetAdminsUseCase get getAdminsUseCase => getIt<GetAdminsUseCase>();
  static InsertAdminUseCase get insertAdminUseCase => getIt<InsertAdminUseCase>();
  static EditAdminUseCase get editAdminUseCase => getIt<EditAdminUseCase>();
  static DeleteAdminUseCase get deleteAdminUseCase => getIt<DeleteAdminUseCase>();
  // endregion

  // region Users
  static GetUsersUseCase get getUsersUseCase => getIt<GetUsersUseCase>();
  static InsertUserUseCase get insertUserUseCase => getIt<InsertUserUseCase>();
  static EditUserUseCase get editUserUseCase => getIt<EditUserUseCase>();
  static DeleteUserUseCase get deleteUserUseCase => getIt<DeleteUserUseCase>();
  // endregion

  // region Accounts
  static GetAccountsUseCase get getAccountsUseCase => getIt<GetAccountsUseCase>();
  static InsertAccountUseCase get insertAccountUseCase => getIt<InsertAccountUseCase>();
  static EditAccountUseCase get editAccountUseCase => getIt<EditAccountUseCase>();
  static DeleteAccountUseCase get deleteAccountUseCase => getIt<DeleteAccountUseCase>();
  // endregion

  // region Statistics
  static GetAdminStatisticsUseCase get getAdminStatisticsUseCase => getIt<GetAdminStatisticsUseCase>();
  // endregion

  // region About App
  static GetAboutAppUseCase get getAboutAppUseCase => getIt<GetAboutAppUseCase>();
  static EditAboutAppUseCase get editAboutAppUseCase => getIt<EditAboutAppUseCase>();
  // endregion

  // region Service Description
  static GetServiceDescriptionUseCase get getServiceDescriptionUseCase => getIt<GetServiceDescriptionUseCase>();
  static EditServiceDescriptionUseCase get editServiceDescriptionUseCase => getIt<EditServiceDescriptionUseCase>();
  // endregion

  // region Privacy Policy
  static GetPrivacyPolicyUseCase get getPrivacyPolicyUseCase => getIt<GetPrivacyPolicyUseCase>();
  static EditPrivacyPolicyUseCase get editPrivacyPolicyUseCase => getIt<EditPrivacyPolicyUseCase>();
  // endregion

  // region Terms Of Use
  static GetTermsOfUseUseCase get getTermsOfUseUseCase => getIt<GetTermsOfUseUseCase>();
  static EditTermsOfUseUseCase get editTermsOfUseUseCase => getIt<EditTermsOfUseUseCase>();
  // endregion

  // region Sliders
  static GetSlidersUseCase get getSlidersUseCase => getIt<GetSlidersUseCase>();
  static GetSliderWithIdUseCase get getSliderWithIdUseCase => getIt<GetSliderWithIdUseCase>();
  static InsertSliderUseCase get insertSliderUseCase => getIt<InsertSliderUseCase>();
  static EditSliderUseCase get editSliderUseCase => getIt<EditSliderUseCase>();
  static DeleteSliderUseCase get deleteSliderUseCase => getIt<DeleteSliderUseCase>();
  // endregion

  // region Notifications
  static GetNotificationsUseCase get getNotificationsUseCase => getIt<GetNotificationsUseCase>();
  static GetNotificationWithIdUseCase get getNotificationWithIdUseCase => getIt<GetNotificationWithIdUseCase>();
  static InsertNotificationUseCase get insertNotificationUseCase => getIt<InsertNotificationUseCase>();
  static DeleteNotificationUseCase get deleteNotificationUseCase => getIt<DeleteNotificationUseCase>();
  // endregion

  // region Admin Notifications
  static GetAdminNotificationsUseCase get getAdminNotificationsUseCase => getIt<GetAdminNotificationsUseCase>();
  static GetAdminNotificationWithIdUseCase get getAdminNotificationWithIdUseCase => getIt<GetAdminNotificationWithIdUseCase>();
  static InsertAdminNotificationUseCase get insertAdminNotificationUseCase => getIt<InsertAdminNotificationUseCase>();
  static DeleteAdminNotificationUseCase get deleteAdminNotificationUseCase => getIt<DeleteAdminNotificationUseCase>();
  static SetIsViewedUseCase get setIsViewedUseCase => getIt<SetIsViewedUseCase>();
  // endregion

  // region Complaints
  static GetComplaintsUseCase get getComplaintsUseCase => getIt<GetComplaintsUseCase>();
  static GetComplaintWithIdUseCase get getComplaintWithIdUseCase => getIt<GetComplaintWithIdUseCase>();
  static InsertComplaintUseCase get insertComplaintUseCase => getIt<InsertComplaintUseCase>();
  static DeleteComplaintUseCase get deleteComplaintUseCase => getIt<DeleteComplaintUseCase>();
  // endregion

  // region Faqs
  static GetFaqsUseCase get getFaqsUseCase => getIt<GetFaqsUseCase>();
  static GetFaqWithIdUseCase get getFaqWithIdUseCase => getIt<GetFaqWithIdUseCase>();
  static InsertFaqUseCase get insertFaqUseCase => getIt<InsertFaqUseCase>();
  static EditFaqUseCase get editFaqUseCase => getIt<EditFaqUseCase>();
  static DeleteFaqUseCase get deleteFaqUseCase => getIt<DeleteFaqUseCase>();
  // endregion

  // region Articles
  static GetArticlesUseCase get getArticlesUseCase => getIt<GetArticlesUseCase>();
  static GetArticleWithIdUseCase get getArticleWithIdUseCase => getIt<GetArticleWithIdUseCase>();
  static InsertArticleUseCase get insertArticleUseCase => getIt<InsertArticleUseCase>();
  static EditArticleUseCase get editArticleUseCase => getIt<EditArticleUseCase>();
  static DeleteArticleUseCase get deleteArticleUseCase => getIt<DeleteArticleUseCase>();
  static IncrementArticleViewsUseCase get incrementArticleViewsUseCase => getIt<IncrementArticleViewsUseCase>();
  // endregion

  // region Social Media
  static GetSocialMediaUseCase get getSocialMediaUseCase => getIt<GetSocialMediaUseCase>();
  static GetSocialMediaWithIdUseCase get getSocialMediaWithIdUseCase => getIt<GetSocialMediaWithIdUseCase>();
  static InsertSocialMediaUseCase get insertSocialMediaUseCase => getIt<InsertSocialMediaUseCase>();
  static EditSocialMediaUseCase get editSocialMediaUseCase => getIt<EditSocialMediaUseCase>();
  static DeleteSocialMediaUseCase get deleteSocialMediaUseCase => getIt<DeleteSocialMediaUseCase>();
  // endregion

  // region Suggested Messages
  static GetSuggestedMessagesUseCase get getSuggestedMessagesUseCase => getIt<GetSuggestedMessagesUseCase>();
  static GetSuggestedMessageWithIdUseCase get getSuggestedMessageWithIdUseCase => getIt<GetSuggestedMessageWithIdUseCase>();
  static InsertSuggestedMessageUseCase get insertSuggestedMessageUseCase => getIt<InsertSuggestedMessageUseCase>();
  static EditSuggestedMessageUseCase get editSuggestedMessageUseCase => getIt<EditSuggestedMessageUseCase>();
  static DeleteSuggestedMessageUseCase get deleteSuggestedMessageUseCase => getIt<DeleteSuggestedMessageUseCase>();
  // endregion

  // region Wallet History
  static GetWalletHistoryUseCase get getWalletHistoryUseCase => getIt<GetWalletHistoryUseCase>();
  static GetWalletHistoryWithIdUseCase get getWalletHistoryWithIdUseCase => getIt<GetWalletHistoryWithIdUseCase>();
  static InsertWalletHistoryUseCase get insertWalletHistoryUseCase => getIt<InsertWalletHistoryUseCase>();
  static EditWalletHistoryUseCase get editWalletHistoryUseCase => getIt<EditWalletHistoryUseCase>();
  static DeleteWalletHistoryUseCase get deleteWalletHistoryUseCase => getIt<DeleteWalletHistoryUseCase>();
  // endregion

  // region Categories
  static GetCategoriesUseCase get getCategoriesUseCase => getIt<GetCategoriesUseCase>();
  static GetCategoryWithIdUseCase get getCategoryWithIdUseCase => getIt<GetCategoryWithIdUseCase>();
  static InsertCategoryUseCase get insertCategoryUseCase => getIt<InsertCategoryUseCase>();
  static EditCategoryUseCase get editCategoryUseCase => getIt<EditCategoryUseCase>();
  static DeleteCategoryUseCase get deleteCategoryUseCase => getIt<DeleteCategoryUseCase>();
  // endregion

  // region Main Categories
  static GetMainCategoriesUseCase get getMainCategoriesUseCase => getIt<GetMainCategoriesUseCase>();
  static GetMainCategoryWithIdUseCase get getMainCategoryWithIdUseCase => getIt<GetMainCategoryWithIdUseCase>();
  static InsertMainCategoryUseCase get insertMainCategoryUseCase => getIt<InsertMainCategoryUseCase>();
  static EditMainCategoryUseCase get editMainCategoryUseCase => getIt<EditMainCategoryUseCase>();
  static DeleteMainCategoryUseCase get deleteMainCategoryUseCase => getIt<DeleteMainCategoryUseCase>();
  // endregion

  // region Jobs
  static GetJobsUseCase get getJobsUseCase => getIt<GetJobsUseCase>();
  static GetJobWithIdUseCase get getJobWithIdUseCase => getIt<GetJobWithIdUseCase>();
  static InsertJobUseCase get insertJobUseCase => getIt<InsertJobUseCase>();
  static EditJobUseCase get editJobUseCase => getIt<EditJobUseCase>();
  static DeleteJobUseCase get deleteJobUseCase => getIt<DeleteJobUseCase>();
  static IncrementJobViewsUseCase get incrementJobViewsUseCase => getIt<IncrementJobViewsUseCase>();
  static ChangeJobStatusUseCase get changeJobStatusUseCase => getIt<ChangeJobStatusUseCase>();
  // endregion

  // region Employment Applications
  static GetEmploymentApplicationsUseCase get getEmploymentApplicationsUseCase => getIt<GetEmploymentApplicationsUseCase>();
  static GetEmploymentApplicationWithIdUseCase get getEmploymentApplicationWithIdUseCase => getIt<GetEmploymentApplicationWithIdUseCase>();
  static InsertEmploymentApplicationUseCase get insertEmploymentApplicationUseCase => getIt<InsertEmploymentApplicationUseCase>();
  static EditEmploymentApplicationUseCase get editEmploymentApplicationUseCase => getIt<EditEmploymentApplicationUseCase>();
  static DeleteEmploymentApplicationUseCase get deleteEmploymentApplicationUseCase => getIt<DeleteEmploymentApplicationUseCase>();
  // endregion

  // region Services
  static GetServicesUseCase get getServicesUseCase => getIt<GetServicesUseCase>();
  static GetServiceWithIdUseCase get getServiceWithIdUseCase => getIt<GetServiceWithIdUseCase>();
  static InsertServiceUseCase get insertServiceUseCase => getIt<InsertServiceUseCase>();
  static EditServiceUseCase get editServiceUseCase => getIt<EditServiceUseCase>();
  static DeleteServiceUseCase get deleteServiceUseCase => getIt<DeleteServiceUseCase>();
  // endregion

  // region Features
  static GetFeaturesUseCase get getFeaturesUseCase => getIt<GetFeaturesUseCase>();
  static GetFeatureWithIdUseCase get getFeatureWithIdUseCase => getIt<GetFeatureWithIdUseCase>();
  static InsertFeatureUseCase get insertFeatureUseCase => getIt<InsertFeatureUseCase>();
  static EditFeatureUseCase get editFeatureUseCase => getIt<EditFeatureUseCase>();
  static DeleteFeatureUseCase get deleteFeatureUseCase => getIt<DeleteFeatureUseCase>();
  // endregion

  // region Reviews
  static GetReviewsUseCase get getReviewsUseCase => getIt<GetReviewsUseCase>();
  static GetReviewWithIdUseCase get getReviewWithIdUseCase => getIt<GetReviewWithIdUseCase>();
  static InsertReviewUseCase get insertReviewUseCase => getIt<InsertReviewUseCase>();
  static EditReviewUseCase get editReviewUseCase => getIt<EditReviewUseCase>();
  static DeleteReviewUseCase get deleteReviewUseCase => getIt<DeleteReviewUseCase>();
  // endregion

  // region Playlists
  static GetPlaylistsUseCase get getPlaylistsUseCase => getIt<GetPlaylistsUseCase>();
  static GetPlaylistWithIdUseCase get getPlaylistWithIdUseCase => getIt<GetPlaylistWithIdUseCase>();
  static InsertPlaylistUseCase get insertPlaylistUseCase => getIt<InsertPlaylistUseCase>();
  static EditPlaylistUseCase get editPlaylistUseCase => getIt<EditPlaylistUseCase>();
  static DeletePlaylistUseCase get deletePlaylistUseCase => getIt<DeletePlaylistUseCase>();
  // endregion

  // region Videos
  static GetVideosUseCase get getVideosUseCase => getIt<GetVideosUseCase>();
  static GetVideoWithIdUseCase get getVideoWithIdUseCase => getIt<GetVideoWithIdUseCase>();
  static InsertVideoUseCase get insertVideoUseCase => getIt<InsertVideoUseCase>();
  static EditVideoUseCase get editVideoUseCase => getIt<EditVideoUseCase>();
  static DeleteVideoUseCase get deleteVideoUseCase => getIt<DeleteVideoUseCase>();
  // endregion

  // region Playlists Comments
  static GetPlaylistsCommentsUseCase get getPlaylistsCommentsUseCase => getIt<GetPlaylistsCommentsUseCase>();
  static GetPlaylistCommentWithIdUseCase get getPlaylistCommentWithIdUseCase => getIt<GetPlaylistCommentWithIdUseCase>();
  static InsertPlaylistCommentUseCase get insertPlaylistCommentUseCase => getIt<InsertPlaylistCommentUseCase>();
  static EditPlaylistCommentUseCase get editPlaylistCommentUseCase => getIt<EditPlaylistCommentUseCase>();
  static DeletePlaylistCommentUseCase get deletePlaylistCommentUseCase => getIt<DeletePlaylistCommentUseCase>();
  // endregion

  // region Phone Number Requests
  static GetPhoneNumberRequestsUseCase get getPhoneNumberRequestsUseCase => getIt<GetPhoneNumberRequestsUseCase>();
  static GetPhoneNumberRequestWithIdUseCase get getPhoneNumberRequestWithIdUseCase => getIt<GetPhoneNumberRequestWithIdUseCase>();
  static InsertPhoneNumberRequestUseCase get insertPhoneNumberRequestUseCase => getIt<InsertPhoneNumberRequestUseCase>();
  static EditPhoneNumberRequestUseCase get editPhoneNumberRequestUseCase => getIt<EditPhoneNumberRequestUseCase>();
  static DeletePhoneNumberRequestUseCase get deletePhoneNumberRequestUseCase => getIt<DeletePhoneNumberRequestUseCase>();
  // endregion

  // region Booking Appointments
  static GetBookingAppointmentsUseCase get getBookingAppointmentsUseCase => getIt<GetBookingAppointmentsUseCase>();
  static GetBookingAppointmentWithIdUseCase get getBookingAppointmentWithIdUseCase => getIt<GetBookingAppointmentWithIdUseCase>();
  static InsertBookingAppointmentUseCase get insertBookingAppointmentUseCase => getIt<InsertBookingAppointmentUseCase>();
  static EditBookingAppointmentUseCase get editBookingAppointmentUseCase => getIt<EditBookingAppointmentUseCase>();
  static DeleteBookingAppointmentUseCase get deleteBookingAppointmentUseCase => getIt<DeleteBookingAppointmentUseCase>();
  // endregion

  // region Instant Consultations
  static GetInstantConsultationsUseCase get getInstantConsultationsUseCase => getIt<GetInstantConsultationsUseCase>();
  static GetInstantConsultationWithIdUseCase get getInstantConsultationWithIdUseCase => getIt<GetInstantConsultationWithIdUseCase>();
  static InsertInstantConsultationUseCase get insertInstantConsultationUseCase => getIt<InsertInstantConsultationUseCase>();
  static EditInstantConsultationUseCase get editInstantConsultationUseCase => getIt<EditInstantConsultationUseCase>();
  static DeleteInstantConsultationUseCase get deleteInstantConsultationUseCase => getIt<DeleteInstantConsultationUseCase>();
  // endregion

  // region Instant Consultations Comments
  static GetInstantConsultationsCommentsUseCase get getInstantConsultationsCommentsUseCase => getIt<GetInstantConsultationsCommentsUseCase>();
  static GetInstantConsultationCommentWithIdUseCase get getInstantConsultationCommentWithIdUseCase => getIt<GetInstantConsultationCommentWithIdUseCase>();
  static InsertInstantConsultationCommentUseCase get insertInstantConsultationCommentUseCase => getIt<InsertInstantConsultationCommentUseCase>();
  static EditInstantConsultationCommentUseCase get editInstantConsultationCommentUseCase => getIt<EditInstantConsultationCommentUseCase>();
  static DeleteInstantConsultationCommentUseCase get deleteInstantConsultationCommentUseCase => getIt<DeleteInstantConsultationCommentUseCase>();
  // endregion

  // region Secret Consultations
  static GetSecretConsultationsUseCase get getSecretConsultationsUseCase => getIt<GetSecretConsultationsUseCase>();
  static GetSecretConsultationWithIdUseCase get getSecretConsultationWithIdUseCase => getIt<GetSecretConsultationWithIdUseCase>();
  static InsertSecretConsultationUseCase get insertSecretConsultationUseCase => getIt<InsertSecretConsultationUseCase>();
  static EditSecretConsultationUseCase get editSecretConsultationUseCase => getIt<EditSecretConsultationUseCase>();
  static DeleteSecretConsultationUseCase get deleteSecretConsultationUseCase => getIt<DeleteSecretConsultationUseCase>();
  // endregion

  // region Withdrawal Requests
  static GetWithdrawalRequestsUseCase get getWithdrawalRequestsUseCase => getIt<GetWithdrawalRequestsUseCase>();
  static GetWithdrawalRequestWithIdUseCase get getWithdrawalRequestWithIdUseCase => getIt<GetWithdrawalRequestWithIdUseCase>();
  static InsertWithdrawalRequestUseCase get insertWithdrawalRequestUseCase => getIt<InsertWithdrawalRequestUseCase>();
  static EditWithdrawalRequestUseCase get editWithdrawalRequestUseCase => getIt<EditWithdrawalRequestUseCase>();
  static DeleteWithdrawalRequestUseCase get deleteWithdrawalRequestUseCase => getIt<DeleteWithdrawalRequestUseCase>();
  // endregion

  // endregion
}