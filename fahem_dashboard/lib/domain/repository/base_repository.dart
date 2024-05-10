import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/data/models/account_model.dart';
import 'package:fahem_dashboard/data/models/admin_model.dart';
import 'package:fahem_dashboard/data/models/about_app_model.dart';
import 'package:fahem_dashboard/data/models/category_model.dart';
import 'package:fahem_dashboard/data/models/feature_model.dart';
import 'package:fahem_dashboard/data/models/job_model.dart';
import 'package:fahem_dashboard/data/models/employment_application_model.dart';
import 'package:fahem_dashboard/data/models/complaint_model.dart';
import 'package:fahem_dashboard/data/models/faq_model.dart';
import 'package:fahem_dashboard/data/models/phone_number_request_model.dart';
import 'package:fahem_dashboard/data/models/booking_appointment_model.dart';
import 'package:fahem_dashboard/data/models/instant_consultation_model.dart';
import 'package:fahem_dashboard/data/models/instant_consultation_comment_model.dart';
import 'package:fahem_dashboard/data/models/secret_consultation_model.dart';
import 'package:fahem_dashboard/data/models/article_model.dart';
import 'package:fahem_dashboard/data/models/main_category_model.dart';
import 'package:fahem_dashboard/data/models/notification_model.dart';
import 'package:fahem_dashboard/data/models/admin_notification_model.dart';
import 'package:fahem_dashboard/data/models/playlist_comment_model.dart';
import 'package:fahem_dashboard/data/models/playlist_model.dart';
import 'package:fahem_dashboard/data/models/privacy_policy_model.dart';
import 'package:fahem_dashboard/data/models/review_model.dart';
import 'package:fahem_dashboard/data/models/service_description_model.dart';
import 'package:fahem_dashboard/data/models/service_model.dart';
import 'package:fahem_dashboard/data/models/slider_model.dart';
import 'package:fahem_dashboard/data/models/social_media_model.dart';
import 'package:fahem_dashboard/data/models/statistic_model.dart';
import 'package:fahem_dashboard/data/models/suggested_message_model.dart';
import 'package:fahem_dashboard/data/models/terms_of_use_model.dart';
import 'package:fahem_dashboard/data/models/user_model.dart';
import 'package:fahem_dashboard/data/models/version_model.dart';
import 'package:fahem_dashboard/data/models/video_model.dart';
import 'package:fahem_dashboard/data/models/wallet_history_model.dart';
import 'package:fahem_dashboard/data/models/withdrawal_request_model.dart';
import 'package:fahem_dashboard/data/response/accounts_response.dart';
import 'package:fahem_dashboard/data/response/admins_response.dart';
import 'package:fahem_dashboard/data/response/categories_response.dart';
import 'package:fahem_dashboard/data/response/features_response.dart';
import 'package:fahem_dashboard/data/response/jobs_response.dart';
import 'package:fahem_dashboard/data/response/employment_applications_response.dart';
import 'package:fahem_dashboard/data/response/complaints_response.dart';
import 'package:fahem_dashboard/data/response/faqs_response.dart';
import 'package:fahem_dashboard/data/response/notifications_response.dart';
import 'package:fahem_dashboard/data/response/phone_number_requests_response.dart';
import 'package:fahem_dashboard/data/response/booking_appointments_response.dart';
import 'package:fahem_dashboard/data/response/instant_consultations_response.dart';
import 'package:fahem_dashboard/data/response/instant_consultations_comments_response.dart';
import 'package:fahem_dashboard/data/response/secret_consultations_response.dart';
import 'package:fahem_dashboard/data/response/articles_response.dart';
import 'package:fahem_dashboard/data/response/main_categories_response.dart';
import 'package:fahem_dashboard/data/response/admin_notifications_response.dart';
import 'package:fahem_dashboard/data/response/playlists_comments_response.dart';
import 'package:fahem_dashboard/data/response/playlists_response.dart';
import 'package:fahem_dashboard/data/response/reviews_response.dart';
import 'package:fahem_dashboard/data/response/services_response.dart';
import 'package:fahem_dashboard/data/response/sliders_response.dart';
import 'package:fahem_dashboard/data/response/social_media_response.dart';
import 'package:fahem_dashboard/data/response/suggested_messages_response.dart';
import 'package:fahem_dashboard/data/response/users_response.dart';
import 'package:fahem_dashboard/data/response/videos_response.dart';
import 'package:fahem_dashboard/data/response/wallet_history_response.dart';
import 'package:fahem_dashboard/data/response/withdrawal_requests_response.dart';
import 'package:fahem_dashboard/domain/usecases/accounts/delete_account_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/accounts/edit_account_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/accounts/get_accounts_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/accounts/insert_account_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/admin_notifications/set_is_viewed_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/admins/delete_admin_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/admins/edit_admin_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/admins/get_admins_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/admins/insert_admin_usecase.dart';
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
import 'package:fahem_dashboard/domain/usecases/authentication_user/delete_user_account_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_user/get_user_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_user/is_user_email_exist_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_user/is_user_exist_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_admin/delete_admin_account_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_admin/get_admin_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_admin/is_admin_email_exist_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_admin/is_admin_exist_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/about_app/edit_about_app_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/categories/delete_category_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/categories/edit_category_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/categories/get_categories_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/categories/get_category_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/categories/insert_category_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/chats/add_chat_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/chats/add_message_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/chats/update_message_mode_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/features/delete_feature_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/features/edit_feature_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/features/get_feature_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/features/get_features_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/features/insert_feature_usecase.dart';
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
import 'package:fahem_dashboard/domain/usecases/articles/increment_article_views_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_user/change_user_password_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_user/check_user_email_to_reset_password_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_user/edit_user_profile_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_user/login_user_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_user/register_user_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_user/reset_user_password_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_admin/change_admin_password_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_admin/check_admin_email_to_reset_password_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_admin/edit_admin_profile_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_admin/login_admin_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/authentication_admin/reset_admin_password_usecase.dart';
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
import 'package:fahem_dashboard/domain/usecases/articles/insert_article_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/main_categories/delete_main_category_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/main_categories/edit_main_category_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/main_categories/get_main_categories_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/main_categories/get_main_category_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/main_categories/insert_main_category_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/notifications/delete_notification_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/notifications/get_notification_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/notifications/get_notifications_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/notifications/insert_notification_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/admin_notifications/delete_admin_notification_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/admin_notifications/get_admin_notification_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/admin_notifications/get_admin_notifications_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/admin_notifications/insert_admin_notification_usecase.dart';
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
import 'package:fahem_dashboard/domain/usecases/privacy_policy/edit_privacy_policy_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/reviews/delete_review_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/reviews/edit_review_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/reviews/get_review_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/reviews/get_reviews_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/reviews/insert_review_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/service_description/edit_service_description_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/services/delete_service_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/services/edit_service_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/services/get_service_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/services/get_services_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/services/insert_service_usecase.dart';
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
import 'package:fahem_dashboard/domain/usecases/suggested_messages/delete_suggested_message_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/suggested_messages/edit_suggested_message_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/suggested_messages/get_suggested_message_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/suggested_messages/get_suggested_messages_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/suggested_messages/insert_suggested_message_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/terms_of_use/edit_terms_of_use_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/upload_file/upload_file_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/users/delete_user_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/users/edit_user_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/users/get_users_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/users/insert_user_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/version/edit_version_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/version/get_version_usecase.dart';
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

abstract class BaseRepository {

  // region Upload File
  Future<Either<Failure, String>> uploadFile(UploadFileParameters parameters);
  // endregion

  // region Version
  Future<Either<Failure, VersionModel>> getVersion(GetVersionParameters parameters);
  Future<Either<Failure, VersionModel>> editVersion(EditVersionParameters parameters);
  // endregion

  // region Authentication Admin
  Future<Either<Failure, AdminModel>> loginAdmin(LoginAdminParameters parameters);
  Future<Either<Failure, bool>> checkAdminEmailToResetPassword(CheckAdminEmailToResetPasswordParameters parameters);
  Future<Either<Failure, AdminModel>> resetAdminPassword(ResetAdminPasswordParameters parameters);
  Future<Either<Failure, AdminModel>> changeAdminPassword(ChangeAdminPasswordParameters parameters);
  Future<Either<Failure, AdminModel>> editAdminProfile(EditAdminProfileParameters parameters);
  Future<Either<Failure, AdminModel>> getAdminWithId(GetAdminWithIdParameters parameters);
  Future<Either<Failure, bool>> isAdminExist(IsAdminExistParameters parameters);
  Future<Either<Failure, bool>> isAdminEmailExist(IsAdminEmailExistParameters parameters);
  Future<Either<Failure, void>> deleteAdminAccount(DeleteAdminAccountParameters parameters);
  // endregion

  // region Authentication User
  Future<Either<Failure, UserModel>> loginUser(LoginUserParameters parameters);
  Future<Either<Failure, UserModel>> registerUser(RegisterUserParameters parameters);
  Future<Either<Failure, bool>> checkUserEmailToResetPassword(CheckUserEmailToResetPasswordParameters parameters);
  Future<Either<Failure, UserModel>> resetUserPassword(ResetUserPasswordParameters parameters);
  Future<Either<Failure, UserModel>> changeUserPassword(ChangeUserPasswordParameters parameters);
  Future<Either<Failure, UserModel>> editUserProfile(EditUserProfileParameters parameters);
  Future<Either<Failure, UserModel>> getUserWithId(GetUserWithIdParameters parameters);
  Future<Either<Failure, bool>> isUserExist(IsUserExistParameters parameters);
  Future<Either<Failure, bool>> isUserEmailExist(IsUserEmailExistParameters parameters);
  Future<Either<Failure, void>> deleteUserAccount(DeleteUserAccountParameters parameters);
  // endregion

  // region Authentication Account
  Future<Either<Failure, AccountModel>> loginAccount(LoginAccountParameters parameters);
  Future<Either<Failure, AccountModel>> registerAccount(RegisterAccountParameters parameters);
  Future<Either<Failure, bool>> checkAccountEmailToResetPassword(CheckAccountEmailToResetPasswordParameters parameters);
  Future<Either<Failure, AccountModel>> resetAccountPassword(ResetAccountPasswordParameters parameters);
  Future<Either<Failure, AccountModel>> changeAccountPassword(ChangeAccountPasswordParameters parameters);
  Future<Either<Failure, AccountModel>> editAccountProfile(EditAccountProfileParameters parameters);
  Future<Either<Failure, AccountModel>> getAccountWithId(GetAccountWithIdParameters parameters);
  Future<Either<Failure, bool>> isAccountExist(IsAccountExistParameters parameters);
  Future<Either<Failure, bool>> isAccountEmailExist(IsAccountEmailExistParameters parameters);
  Future<Either<Failure, void>> deleteAccountAccount(DeleteAccountAccountParameters parameters);
  // endregion

  // region Admins
  Future<Either<Failure, AdminsResponse>> getAdmins(GetAdminsParameters parameters);
  Future<Either<Failure, AdminModel>> insertAdmin(InsertAdminParameters parameters);
  Future<Either<Failure, AdminModel>> editAdmin(EditAdminParameters parameters);
  Future<Either<Failure, void>> deleteAdmin(DeleteAdminParameters parameters);
  // endregion

  // region Users
  Future<Either<Failure, UsersResponse>> getUsers(GetUsersParameters parameters);
  Future<Either<Failure, UserModel>> insertUser(InsertUserParameters parameters);
  Future<Either<Failure, UserModel>> editUser(EditUserParameters parameters);
  Future<Either<Failure, void>> deleteUser(DeleteUserParameters parameters);
  // endregion

  // region Accounts
  Future<Either<Failure, AccountsResponse>> getAccounts(GetAccountsParameters parameters);
  Future<Either<Failure, AccountModel>> insertAccount(InsertAccountParameters parameters);
  Future<Either<Failure, AccountModel>> editAccount(EditAccountParameters parameters);
  Future<Either<Failure, void>> deleteAccount(DeleteAccountParameters parameters);
  // endregion

  // region Statistics
  Future<Either<Failure, List<StatisticModel>>> getAdminStatistics(GetAdminStatisticsParameters parameters);
  // endregion

  // region About App
  Future<Either<Failure, AboutAppModel>> getAboutApp();
  Future<Either<Failure, AboutAppModel>> editAboutApp(EditAboutAppParameters parameters);
  // endregion

  // region Service Description
  Future<Either<Failure, ServiceDescriptionModel>> getServiceDescription();
  Future<Either<Failure, ServiceDescriptionModel>> editServiceDescription(EditServiceDescriptionParameters parameters);
  // endregion

  // region Privacy Policy
  Future<Either<Failure, PrivacyPolicyModel>> getPrivacyPolicy();
  Future<Either<Failure, PrivacyPolicyModel>> editPrivacyPolicy(EditPrivacyPolicyParameters parameters);
  // endregion

  // region Terms Of Use
  Future<Either<Failure, TermsOfUseModel>> getTermsOfUse();
  Future<Either<Failure, TermsOfUseModel>> editTermsOfUse(EditTermsOfUseParameters parameters);
  // endregion

  // region Sliders
  Future<Either<Failure, SlidersResponse>> getSliders(GetSlidersParameters parameters);
  Future<Either<Failure, SliderModel>> getSliderWithId(GetSliderWithIdParameters parameters);
  Future<Either<Failure, SliderModel>> insertSlider(InsertSliderParameters parameters);
  Future<Either<Failure, SliderModel>> editSlider(EditSliderParameters parameters);
  Future<Either<Failure, void>> deleteSlider(DeleteSliderParameters parameters);
  // endregion

  // region Notifications
  Future<Either<Failure, NotificationsResponse>> getNotifications(GetNotificationsParameters parameters);
  Future<Either<Failure, NotificationModel>> getNotificationWithId(GetNotificationWithIdParameters parameters);
  Future<Either<Failure, NotificationModel>> insertNotification(InsertNotificationParameters parameters);
  Future<Either<Failure, void>> deleteNotification(DeleteNotificationParameters parameters);
  // endregion

  // region Admin Notifications
  Future<Either<Failure, AdminNotificationsResponse>> getAdminNotifications(GetAdminNotificationsParameters parameters);
  Future<Either<Failure, AdminNotificationModel>> getAdminNotificationWithId(GetAdminNotificationWithIdParameters parameters);
  Future<Either<Failure, AdminNotificationModel>> insertAdminNotification(InsertAdminNotificationParameters parameters);
  Future<Either<Failure, void>> deleteAdminNotification(DeleteAdminNotificationParameters parameters);
  Future<Either<Failure, bool>> setIsViewed(SetIsViewedParameters parameters);
  // endregion

  // region Complaints
  Future<Either<Failure, ComplaintsResponse>> getComplaints(GetComplaintsParameters parameters);
  Future<Either<Failure, ComplaintModel>> getComplaintWithId(GetComplaintWithIdParameters parameters);
  Future<Either<Failure, ComplaintModel>> insertComplaint(InsertComplaintParameters parameters);
  Future<Either<Failure, void>> deleteComplaint(DeleteComplaintParameters parameters);
  // endregion

  // region Faqs
  Future<Either<Failure, FaqsResponse>> getFaqs(GetFaqsParameters parameters);
  Future<Either<Failure, FaqModel>> getFaqWithId(GetFaqWithIdParameters parameters);
  Future<Either<Failure, FaqModel>> insertFaq(InsertFaqParameters parameters);
  Future<Either<Failure, FaqModel>> editFaq(EditFaqParameters parameters);
  Future<Either<Failure, void>> deleteFaq(DeleteFaqParameters parameters);
  // endregion

  // region Articles
  Future<Either<Failure, ArticlesResponse>> getArticles(GetArticlesParameters parameters);
  Future<Either<Failure, ArticleModel>> getArticleWithId(GetArticleWithIdParameters parameters);
  Future<Either<Failure, ArticleModel>> insertArticle(InsertArticleParameters parameters);
  Future<Either<Failure, ArticleModel>> editArticle(EditArticleParameters parameters);
  Future<Either<Failure, void>> deleteArticle(DeleteArticleParameters parameters);
  Future<Either<Failure, ArticleModel>> incrementArticleViews(IncrementArticleViewsParameters parameters);
  // endregion

  // region Social Media
  Future<Either<Failure, SocialMediaResponse>> getSocialMedia(GetSocialMediaParameters parameters);
  Future<Either<Failure, SocialMediaModel>> getSocialMediaWithId(GetSocialMediaWithIdParameters parameters);
  Future<Either<Failure, SocialMediaModel>> insertSocialMedia(InsertSocialMediaParameters parameters);
  Future<Either<Failure, SocialMediaModel>> editSocialMedia(EditSocialMediaParameters parameters);
  Future<Either<Failure, void>> deleteSocialMedia(DeleteSocialMediaParameters parameters);
  // endregion

  // region Suggested Messages
  Future<Either<Failure, SuggestedMessagesResponse>> getSuggestedMessages(GetSuggestedMessagesParameters parameters);
  Future<Either<Failure, SuggestedMessageModel>> getSuggestedMessageWithId(GetSuggestedMessageWithIdParameters parameters);
  Future<Either<Failure, SuggestedMessageModel>> insertSuggestedMessage(InsertSuggestedMessageParameters parameters);
  Future<Either<Failure, SuggestedMessageModel>> editSuggestedMessage(EditSuggestedMessageParameters parameters);
  Future<Either<Failure, void>> deleteSuggestedMessage(DeleteSuggestedMessageParameters parameters);
  // endregion

  // region Wallet history
  Future<Either<Failure, WalletHistoryResponse>> getWalletHistory(GetWalletHistoryParameters parameters);
  Future<Either<Failure, WalletHistoryModel>> getWalletHistoryWithId(GetWalletHistoryWithIdParameters parameters);
  Future<Either<Failure, WalletHistoryModel>> insertWalletHistory(InsertWalletHistoryParameters parameters);
  Future<Either<Failure, WalletHistoryModel>> editWalletHistory(EditWalletHistoryParameters parameters);
  Future<Either<Failure, void>> deleteWalletHistory(DeleteWalletHistoryParameters parameters);
  // endregion

  // region Categories
  Future<Either<Failure, CategoriesResponse>> getCategories(GetCategoriesParameters parameters);
  Future<Either<Failure, CategoryModel>> getCategoryWithId(GetCategoryWithIdParameters parameters);
  Future<Either<Failure, CategoryModel>> insertCategory(InsertCategoryParameters parameters);
  Future<Either<Failure, CategoryModel>> editCategory(EditCategoryParameters parameters);
  Future<Either<Failure, void>> deleteCategory(DeleteCategoryParameters parameters);
  // endregion

  // region Main Categories
  Future<Either<Failure, MainCategoriesResponse>> getMainCategories(GetMainCategoriesParameters parameters);
  Future<Either<Failure, MainCategoryModel>> getMainCategoryWithId(GetMainCategoryWithIdParameters parameters);
  Future<Either<Failure, MainCategoryModel>> insertMainCategory(InsertMainCategoryParameters parameters);
  Future<Either<Failure, MainCategoryModel>> editMainCategory(EditMainCategoryParameters parameters);
  Future<Either<Failure, void>> deleteMainCategory(DeleteMainCategoryParameters parameters);
  // endregion

  // region Jobs
  Future<Either<Failure, JobsResponse>> getJobs(GetJobsParameters parameters);
  Future<Either<Failure, JobModel>> getJobWithId(GetJobWithIdParameters parameters);
  Future<Either<Failure, JobModel>> insertJob(InsertJobParameters parameters);
  Future<Either<Failure, JobModel>> editJob(EditJobParameters parameters);
  Future<Either<Failure, void>> deleteJob(DeleteJobParameters parameters);
  Future<Either<Failure, JobModel>> incrementJobViews(IncrementJobViewsParameters parameters);
  Future<Either<Failure, JobModel>> changeJobStatus(ChangeJobStatusParameters parameters);
  // endregion

  // region Employment Applications
  Future<Either<Failure, EmploymentApplicationsResponse>> getEmploymentApplications(GetEmploymentApplicationsParameters parameters);
  Future<Either<Failure, EmploymentApplicationModel>> getEmploymentApplicationWithId(GetEmploymentApplicationWithIdParameters parameters);
  Future<Either<Failure, EmploymentApplicationModel>> insertEmploymentApplication(InsertEmploymentApplicationParameters parameters);
  Future<Either<Failure, EmploymentApplicationModel>> editEmploymentApplication(EditEmploymentApplicationParameters parameters);
  Future<Either<Failure, void>> deleteEmploymentApplication(DeleteEmploymentApplicationParameters parameters);
  // endregion

  // region Services
  Future<Either<Failure, ServicesResponse>> getServices(GetServicesParameters parameters);
  Future<Either<Failure, ServiceModel>> getServiceWithId(GetServiceWithIdParameters parameters);
  Future<Either<Failure, ServiceModel>> insertService(InsertServiceParameters parameters);
  Future<Either<Failure, ServiceModel>> editService(EditServiceParameters parameters);
  Future<Either<Failure, void>> deleteService(DeleteServiceParameters parameters);
  // endregion

  // region Features
  Future<Either<Failure, FeaturesResponse>> getFeatures(GetFeaturesParameters parameters);
  Future<Either<Failure, FeatureModel>> getFeatureWithId(GetFeatureWithIdParameters parameters);
  Future<Either<Failure, FeatureModel>> insertFeature(InsertFeatureParameters parameters);
  Future<Either<Failure, FeatureModel>> editFeature(EditFeatureParameters parameters);
  Future<Either<Failure, void>> deleteFeature(DeleteFeatureParameters parameters);
  // endregion

  // region Reviews
  Future<Either<Failure, ReviewsResponse>> getReviews(GetReviewsParameters parameters);
  Future<Either<Failure, ReviewModel>> getReviewWithId(GetReviewWithIdParameters parameters);
  Future<Either<Failure, ReviewModel>> insertReview(InsertReviewParameters parameters);
  Future<Either<Failure, ReviewModel>> editReview(EditReviewParameters parameters);
  Future<Either<Failure, void>> deleteReview(DeleteReviewParameters parameters);
  // endregion

  // region Playlists
  Future<Either<Failure, PlaylistsResponse>> getPlaylists(GetPlaylistsParameters parameters);
  Future<Either<Failure, PlaylistModel>> getPlaylistWithId(GetPlaylistWithIdParameters parameters);
  Future<Either<Failure, PlaylistModel>> insertPlaylist(InsertPlaylistParameters parameters);
  Future<Either<Failure, PlaylistModel>> editPlaylist(EditPlaylistParameters parameters);
  Future<Either<Failure, void>> deletePlaylist(DeletePlaylistParameters parameters);
  // endregion

  // region Videos
  Future<Either<Failure, VideosResponse>> getVideos(GetVideosParameters parameters);
  Future<Either<Failure, VideoModel>> getVideoWithId(GetVideoWithIdParameters parameters);
  Future<Either<Failure, VideoModel>> insertVideo(InsertVideoParameters parameters);
  Future<Either<Failure, VideoModel>> editVideo(EditVideoParameters parameters);
  Future<Either<Failure, void>> deleteVideo(DeleteVideoParameters parameters);
  // endregion

  // region Playlists Comments
  Future<Either<Failure, PlaylistsCommentsResponse>> getPlaylistsComments(GetPlaylistsCommentsParameters parameters);
  Future<Either<Failure, PlaylistCommentModel>> getPlaylistCommentWithId(GetPlaylistCommentWithIdParameters parameters);
  Future<Either<Failure, PlaylistCommentModel>> insertPlaylistComment(InsertPlaylistCommentParameters parameters);
  Future<Either<Failure, PlaylistCommentModel>> editPlaylistComment(EditPlaylistCommentParameters parameters);
  Future<Either<Failure, void>> deletePlaylistComment(DeletePlaylistCommentParameters parameters);
  // endregion

  // region Phone Number Requests
  Future<Either<Failure, PhoneNumberRequestsResponse>> getPhoneNumberRequests(GetPhoneNumberRequestsParameters parameters);
  Future<Either<Failure, PhoneNumberRequestModel>> getPhoneNumberRequestWithId(GetPhoneNumberRequestWithIdParameters parameters);
  Future<Either<Failure, PhoneNumberRequestModel>> insertPhoneNumberRequest(InsertPhoneNumberRequestParameters parameters);
  Future<Either<Failure, PhoneNumberRequestModel>> editPhoneNumberRequest(EditPhoneNumberRequestParameters parameters);
  Future<Either<Failure, void>> deletePhoneNumberRequest(DeletePhoneNumberRequestParameters parameters);
  // endregion

  // region Booking Appointments
  Future<Either<Failure, BookingAppointmentsResponse>> getBookingAppointments(GetBookingAppointmentsParameters parameters);
  Future<Either<Failure, BookingAppointmentModel>> getBookingAppointmentWithId(GetBookingAppointmentWithIdParameters parameters);
  Future<Either<Failure, BookingAppointmentModel>> insertBookingAppointment(InsertBookingAppointmentParameters parameters);
  Future<Either<Failure, BookingAppointmentModel>> editBookingAppointment(EditBookingAppointmentParameters parameters);
  Future<Either<Failure, void>> deleteBookingAppointment(DeleteBookingAppointmentParameters parameters);
  // endregion

  // region Instant Consultations
  Future<Either<Failure, InstantConsultationsResponse>> getInstantConsultations(GetInstantConsultationsParameters parameters);
  Future<Either<Failure, InstantConsultationModel>> getInstantConsultationWithId(GetInstantConsultationWithIdParameters parameters);
  Future<Either<Failure, InstantConsultationModel>> insertInstantConsultation(InsertInstantConsultationParameters parameters);
  Future<Either<Failure, InstantConsultationModel>> editInstantConsultation(EditInstantConsultationParameters parameters);
  Future<Either<Failure, void>> deleteInstantConsultation(DeleteInstantConsultationParameters parameters);
  // endregion

  // region Instant Consultations Comments
  Future<Either<Failure, InstantConsultationsCommentsResponse>> getInstantConsultationsComments(GetInstantConsultationsCommentsParameters parameters);
  Future<Either<Failure, InstantConsultationCommentModel>> getInstantConsultationCommentWithId(GetInstantConsultationCommentWithIdParameters parameters);
  Future<Either<Failure, InstantConsultationCommentModel>> insertInstantConsultationComment(InsertInstantConsultationCommentParameters parameters);
  Future<Either<Failure, InstantConsultationCommentModel>> editInstantConsultationComment(EditInstantConsultationCommentParameters parameters);
  Future<Either<Failure, void>> deleteInstantConsultationComment(DeleteInstantConsultationCommentParameters parameters);
  // endregion

  // region Secret Consultations
  Future<Either<Failure, SecretConsultationsResponse>> getSecretConsultations(GetSecretConsultationsParameters parameters);
  Future<Either<Failure, SecretConsultationModel>> getSecretConsultationWithId(GetSecretConsultationWithIdParameters parameters);
  Future<Either<Failure, SecretConsultationModel>> insertSecretConsultation(InsertSecretConsultationParameters parameters);
  Future<Either<Failure, SecretConsultationModel>> editSecretConsultation(EditSecretConsultationParameters parameters);
  Future<Either<Failure, void>> deleteSecretConsultation(DeleteSecretConsultationParameters parameters);
  // endregion

  // region Withdrawal Requests
  Future<Either<Failure, WithdrawalRequestsResponse>> getWithdrawalRequests(GetWithdrawalRequestsParameters parameters);
  Future<Either<Failure, WithdrawalRequestModel>> getWithdrawalRequestWithId(GetWithdrawalRequestWithIdParameters parameters);
  Future<Either<Failure, WithdrawalRequestModel>> insertWithdrawalRequest(InsertWithdrawalRequestParameters parameters);
  Future<Either<Failure, WithdrawalRequestModel>> editWithdrawalRequest(EditWithdrawalRequestParameters parameters);
  Future<Either<Failure, void>> deleteWithdrawalRequest(DeleteWithdrawalRequestParameters parameters);
  // endregion

  // region Firebase
  Future<Either<Failure, void>> addChat(AddChatParameters parameters);
  Future<Either<Failure, void>> addMessage(AddMessageParameters parameters);
  Future<Either<Failure, void>> updateMessageMode(UpdateMessageModeParameters parameters);
  // endregion
}