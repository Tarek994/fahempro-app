import 'package:fahem_business/data/models/account_model.dart';
import 'package:fahem_business/data/models/feature_model.dart';
import 'package:fahem_business/data/models/main_category_model.dart';
import 'package:fahem_business/data/models/playlist_comment_model.dart';
import 'package:fahem_business/data/models/playlist_model.dart';
import 'package:fahem_business/data/models/review_model.dart';
import 'package:fahem_business/data/models/service_description_model.dart';
import 'package:fahem_business/data/models/service_model.dart';
import 'package:fahem_business/data/models/statistic_model.dart';
import 'package:fahem_business/data/models/suggested_message_model.dart';
import 'package:fahem_business/data/models/user_model.dart';
import 'package:fahem_business/data/models/admin_model.dart';
import 'package:fahem_business/data/models/video_model.dart';
import 'package:fahem_business/data/models/wallet_history_model.dart';
import 'package:fahem_business/data/models/withdrawal_request_model.dart';
import 'package:fahem_business/data/response/accounts_response.dart';
import 'package:fahem_business/data/response/admins_response.dart';
import 'package:fahem_business/data/response/features_response.dart';
import 'package:fahem_business/data/response/main_categories_response.dart';
import 'package:fahem_business/data/response/playlists_comments_response.dart';
import 'package:fahem_business/data/response/playlists_response.dart';
import 'package:fahem_business/data/response/reviews_response.dart';
import 'package:fahem_business/data/response/services_response.dart';
import 'package:fahem_business/data/response/social_media_response.dart';
import 'package:fahem_business/data/response/suggested_messages_response.dart';
import 'package:fahem_business/data/response/users_response.dart';
import 'package:fahem_business/data/response/videos_response.dart';
import 'package:fahem_business/data/response/wallet_history_response.dart';
import 'package:fahem_business/data/response/withdrawal_requests_response.dart';
import 'package:fahem_business/domain/usecases/accounts/delete_account_usecase.dart';
import 'package:fahem_business/domain/usecases/accounts/edit_account_usecase.dart';
import 'package:fahem_business/domain/usecases/accounts/get_accounts_usecase.dart';
import 'package:fahem_business/domain/usecases/accounts/insert_account_usecase.dart';
import 'package:fahem_business/domain/usecases/admin_notifications/set_is_viewed_usecase.dart';
import 'package:fahem_business/domain/usecases/admins/delete_admin_usecase.dart';
import 'package:fahem_business/domain/usecases/admins/edit_admin_usecase.dart';
import 'package:fahem_business/domain/usecases/admins/get_admins_usecase.dart';
import 'package:fahem_business/domain/usecases/admins/insert_admin_usecase.dart';
import 'package:fahem_business/domain/usecases/authentication_account/change_account_password_usecase.dart';
import 'package:fahem_business/domain/usecases/authentication_account/check_account_email_to_reset_password_usecase.dart';
import 'package:fahem_business/domain/usecases/authentication_account/delete_account_account_usecase.dart';
import 'package:fahem_business/domain/usecases/authentication_account/edit_account_profile_usecase.dart';
import 'package:fahem_business/domain/usecases/authentication_account/get_account_with_id_usecase.dart';
import 'package:fahem_business/domain/usecases/authentication_account/is_account_email_exist_usecase.dart';
import 'package:fahem_business/domain/usecases/authentication_account/is_account_exist_usecase.dart';
import 'package:fahem_business/domain/usecases/authentication_account/login_account_usecase.dart';
import 'package:fahem_business/domain/usecases/authentication_account/register_account_usecase.dart';
import 'package:fahem_business/domain/usecases/authentication_account/reset_account_password_usecase.dart';
import 'package:fahem_business/domain/usecases/authentication_user/delete_user_account_usecase.dart';
import 'package:fahem_business/domain/usecases/authentication_user/get_user_with_id_usecase.dart';
import 'package:fahem_business/domain/usecases/authentication_user/is_user_email_exist_usecase.dart';
import 'package:fahem_business/domain/usecases/authentication_user/is_user_exist_usecase.dart';
import 'package:fahem_business/domain/usecases/authentication_admin/delete_admin_account_usecase.dart';
import 'package:fahem_business/domain/usecases/authentication_admin/get_admin_with_id_usecase.dart';
import 'package:fahem_business/domain/usecases/authentication_admin/is_admin_email_exist_usecase.dart';
import 'package:fahem_business/domain/usecases/authentication_admin/is_admin_exist_usecase.dart';
import 'package:fahem_business/domain/usecases/articles/increment_article_views_usecase.dart';
import 'package:fahem_business/domain/usecases/authentication_user/change_user_password_usecase.dart';
import 'package:fahem_business/domain/usecases/authentication_user/check_user_email_to_reset_password_usecase.dart';
import 'package:fahem_business/domain/usecases/authentication_user/edit_user_profile_usecase.dart';
import 'package:fahem_business/domain/usecases/authentication_user/login_user_usecase.dart';
import 'package:fahem_business/domain/usecases/authentication_user/register_user_usecase.dart';
import 'package:fahem_business/domain/usecases/authentication_user/reset_user_password_usecase.dart';
import 'package:fahem_business/domain/usecases/authentication_admin/change_admin_password_usecase.dart';
import 'package:fahem_business/domain/usecases/authentication_admin/check_admin_email_to_reset_password_usecase.dart';
import 'package:fahem_business/domain/usecases/authentication_admin/edit_admin_profile_usecase.dart';
import 'package:fahem_business/domain/usecases/authentication_admin/login_admin_usecase.dart';
import 'package:fahem_business/domain/usecases/authentication_admin/reset_admin_password_usecase.dart';
import 'package:fahem_business/domain/usecases/features/delete_feature_usecase.dart';
import 'package:fahem_business/domain/usecases/features/edit_feature_usecase.dart';
import 'package:fahem_business/domain/usecases/features/get_feature_with_id_usecase.dart';
import 'package:fahem_business/domain/usecases/features/get_features_usecase.dart';
import 'package:fahem_business/domain/usecases/features/insert_feature_usecase.dart';
import 'package:fahem_business/domain/usecases/jobs/change_job_status_usecase.dart';
import 'package:fahem_business/domain/usecases/jobs/increment_job_views_usecase.dart';
import 'package:fahem_business/domain/usecases/main_categories/delete_main_category_usecase.dart';
import 'package:fahem_business/domain/usecases/main_categories/edit_main_category_usecase.dart';
import 'package:fahem_business/domain/usecases/main_categories/get_main_categories_usecase.dart';
import 'package:fahem_business/domain/usecases/main_categories/get_main_category_with_id_usecase.dart';
import 'package:fahem_business/domain/usecases/main_categories/insert_main_category_usecase.dart';
import 'package:fahem_business/domain/usecases/playlists/delete_playlist_usecase.dart';
import 'package:fahem_business/domain/usecases/playlists/edit_playlist_usecase.dart';
import 'package:fahem_business/domain/usecases/playlists/get_playlist_with_id_usecase.dart';
import 'package:fahem_business/domain/usecases/playlists/get_playlists_usecase.dart';
import 'package:fahem_business/domain/usecases/playlists/insert_playlist_usecase.dart';
import 'package:fahem_business/domain/usecases/playlists_comments/delete_playlist_comment_usecase.dart';
import 'package:fahem_business/domain/usecases/playlists_comments/edit_playlist_comment_usecase.dart';
import 'package:fahem_business/domain/usecases/playlists_comments/get_playlist_comment_with_id_usecase.dart';
import 'package:fahem_business/domain/usecases/playlists_comments/get_playlists_comments_usecase.dart';
import 'package:fahem_business/domain/usecases/playlists_comments/insert_playlist_comment_usecase.dart';
import 'package:fahem_business/domain/usecases/reviews/delete_review_usecase.dart';
import 'package:fahem_business/domain/usecases/reviews/edit_review_usecase.dart';
import 'package:fahem_business/domain/usecases/reviews/get_review_with_id_usecase.dart';
import 'package:fahem_business/domain/usecases/reviews/get_reviews_usecase.dart';
import 'package:fahem_business/domain/usecases/reviews/insert_review_usecase.dart';
import 'package:fahem_business/domain/usecases/service_description/edit_service_description_usecase.dart';
import 'package:fahem_business/domain/usecases/services/delete_service_usecase.dart';
import 'package:fahem_business/domain/usecases/services/edit_service_usecase.dart';
import 'package:fahem_business/domain/usecases/services/get_service_with_id_usecase.dart';
import 'package:fahem_business/domain/usecases/services/get_services_usecase.dart';
import 'package:fahem_business/domain/usecases/services/insert_service_usecase.dart';
import 'package:fahem_business/domain/usecases/social_media/delete_social_media_usecase.dart';
import 'package:fahem_business/domain/usecases/social_media/get_social_media_usecase.dart';
import 'package:fahem_business/domain/usecases/social_media/get_social_media_with_id_usecase.dart';
import 'package:fahem_business/domain/usecases/articles/insert_article_usecase.dart';
import 'package:fahem_business/domain/usecases/social_media/insert_social_media_usecase.dart';
import 'package:fahem_business/core/network/api_constants.dart';
import 'package:fahem_business/data/models/about_app_model.dart';
import 'package:fahem_business/data/models/category_model.dart';
import 'package:fahem_business/data/models/job_model.dart';
import 'package:fahem_business/data/models/employment_application_model.dart';
import 'package:fahem_business/data/models/complaint_model.dart';
import 'package:fahem_business/data/models/faq_model.dart';
import 'package:fahem_business/data/models/phone_number_request_model.dart';
import 'package:fahem_business/data/models/booking_appointment_model.dart';
import 'package:fahem_business/data/models/instant_consultation_model.dart';
import 'package:fahem_business/data/models/instant_consultation_comment_model.dart';
import 'package:fahem_business/data/models/secret_consultation_model.dart';
import 'package:fahem_business/data/models/article_model.dart';
import 'package:fahem_business/data/models/notification_model.dart';
import 'package:fahem_business/data/models/admin_notification_model.dart';
import 'package:fahem_business/data/models/privacy_policy_model.dart';
import 'package:fahem_business/data/models/slider_model.dart';
import 'package:fahem_business/data/models/social_media_model.dart';
import 'package:fahem_business/data/models/terms_of_use_model.dart';
import 'package:fahem_business/data/models/version_model.dart';
import 'package:fahem_business/data/response/categories_response.dart';
import 'package:fahem_business/data/response/jobs_response.dart';
import 'package:fahem_business/data/response/employment_applications_response.dart';
import 'package:fahem_business/data/response/complaints_response.dart';
import 'package:fahem_business/data/response/faqs_response.dart';
import 'package:fahem_business/data/response/phone_number_requests_response.dart';
import 'package:fahem_business/data/response/booking_appointments_response.dart';
import 'package:fahem_business/data/response/instant_consultations_response.dart';
import 'package:fahem_business/data/response/instant_consultations_comments_response.dart';
import 'package:fahem_business/data/response/secret_consultations_response.dart';
import 'package:fahem_business/data/response/articles_response.dart';
import 'package:fahem_business/data/response/notifications_response.dart';
import 'package:fahem_business/data/response/admin_notifications_response.dart';
import 'package:fahem_business/data/response/sliders_response.dart';
import 'package:fahem_business/domain/usecases/about_app/edit_about_app_usecase.dart';
import 'package:fahem_business/domain/usecases/categories/delete_category_usecase.dart';
import 'package:fahem_business/domain/usecases/categories/edit_category_usecase.dart';
import 'package:fahem_business/domain/usecases/categories/get_categories_usecase.dart';
import 'package:fahem_business/domain/usecases/categories/get_category_with_id_usecase.dart';
import 'package:fahem_business/domain/usecases/categories/insert_category_usecase.dart';
import 'package:fahem_business/domain/usecases/jobs/delete_job_usecase.dart';
import 'package:fahem_business/domain/usecases/jobs/edit_job_usecase.dart';
import 'package:fahem_business/domain/usecases/jobs/get_jobs_usecase.dart';
import 'package:fahem_business/domain/usecases/jobs/get_job_with_id_usecase.dart';
import 'package:fahem_business/domain/usecases/jobs/insert_job_usecase.dart';
import 'package:fahem_business/domain/usecases/employment_applications/delete_employment_application_usecase.dart';
import 'package:fahem_business/domain/usecases/employment_applications/edit_employment_application_usecase.dart';
import 'package:fahem_business/domain/usecases/employment_applications/get_employment_applications_usecase.dart';
import 'package:fahem_business/domain/usecases/employment_applications/get_employment_application_with_id_usecase.dart';
import 'package:fahem_business/domain/usecases/employment_applications/insert_employment_application_usecase.dart';
import 'package:fahem_business/domain/usecases/complaints/delete_complaint_usecase.dart';
import 'package:fahem_business/domain/usecases/complaints/get_complaint_with_id_usecase.dart';
import 'package:fahem_business/domain/usecases/complaints/get_complaints_usecase.dart';
import 'package:fahem_business/domain/usecases/complaints/insert_complaint_usecase.dart';
import 'package:fahem_business/domain/usecases/faqs/delete_faq_usecase.dart';
import 'package:fahem_business/domain/usecases/faqs/edit_faq_usecase.dart';
import 'package:fahem_business/domain/usecases/faqs/get_faq_with_id_usecase.dart';
import 'package:fahem_business/domain/usecases/faqs/get_faqs_usecase.dart';
import 'package:fahem_business/domain/usecases/faqs/insert_faq_usecase.dart';
import 'package:fahem_business/domain/usecases/phone_number_requests/delete_phone_number_request_usecase.dart';
import 'package:fahem_business/domain/usecases/phone_number_requests/edit_phone_number_request_usecase.dart';
import 'package:fahem_business/domain/usecases/phone_number_requests/get_phone_number_request_with_id_usecase.dart';
import 'package:fahem_business/domain/usecases/phone_number_requests/get_phone_number_requests_usecase.dart';
import 'package:fahem_business/domain/usecases/phone_number_requests/insert_phone_number_request_usecase.dart';
import 'package:fahem_business/domain/usecases/booking_appointments/delete_booking_appointment_usecase.dart';
import 'package:fahem_business/domain/usecases/booking_appointments/edit_booking_appointment_usecase.dart';
import 'package:fahem_business/domain/usecases/booking_appointments/get_booking_appointment_with_id_usecase.dart';
import 'package:fahem_business/domain/usecases/booking_appointments/get_booking_appointments_usecase.dart';
import 'package:fahem_business/domain/usecases/booking_appointments/insert_booking_appointment_usecase.dart';
import 'package:fahem_business/domain/usecases/instant_consultations/delete_instant_consultation_usecase.dart';
import 'package:fahem_business/domain/usecases/instant_consultations/edit_instant_consultation_usecase.dart';
import 'package:fahem_business/domain/usecases/instant_consultations/get_instant_consultation_with_id_usecase.dart';
import 'package:fahem_business/domain/usecases/instant_consultations/get_instant_consultations_usecase.dart';
import 'package:fahem_business/domain/usecases/instant_consultations/insert_instant_consultation_usecase.dart';
import 'package:fahem_business/domain/usecases/instant_consultations_comments/delete_instant_consultation_comment_usecase.dart';
import 'package:fahem_business/domain/usecases/instant_consultations_comments/edit_instant_consultation_comment_usecase.dart';
import 'package:fahem_business/domain/usecases/instant_consultations_comments/get_instant_consultation_comment_with_id_usecase.dart';
import 'package:fahem_business/domain/usecases/instant_consultations_comments/get_instant_consultations_comments_usecase.dart';
import 'package:fahem_business/domain/usecases/instant_consultations_comments/insert_instant_consultation_comment_usecase.dart';
import 'package:fahem_business/domain/usecases/secret_consultations/delete_secret_consultation_usecase.dart';
import 'package:fahem_business/domain/usecases/secret_consultations/edit_secret_consultation_usecase.dart';
import 'package:fahem_business/domain/usecases/secret_consultations/get_secret_consultation_with_id_usecase.dart';
import 'package:fahem_business/domain/usecases/secret_consultations/get_secret_consultations_usecase.dart';
import 'package:fahem_business/domain/usecases/secret_consultations/insert_secret_consultation_usecase.dart';
import 'package:fahem_business/domain/usecases/articles/delete_article_usecase.dart';
import 'package:fahem_business/domain/usecases/articles/edit_article_usecase.dart';
import 'package:fahem_business/domain/usecases/articles/get_article_with_id_usecase.dart';
import 'package:fahem_business/domain/usecases/articles/get_articles_usecase.dart';
import 'package:fahem_business/domain/usecases/notifications/delete_notification_usecase.dart';
import 'package:fahem_business/domain/usecases/notifications/get_notification_with_id_usecase.dart';
import 'package:fahem_business/domain/usecases/notifications/get_notifications_usecase.dart';
import 'package:fahem_business/domain/usecases/notifications/insert_notification_usecase.dart';
import 'package:fahem_business/domain/usecases/admin_notifications/delete_admin_notification_usecase.dart';
import 'package:fahem_business/domain/usecases/admin_notifications/get_admin_notification_with_id_usecase.dart';
import 'package:fahem_business/domain/usecases/admin_notifications/get_admin_notifications_usecase.dart';
import 'package:fahem_business/domain/usecases/admin_notifications/insert_admin_notification_usecase.dart';
import 'package:fahem_business/domain/usecases/privacy_policy/edit_privacy_policy_usecase.dart';
import 'package:fahem_business/domain/usecases/sliders/delete_slider_usecase.dart';
import 'package:fahem_business/domain/usecases/sliders/edit_slider_usecase.dart';
import 'package:fahem_business/domain/usecases/sliders/get_slider_with_id_usecase.dart';
import 'package:fahem_business/domain/usecases/sliders/get_sliders_usecase.dart';
import 'package:fahem_business/domain/usecases/sliders/insert_slider_usecase.dart';
import 'package:fahem_business/domain/usecases/social_media/edit_social_media_usecase.dart';
import 'package:fahem_business/domain/usecases/statistics/get_account_statistics_usecase.dart';
import 'package:fahem_business/domain/usecases/statistics/get_admin_statistics_usecase.dart';
import 'package:fahem_business/domain/usecases/suggested_messages/delete_suggested_message_usecase.dart';
import 'package:fahem_business/domain/usecases/suggested_messages/edit_suggested_message_usecase.dart';
import 'package:fahem_business/domain/usecases/suggested_messages/get_suggested_message_with_id_usecase.dart';
import 'package:fahem_business/domain/usecases/suggested_messages/get_suggested_messages_usecase.dart';
import 'package:fahem_business/domain/usecases/suggested_messages/insert_suggested_message_usecase.dart';
import 'package:fahem_business/domain/usecases/terms_of_use/edit_terms_of_use_usecase.dart';
import 'package:fahem_business/domain/usecases/upload_file/upload_file_usecase.dart';
import 'package:fahem_business/domain/usecases/users/delete_user_usecase.dart';
import 'package:fahem_business/domain/usecases/users/edit_user_usecase.dart';
import 'package:fahem_business/domain/usecases/users/get_users_usecase.dart';
import 'package:fahem_business/domain/usecases/users/insert_user_usecase.dart';
import 'package:fahem_business/domain/usecases/version/edit_version_usecase.dart';
import 'package:fahem_business/core/helper/http_helper.dart';
import 'package:fahem_business/domain/usecases/version/get_version_usecase.dart';
import 'package:fahem_business/domain/usecases/videos/delete_video_usecase.dart';
import 'package:fahem_business/domain/usecases/videos/edit_video_usecase.dart';
import 'package:fahem_business/domain/usecases/videos/get_video_with_id_usecase.dart';
import 'package:fahem_business/domain/usecases/videos/get_videos_usecase.dart';
import 'package:fahem_business/domain/usecases/videos/insert_video_usecase.dart';
import 'package:fahem_business/domain/usecases/wallet_history/delete_wallet_history_usecase.dart';
import 'package:fahem_business/domain/usecases/wallet_history/edit_wallet_history_usecase.dart';
import 'package:fahem_business/domain/usecases/wallet_history/get_wallet_history_usecase.dart';
import 'package:fahem_business/domain/usecases/wallet_history/get_wallet_history_with_id_usecase.dart';
import 'package:fahem_business/domain/usecases/wallet_history/insert_wallet_history_usecase.dart';
import 'package:fahem_business/domain/usecases/withdrawal_requests/delete_withdrawal_request_usecase.dart';
import 'package:fahem_business/domain/usecases/withdrawal_requests/edit_withdrawal_request_usecase.dart';
import 'package:fahem_business/domain/usecases/withdrawal_requests/get_withdrawal_request_with_id_usecase.dart';
import 'package:fahem_business/domain/usecases/withdrawal_requests/get_withdrawal_requests_usecase.dart';
import 'package:fahem_business/domain/usecases/withdrawal_requests/insert_withdrawal_request_usecase.dart';

abstract class BaseRemoteDataSource {

  // region Upload File
  Future<String> uploadFile(UploadFileParameters parameters);
  // endregion

  // region Version
  Future<VersionModel> getVersion(GetVersionParameters parameters);
  Future<VersionModel> editVersion(EditVersionParameters parameters);
  // endregion

  // region Authentication Admin
  Future<AdminModel> loginAdmin(LoginAdminParameters parameters);
  Future<bool> checkAdminEmailToResetPassword(CheckAdminEmailToResetPasswordParameters parameters);
  Future<AdminModel> resetAdminPassword(ResetAdminPasswordParameters parameters);
  Future<AdminModel> changeAdminPassword(ChangeAdminPasswordParameters parameters);
  Future<AdminModel> editAdminProfile(EditAdminProfileParameters parameters);
  Future<AdminModel> getAdminWithId(GetAdminWithIdParameters parameters);
  Future<bool> isAdminExist(IsAdminExistParameters parameters);
  Future<bool> isAdminEmailExist(IsAdminEmailExistParameters parameters);
  Future<void> deleteAdminAccount(DeleteAdminAccountParameters parameters);
  // endregion

  // region Authentication User
  Future<UserModel> loginUser(LoginUserParameters parameters);
  Future<UserModel> registerUser(RegisterUserParameters parameters);
  Future<bool> checkUserEmailToResetPassword(CheckUserEmailToResetPasswordParameters parameters);
  Future<UserModel> resetUserPassword(ResetUserPasswordParameters parameters);
  Future<UserModel> changeUserPassword(ChangeUserPasswordParameters parameters);
  Future<UserModel> editUserProfile(EditUserProfileParameters parameters);
  Future<UserModel> getUserWithId(GetUserWithIdParameters parameters);
  Future<bool> isUserExist(IsUserExistParameters parameters);
  Future<bool> isUserEmailExist(IsUserEmailExistParameters parameters);
  Future<void> deleteUserAccount(DeleteUserAccountParameters parameters);
  // endregion

  // region Authentication Account
  Future<AccountModel> loginAccount(LoginAccountParameters parameters);
  Future<AccountModel> registerAccount(RegisterAccountParameters parameters);
  Future<bool> checkAccountEmailToResetPassword(CheckAccountEmailToResetPasswordParameters parameters);
  Future<AccountModel> resetAccountPassword(ResetAccountPasswordParameters parameters);
  Future<AccountModel> changeAccountPassword(ChangeAccountPasswordParameters parameters);
  Future<AccountModel> editAccountProfile(EditAccountProfileParameters parameters);
  Future<AccountModel> getAccountWithId(GetAccountWithIdParameters parameters);
  Future<bool> isAccountExist(IsAccountExistParameters parameters);
  Future<bool> isAccountEmailExist(IsAccountEmailExistParameters parameters);
  Future<void> deleteAccountAccount(DeleteAccountAccountParameters parameters);
  // endregion

  // region Admins
  Future<AdminsResponse> getAdmins(GetAdminsParameters parameters);
  Future<AdminModel> insertAdmin(InsertAdminParameters parameters);
  Future<AdminModel> editAdmin(EditAdminParameters parameters);
  Future<void> deleteAdmin(DeleteAdminParameters parameters);
  // endregion

  // region Users
  Future<UsersResponse> getUsers(GetUsersParameters parameters);
  Future<UserModel> insertUser(InsertUserParameters parameters);
  Future<UserModel> editUser(EditUserParameters parameters);
  Future<void> deleteUser(DeleteUserParameters parameters);
  // endregion

  // region Accounts
  Future<AccountsResponse> getAccounts(GetAccountsParameters parameters);
  Future<AccountModel> insertAccount(InsertAccountParameters parameters);
  Future<AccountModel> editAccount(EditAccountParameters parameters);
  Future<void> deleteAccount(DeleteAccountParameters parameters);
  // endregion

  // region Statistics
  Future<List<StatisticModel>> getAdminStatistics(GetAdminStatisticsParameters parameters);
  Future<List<StatisticModel>> getAccountStatistics(GetAccountStatisticsParameters parameters);
  // endregion

  // region About App
  Future<AboutAppModel> getAboutApp();
  Future<AboutAppModel> editAboutApp(EditAboutAppParameters parameters);
  // endregion

  // region Service Description
  Future<ServiceDescriptionModel> getServiceDescription();
  Future<ServiceDescriptionModel> editServiceDescription(EditServiceDescriptionParameters parameters);
  // endregion

  // region Privacy Policy
  Future<PrivacyPolicyModel> getPrivacyPolicy();
  Future<PrivacyPolicyModel> editPrivacyPolicy(EditPrivacyPolicyParameters parameters);
  // endregion

  // region Terms Of Use
  Future<TermsOfUseModel> getTermsOfUse();
  Future<TermsOfUseModel> editTermsOfUse(EditTermsOfUseParameters parameters);
  // endregion

  // region Sliders
  Future<SlidersResponse> getSliders(GetSlidersParameters parameters);
  Future<SliderModel> getSliderWithId(GetSliderWithIdParameters parameters);
  Future<SliderModel> insertSlider(InsertSliderParameters parameters);
  Future<SliderModel> editSlider(EditSliderParameters parameters);
  Future<void> deleteSlider(DeleteSliderParameters parameters);
  // endregion

  // region Notifications
  Future<NotificationsResponse> getNotifications(GetNotificationsParameters parameters);
  Future<NotificationModel> getNotificationWithId(GetNotificationWithIdParameters parameters);
  Future<NotificationModel> insertNotification(InsertNotificationParameters parameters);
  Future<void> deleteNotification(DeleteNotificationParameters parameters);
  // endregion

  // region Admin Notifications
  Future<AdminNotificationsResponse> getAdminNotifications(GetAdminNotificationsParameters parameters);
  Future<AdminNotificationModel> getAdminNotificationWithId(GetAdminNotificationWithIdParameters parameters);
  Future<AdminNotificationModel> insertAdminNotification(InsertAdminNotificationParameters parameters);
  Future<void> deleteAdminNotification(DeleteAdminNotificationParameters parameters);
  Future<bool> setIsViewed(SetIsViewedParameters parameters);
  // endregion

  // region Complaints
  Future<ComplaintsResponse> getComplaints(GetComplaintsParameters parameters);
  Future<ComplaintModel> getComplaintWithId(GetComplaintWithIdParameters parameters);
  Future<ComplaintModel> insertComplaint(InsertComplaintParameters parameters);
  Future<void> deleteComplaint(DeleteComplaintParameters parameters);
  // endregion

  // region Faqs
  Future<FaqsResponse> getFaqs(GetFaqsParameters parameters);
  Future<FaqModel> getFaqWithId(GetFaqWithIdParameters parameters);
  Future<FaqModel> insertFaq(InsertFaqParameters parameters);
  Future<FaqModel> editFaq(EditFaqParameters parameters);
  Future<void> deleteFaq(DeleteFaqParameters parameters);
  // endregion

  // region Articles
  Future<ArticlesResponse> getArticles(GetArticlesParameters parameters);
  Future<ArticleModel> getArticleWithId(GetArticleWithIdParameters parameters);
  Future<ArticleModel> insertArticle(InsertArticleParameters parameters);
  Future<ArticleModel> editArticle(EditArticleParameters parameters);
  Future<void> deleteArticle(DeleteArticleParameters parameters);
  Future<ArticleModel> incrementArticleViews(IncrementArticleViewsParameters parameters);
  // endregion

  // region Social Media
  Future<SocialMediaResponse> getSocialMedia(GetSocialMediaParameters parameters);
  Future<SocialMediaModel> getSocialMediaWithId(GetSocialMediaWithIdParameters parameters);
  Future<SocialMediaModel> insertSocialMedia(InsertSocialMediaParameters parameters);
  Future<SocialMediaModel> editSocialMedia(EditSocialMediaParameters parameters);
  Future<void> deleteSocialMedia(DeleteSocialMediaParameters parameters);
  // endregion

  // region Suggested Messages
  Future<SuggestedMessagesResponse> getSuggestedMessages(GetSuggestedMessagesParameters parameters);
  Future<SuggestedMessageModel> getSuggestedMessageWithId(GetSuggestedMessageWithIdParameters parameters);
  Future<SuggestedMessageModel> insertSuggestedMessage(InsertSuggestedMessageParameters parameters);
  Future<SuggestedMessageModel> editSuggestedMessage(EditSuggestedMessageParameters parameters);
  Future<void> deleteSuggestedMessage(DeleteSuggestedMessageParameters parameters);
  // endregion

  // region Wallet History
  Future<WalletHistoryResponse> getWalletHistory(GetWalletHistoryParameters parameters);
  Future<WalletHistoryModel> getWalletHistoryWithId(GetWalletHistoryWithIdParameters parameters);
  Future<WalletHistoryModel> insertWalletHistory(InsertWalletHistoryParameters parameters);
  Future<WalletHistoryModel> editWalletHistory(EditWalletHistoryParameters parameters);
  Future<void> deleteWalletHistory(DeleteWalletHistoryParameters parameters);
  // endregion

  // region Categories
  Future<CategoriesResponse> getCategories(GetCategoriesParameters parameters);
  Future<CategoryModel> getCategoryWithId(GetCategoryWithIdParameters parameters);
  Future<CategoryModel> insertCategory(InsertCategoryParameters parameters);
  Future<CategoryModel> editCategory(EditCategoryParameters parameters);
  Future<void> deleteCategory(DeleteCategoryParameters parameters);
  // endregion

  // region Main Categories
  Future<MainCategoriesResponse> getMainCategories(GetMainCategoriesParameters parameters);
  Future<MainCategoryModel> getMainCategoryWithId(GetMainCategoryWithIdParameters parameters);
  Future<MainCategoryModel> insertMainCategory(InsertMainCategoryParameters parameters);
  Future<MainCategoryModel> editMainCategory(EditMainCategoryParameters parameters);
  Future<void> deleteMainCategory(DeleteMainCategoryParameters parameters);
  // endregion

  // region Jobs
  Future<JobsResponse> getJobs(GetJobsParameters parameters);
  Future<JobModel> getJobWithId(GetJobWithIdParameters parameters);
  Future<JobModel> insertJob(InsertJobParameters parameters);
  Future<JobModel> editJob(EditJobParameters parameters);
  Future<void> deleteJob(DeleteJobParameters parameters);
  Future<JobModel> incrementJobViews(IncrementJobViewsParameters parameters);
  Future<JobModel> changeJobStatus(ChangeJobStatusParameters parameters);
  // endregion

  // region Employment Applications
  Future<EmploymentApplicationsResponse> getEmploymentApplications(GetEmploymentApplicationsParameters parameters);
  Future<EmploymentApplicationModel> getEmploymentApplicationWithId(GetEmploymentApplicationWithIdParameters parameters);
  Future<EmploymentApplicationModel> insertEmploymentApplication(InsertEmploymentApplicationParameters parameters);
  Future<EmploymentApplicationModel> editEmploymentApplication(EditEmploymentApplicationParameters parameters);
  Future<void> deleteEmploymentApplication(DeleteEmploymentApplicationParameters parameters);
  // endregion

  // region Services
  Future<ServicesResponse> getServices(GetServicesParameters parameters);
  Future<ServiceModel> getServiceWithId(GetServiceWithIdParameters parameters);
  Future<ServiceModel> insertService(InsertServiceParameters parameters);
  Future<ServiceModel> editService(EditServiceParameters parameters);
  Future<void> deleteService(DeleteServiceParameters parameters);
  // endregion

  // region Features
  Future<FeaturesResponse> getFeatures(GetFeaturesParameters parameters);
  Future<FeatureModel> getFeatureWithId(GetFeatureWithIdParameters parameters);
  Future<FeatureModel> insertFeature(InsertFeatureParameters parameters);
  Future<FeatureModel> editFeature(EditFeatureParameters parameters);
  Future<void> deleteFeature(DeleteFeatureParameters parameters);
  // endregion

  // region Reviews
  Future<ReviewsResponse> getReviews(GetReviewsParameters parameters);
  Future<ReviewModel> getReviewWithId(GetReviewWithIdParameters parameters);
  Future<ReviewModel> insertReview(InsertReviewParameters parameters);
  Future<ReviewModel> editReview(EditReviewParameters parameters);
  Future<void> deleteReview(DeleteReviewParameters parameters);
  // endregion

  // region Playlists
  Future<PlaylistsResponse> getPlaylists(GetPlaylistsParameters parameters);
  Future<PlaylistModel> getPlaylistWithId(GetPlaylistWithIdParameters parameters);
  Future<PlaylistModel> insertPlaylist(InsertPlaylistParameters parameters);
  Future<PlaylistModel> editPlaylist(EditPlaylistParameters parameters);
  Future<void> deletePlaylist(DeletePlaylistParameters parameters);
  // endregion

  // region Videos
  Future<VideosResponse> getVideos(GetVideosParameters parameters);
  Future<VideoModel> getVideoWithId(GetVideoWithIdParameters parameters);
  Future<VideoModel> insertVideo(InsertVideoParameters parameters);
  Future<VideoModel> editVideo(EditVideoParameters parameters);
  Future<void> deleteVideo(DeleteVideoParameters parameters);
  // endregion

  // region Playlists Comments
  Future<PlaylistsCommentsResponse> getPlaylistsComments(GetPlaylistsCommentsParameters parameters);
  Future<PlaylistCommentModel> getPlaylistCommentWithId(GetPlaylistCommentWithIdParameters parameters);
  Future<PlaylistCommentModel> insertPlaylistComment(InsertPlaylistCommentParameters parameters);
  Future<PlaylistCommentModel> editPlaylistComment(EditPlaylistCommentParameters parameters);
  Future<void> deletePlaylistComment(DeletePlaylistCommentParameters parameters);
  // endregion

  // region Phone Number Requests
  Future<PhoneNumberRequestsResponse> getPhoneNumberRequests(GetPhoneNumberRequestsParameters parameters);
  Future<PhoneNumberRequestModel> getPhoneNumberRequestWithId(GetPhoneNumberRequestWithIdParameters parameters);
  Future<PhoneNumberRequestModel> insertPhoneNumberRequest(InsertPhoneNumberRequestParameters parameters);
  Future<PhoneNumberRequestModel> editPhoneNumberRequest(EditPhoneNumberRequestParameters parameters);
  Future<void> deletePhoneNumberRequest(DeletePhoneNumberRequestParameters parameters);
  // endregion

  // region Booking Appointments
  Future<BookingAppointmentsResponse> getBookingAppointments(GetBookingAppointmentsParameters parameters);
  Future<BookingAppointmentModel> getBookingAppointmentWithId(GetBookingAppointmentWithIdParameters parameters);
  Future<BookingAppointmentModel> insertBookingAppointment(InsertBookingAppointmentParameters parameters);
  Future<BookingAppointmentModel> editBookingAppointment(EditBookingAppointmentParameters parameters);
  Future<void> deleteBookingAppointment(DeleteBookingAppointmentParameters parameters);
  // endregion

  // region Instant Consultations
  Future<InstantConsultationsResponse> getInstantConsultations(GetInstantConsultationsParameters parameters);
  Future<InstantConsultationModel> getInstantConsultationWithId(GetInstantConsultationWithIdParameters parameters);
  Future<InstantConsultationModel> insertInstantConsultation(InsertInstantConsultationParameters parameters);
  Future<InstantConsultationModel> editInstantConsultation(EditInstantConsultationParameters parameters);
  Future<void> deleteInstantConsultation(DeleteInstantConsultationParameters parameters);
  // endregion

  // region Instant Consultations Comments
  Future<InstantConsultationsCommentsResponse> getInstantConsultationsComments(GetInstantConsultationsCommentsParameters parameters);
  Future<InstantConsultationCommentModel> getInstantConsultationCommentWithId(GetInstantConsultationCommentWithIdParameters parameters);
  Future<InstantConsultationCommentModel> insertInstantConsultationComment(InsertInstantConsultationCommentParameters parameters);
  Future<InstantConsultationCommentModel> editInstantConsultationComment(EditInstantConsultationCommentParameters parameters);
  Future<void> deleteInstantConsultationComment(DeleteInstantConsultationCommentParameters parameters);
  // endregion

  // region Secret Consultations
  Future<SecretConsultationsResponse> getSecretConsultations(GetSecretConsultationsParameters parameters);
  Future<SecretConsultationModel> getSecretConsultationWithId(GetSecretConsultationWithIdParameters parameters);
  Future<SecretConsultationModel> insertSecretConsultation(InsertSecretConsultationParameters parameters);
  Future<SecretConsultationModel> editSecretConsultation(EditSecretConsultationParameters parameters);
  Future<void> deleteSecretConsultation(DeleteSecretConsultationParameters parameters);
  // endregion

  // region Withdrawal Requests
  Future<WithdrawalRequestsResponse> getWithdrawalRequests(GetWithdrawalRequestsParameters parameters);
  Future<WithdrawalRequestModel> getWithdrawalRequestWithId(GetWithdrawalRequestWithIdParameters parameters);
  Future<WithdrawalRequestModel> insertWithdrawalRequest(InsertWithdrawalRequestParameters parameters);
  Future<WithdrawalRequestModel> editWithdrawalRequest(EditWithdrawalRequestParameters parameters);
  Future<void> deleteWithdrawalRequest(DeleteWithdrawalRequestParameters parameters);
  // endregion
}

class RemoteDataSource extends BaseRemoteDataSource {

  // region Upload File
  @override
  Future<String> uploadFile(UploadFileParameters parameters) async {
    var response = await HttpHelper.uploadFile(parameters: parameters);
    return response['image'];
  }
  // endregion

  // region Version
  @override
  Future<VersionModel> getVersion(GetVersionParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.appField: parameters.app.name,
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getVersionEndPoint,
      query: query,
      printErrorMessage: 'getVersionError',
    );
    return VersionModel.fromJson(response['version']);
  }

  @override
  Future<VersionModel> editVersion(EditVersionParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.appField: parameters.app.name,
      ApiConstants.versionField: parameters.version.toString(),
      ApiConstants.isForceUpdateField: parameters.isForceUpdate.toString(),
      ApiConstants.isClearCacheField: parameters.isClearCache.toString(),
      ApiConstants.isMaintenanceNowField: parameters.isMaintenanceNow.toString(),
      ApiConstants.inReviewField: parameters.inReview.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.editVersionEndPoint,
      body: body,
      printErrorMessage: 'editVersionError',
    );
    return VersionModel.fromJson(response['version']);
  }
  // endregion

  // region Authentication Admin
  @override
  Future<AdminModel> loginAdmin(LoginAdminParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.emailAddressField: parameters.emailAddress.toString(),
      ApiConstants.passwordField: parameters.password.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.loginAdminEndPoint,
      body: body,
      printErrorMessage: 'loginAdminError',
    );
    return AdminModel.fromJson(response['admin']);
  }

  @override
  Future<bool> checkAdminEmailToResetPassword(CheckAdminEmailToResetPasswordParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.emailAddressField: parameters.emailAddress.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.checkAdminEmailToResetPasswordEndPoint,
      body: body,
      printErrorMessage: 'checkAdminEmailToResetPasswordError',
    );
    return response['isAdminEmailExist'];
  }

  @override
  Future<AdminModel> resetAdminPassword(ResetAdminPasswordParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.emailAddressField: parameters.emailAddress.toString(),
      ApiConstants.passwordField: parameters.password.toString(),
    };

    var response = await HttpHelper.postData(
      endPoint: ApiConstants.resetAdminPasswordEndPoint,
      body: body,
      printErrorMessage: 'resetAdminPasswordError',
    );
    return AdminModel.fromJson(response['admin']);
  }

  @override
  Future<AdminModel> changeAdminPassword(ChangeAdminPasswordParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.adminIdField: parameters.adminId.toString(),
      ApiConstants.oldPasswordField: parameters.oldPassword.toString(),
      ApiConstants.newPasswordField: parameters.newPassword.toString(),
    };

    var response = await HttpHelper.postData(
      endPoint: ApiConstants.changeAdminPasswordEndPoint,
      body: body,
      printErrorMessage: 'changeAdminPasswordError',
    );
    return AdminModel.fromJson(response['admin']);
  }

  @override
  Future<AdminModel> editAdminProfile(EditAdminProfileParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.adminIdField: parameters.adminId.toString(),
      ApiConstants.fullNameField: parameters.fullName.toString(),
      ApiConstants.personalImageField: parameters.personalImage.toString(),
      ApiConstants.coverImageField: parameters.coverImage.toString(),
      ApiConstants.bioField: parameters.bio.toString(),
      ApiConstants.emailAddressField: parameters.emailAddress.toString(),
      ApiConstants.dialingCodeField: parameters.dialingCode.toString(),
      ApiConstants.phoneNumberField: parameters.phoneNumber.toString(),
      ApiConstants.birthDateField: parameters.birthDate.toString(),
      ApiConstants.countryIdField: parameters.countryId.toString(),
      ApiConstants.genderField: parameters.gender == null ? 'null' : parameters.gender!.name,
      ApiConstants.permissionsField: parameters.permissions.map((e) => e.name).join('--'),
      ApiConstants.isSuperField: parameters.isSuper.toString(),
    };

    var response = await HttpHelper.postData(
      endPoint: ApiConstants.editAdminProfileEndPoint,
      body: body,
      printErrorMessage: 'editAdminProfileError',
    );
    return AdminModel.fromJson(response['admin']);
  }

  @override
  Future<AdminModel> getAdminWithId(GetAdminWithIdParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.adminIdField: parameters.adminId.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getAdminWithIdEndPoint,
      query: query,
      printErrorMessage: 'getAdminWithIdError',
    );
    return AdminModel.fromJson(response['admin']);
  }

  @override
  Future<bool> isAdminExist(IsAdminExistParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.adminIdField: parameters.adminId.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.isAdminExistEndPoint,
      body: body,
      printErrorMessage: 'isAdminExistError',
    );
    return response['isExistAdmin'];
  }

  @override
  Future<bool> isAdminEmailExist(IsAdminEmailExistParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.emailAddressField: parameters.emailAddress.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.isAdminEmailExistEndPoint,
      body: body,
      printErrorMessage: 'isAdminEmailExistError',
    );
    return response['isAdminEmailExist'];
  }

  @override
  Future<void> deleteAdminAccount(DeleteAdminAccountParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.adminIdField: parameters.adminId.toString(),
    };
    await HttpHelper.postData(
      endPoint: ApiConstants.deleteAdminAccountEndPoint,
      body: body,
      printErrorMessage: 'deleteAdminAccountError',
    );
  }
  // endregion

  // region Authentication User
  @override
  Future<UserModel> loginUser(LoginUserParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.emailAddressField: parameters.emailAddress.toString(),
      ApiConstants.passwordField: parameters.password.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.loginUserEndPoint,
      body: body,
      printErrorMessage: 'loginUserError',
    );
    return UserModel.fromJson(response['user']);
  }

  @override
  Future<UserModel> registerUser(RegisterUserParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.fullNameField: parameters.fullName.toString(),
      ApiConstants.personalImageField: parameters.personalImage.toString(),
      ApiConstants.coverImageField: parameters.coverImage.toString(),
      ApiConstants.bioField: parameters.bio.toString(),
      ApiConstants.emailAddressField: parameters.emailAddress.toString(),
      ApiConstants.passwordField: parameters.password.toString(),
      ApiConstants.dialingCodeField: parameters.dialingCode.toString(),
      ApiConstants.phoneNumberField: parameters.phoneNumber.toString(),
      ApiConstants.birthDateField: parameters.birthDate.toString(),
      ApiConstants.countryIdField: parameters.countryId.toString(),
      ApiConstants.genderField: parameters.gender == null ? 'null' : parameters.gender!.name,
      ApiConstants.latitudeField: parameters.latitude.toString(),
      ApiConstants.longitudeField: parameters.longitude.toString(),
      ApiConstants.balanceField: parameters.balance.toString(),
      ApiConstants.isFeaturedField: parameters.isFeatured.toString(),
      ApiConstants.signInMethodField: parameters.signInMethod.name,
      ApiConstants.createdAtField: parameters.createdAt.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.registerUserEndPoint,
      body: body,
      printErrorMessage: 'registerUserError',
    );
    return UserModel.fromJson(response['user']);
  }

  @override
  Future<bool> checkUserEmailToResetPassword(CheckUserEmailToResetPasswordParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.emailAddressField: parameters.emailAddress.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.checkUserEmailToResetPasswordEndPoint,
      body: body,
      printErrorMessage: 'checkUserEmailToResetPasswordError',
    );
    return response['isUserEmailExist'];
  }

  @override
  Future<UserModel> resetUserPassword(ResetUserPasswordParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.emailAddressField: parameters.emailAddress.toString(),
      ApiConstants.passwordField: parameters.password.toString(),
    };

    var response = await HttpHelper.postData(
      endPoint: ApiConstants.resetUserPasswordEndPoint,
      body: body,
      printErrorMessage: 'resetUserPasswordError',
    );
    return UserModel.fromJson(response['user']);
  }

  @override
  Future<UserModel> changeUserPassword(ChangeUserPasswordParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.userIdField: parameters.userId.toString(),
      ApiConstants.oldPasswordField: parameters.oldPassword.toString(),
      ApiConstants.newPasswordField: parameters.newPassword.toString(),
    };

    var response = await HttpHelper.postData(
      endPoint: ApiConstants.changeUserPasswordEndPoint,
      body: body,
      printErrorMessage: 'changeUserPasswordError',
    );
    return UserModel.fromJson(response['user']);
  }

  @override
  Future<UserModel> editUserProfile(EditUserProfileParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.userIdField: parameters.userId.toString(),
      ApiConstants.fullNameField: parameters.fullName.toString(),
      ApiConstants.personalImageField: parameters.personalImage.toString(),
      ApiConstants.coverImageField: parameters.coverImage.toString(),
      ApiConstants.bioField: parameters.bio.toString(),
      ApiConstants.emailAddressField: parameters.emailAddress.toString(),
      ApiConstants.dialingCodeField: parameters.dialingCode.toString(),
      ApiConstants.phoneNumberField: parameters.phoneNumber.toString(),
      ApiConstants.birthDateField: parameters.birthDate.toString(),
      ApiConstants.countryIdField: parameters.countryId.toString(),
      ApiConstants.genderField: parameters.gender == null ? 'null' : parameters.gender!.name,
      ApiConstants.latitudeField: parameters.latitude.toString(),
      ApiConstants.longitudeField: parameters.longitude.toString(),
    };

    var response = await HttpHelper.postData(
      endPoint: ApiConstants.editUserProfileEndPoint,
      body: body,
      printErrorMessage: 'editUserProfileError',
    );
    return UserModel.fromJson(response['user']);
  }

  @override
  Future<UserModel> getUserWithId(GetUserWithIdParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.userIdField: parameters.userId.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getUserWithIdEndPoint,
      query: query,
      printErrorMessage: 'getUserWithIdError',
    );
    return UserModel.fromJson(response['user']);
  }

  @override
  Future<bool> isUserExist(IsUserExistParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.userIdField: parameters.userId.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.isUserExistEndPoint,
      body: body,
      printErrorMessage: 'isUserExistError',
    );
    return response['isExistUser'];
  }

  @override
  Future<bool> isUserEmailExist(IsUserEmailExistParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.emailAddressField: parameters.emailAddress.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.isUserEmailExistEndPoint,
      body: body,
      printErrorMessage: 'isUserEmailExistError',
    );
    return response['isUserEmailExist'];
  }

  @override
  Future<void> deleteUserAccount(DeleteUserAccountParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.userIdField: parameters.userId.toString(),
    };
    await HttpHelper.postData(
      endPoint: ApiConstants.deleteUserAccountEndPoint,
      body: body,
      printErrorMessage: 'deleteUserAccountError',
    );
  }
  // endregion

  // region Authentication Account
  @override
  Future<AccountModel> loginAccount(LoginAccountParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.emailAddressField: parameters.emailAddress.toString(),
      ApiConstants.passwordField: parameters.password.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.loginAccountEndPoint,
      body: body,
      printErrorMessage: 'loginAccountError',
    );
    return AccountModel.fromJson(response['account']);
  }

  @override
  Future<AccountModel> registerAccount(RegisterAccountParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.mainCategoryIdField: parameters.mainCategoryId.toString(),
      ApiConstants.fullNameField: parameters.fullName.toString(),
      ApiConstants.personalImageField: parameters.personalImage.toString(),
      ApiConstants.emailAddressField: parameters.emailAddress.toString(),
      ApiConstants.passwordField: parameters.password.toString(),
      ApiConstants.signInMethodField: parameters.signInMethod.name,
      ApiConstants.createdAtField: parameters.createdAt.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.registerAccountEndPoint,
      body: body,
      printErrorMessage: 'registerAccountError',
    );
    return AccountModel.fromJson(response['account']);
  }

  @override
  Future<bool> checkAccountEmailToResetPassword(CheckAccountEmailToResetPasswordParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.emailAddressField: parameters.emailAddress.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.checkAccountEmailToResetPasswordEndPoint,
      body: body,
      printErrorMessage: 'checkAccountEmailToResetPasswordError',
    );
    return response['isAccountEmailExist'];
  }

  @override
  Future<AccountModel> resetAccountPassword(ResetAccountPasswordParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.emailAddressField: parameters.emailAddress.toString(),
      ApiConstants.passwordField: parameters.password.toString(),
    };

    var response = await HttpHelper.postData(
      endPoint: ApiConstants.resetAccountPasswordEndPoint,
      body: body,
      printErrorMessage: 'resetAccountPasswordError',
    );
    return AccountModel.fromJson(response['account']);
  }

  @override
  Future<AccountModel> changeAccountPassword(ChangeAccountPasswordParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.accountIdField: parameters.accountId.toString(),
      ApiConstants.oldPasswordField: parameters.oldPassword.toString(),
      ApiConstants.newPasswordField: parameters.newPassword.toString(),
    };

    var response = await HttpHelper.postData(
      endPoint: ApiConstants.changeAccountPasswordEndPoint,
      body: body,
      printErrorMessage: 'changeAccountPasswordError',
    );
    return AccountModel.fromJson(response['account']);
  }

  @override
  Future<AccountModel> editAccountProfile(EditAccountProfileParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.accountIdField: parameters.accountId.toString(),
      ApiConstants.fullNameField: parameters.fullName.toString(),
      ApiConstants.personalImageField: parameters.personalImage.toString(),
      ApiConstants.coverImageField: parameters.coverImage.toString(),
      ApiConstants.bioField: parameters.bio.toString(),
      ApiConstants.emailAddressField: parameters.emailAddress.toString(),
      ApiConstants.dialingCodeField: parameters.dialingCode.toString(),
      ApiConstants.phoneNumberField: parameters.phoneNumber.toString(),
      ApiConstants.birthDateField: parameters.birthDate.toString(),
      ApiConstants.countryIdField: parameters.countryId.toString(),
      ApiConstants.genderField: parameters.gender == null ? 'null' : parameters.gender!.name,
      ApiConstants.latitudeField: parameters.latitude.toString(),
      ApiConstants.longitudeField: parameters.longitude.toString(),
      ApiConstants.jobTitleField: parameters.jobTitle.toString(),
      ApiConstants.addressField: parameters.address.toString(),
      ApiConstants.consultationPriceField: parameters.consultationPrice.toString(),
      ApiConstants.tasksField: parameters.tasks.map((e) => e).join('--'),
      ApiConstants.featuresField: parameters.features.map((e) => e).join('--'),
      ApiConstants.photoGalleryField: parameters.photoGallery.map((e) => e).join('--'),
      ApiConstants.governorateIdField: parameters.governorateId.toString(),
      ApiConstants.isBookingByAppointmentField: parameters.isBookingByAppointment.toString(),
      ApiConstants.availablePeriodsField: parameters.availablePeriods.map((e) => e).join('--'),
      ApiConstants.identificationImagesField: parameters.identificationImages.map((e) => e).join('--'),
      ApiConstants.nationalIdField: parameters.nationalId.toString(),
      ApiConstants.nationalImageFrontSideField: parameters.nationalImageFrontSide.toString(),
      ApiConstants.nationalImageBackSideField: parameters.nationalImageBackSide.toString(),
      ApiConstants.cardNumberField: parameters.cardNumber.toString(),
      ApiConstants.cardImageField: parameters.cardImage.toString(),
      ApiConstants.categoriesIdsField: parameters.categoriesIds.toString(),
      ApiConstants.servicesIdsField: parameters.servicesIds.toString(),
    };

    var response = await HttpHelper.postData(
      endPoint: ApiConstants.editAccountProfileEndPoint,
      body: body,
      printErrorMessage: 'editAccountProfileError',
    );
    return AccountModel.fromJson(response['account']);
  }

  @override
  Future<AccountModel> getAccountWithId(GetAccountWithIdParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.accountIdField: parameters.accountId.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getAccountWithIdEndPoint,
      query: query,
      printErrorMessage: 'getAccountWithIdError',
    );
    return AccountModel.fromJson(response['account']);
  }

  @override
  Future<bool> isAccountExist(IsAccountExistParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.accountIdField: parameters.accountId.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.isAccountExistEndPoint,
      body: body,
      printErrorMessage: 'isAccountExistError',
    );
    return response['isExistAccount'];
  }

  @override
  Future<bool> isAccountEmailExist(IsAccountEmailExistParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.emailAddressField: parameters.emailAddress.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.isAccountEmailExistEndPoint,
      body: body,
      printErrorMessage: 'isAccountEmailExistError',
    );
    return response['isAccountEmailExist'];
  }

  @override
  Future<void> deleteAccountAccount(DeleteAccountAccountParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.accountIdField: parameters.accountId.toString(),
    };
    await HttpHelper.postData(
      endPoint: ApiConstants.deleteAccountAccountEndPoint,
      body: body,
      printErrorMessage: 'deleteAccountAccountError',
    );
  }
  // endregion

  // region Admins
  @override
  Future<AdminsResponse> getAdmins(GetAdminsParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.isPaginatedField: parameters.isPaginated.toString(),
      ApiConstants.limitField: parameters.limit.toString(),
      ApiConstants.pageField: parameters.page.toString(),
      ApiConstants.searchTextField: parameters.searchText.toString(),
      ApiConstants.filtersMapField: parameters.filtersMap.toString(),
      if(parameters.orderBy != null) ApiConstants.orderByField: parameters.orderBy!.query.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getAdminsEndPoint,
      query: query,
      printErrorMessage: 'getAdminsError',
    );
    return AdminsResponse.fromJson(response);
  }

  @override
  Future<AdminModel> insertAdmin(InsertAdminParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.fullNameField: parameters.fullName.toString(),
      ApiConstants.personalImageField: parameters.personalImage.toString(),
      ApiConstants.coverImageField: parameters.coverImage.toString(),
      ApiConstants.bioField: parameters.bio.toString(),
      ApiConstants.emailAddressField: parameters.emailAddress.toString(),
      ApiConstants.passwordField: parameters.password.toString(),
      ApiConstants.dialingCodeField: parameters.dialingCode.toString(),
      ApiConstants.phoneNumberField: parameters.phoneNumber.toString(),
      ApiConstants.birthDateField: parameters.birthDate.toString(),
      ApiConstants.countryIdField: parameters.countryId.toString(),
      ApiConstants.genderField: parameters.gender == null ? 'null' : parameters.gender!.name,
      ApiConstants.permissionsField: parameters.permissions.map((e) => e.name).join('--'),
      ApiConstants.isSuperField: parameters.isSuper.toString(),
      ApiConstants.createdAtField: parameters.createdAt.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.insertAdminEndPoint,
      body: body,
      printErrorMessage: 'insertAdminError',
    );
    return AdminModel.fromJson(response['admin']);
  }

  @override
  Future<AdminModel> editAdmin(EditAdminParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.adminIdField: parameters.adminId.toString(),
      ApiConstants.fullNameField: parameters.fullName.toString(),
      ApiConstants.personalImageField: parameters.personalImage.toString(),
      ApiConstants.coverImageField: parameters.coverImage.toString(),
      ApiConstants.bioField: parameters.bio.toString(),
      ApiConstants.emailAddressField: parameters.emailAddress.toString(),
      ApiConstants.passwordField: parameters.password.toString(),
      ApiConstants.dialingCodeField: parameters.dialingCode.toString(),
      ApiConstants.phoneNumberField: parameters.phoneNumber.toString(),
      ApiConstants.birthDateField: parameters.birthDate.toString(),
      ApiConstants.countryIdField: parameters.countryId.toString(),
      ApiConstants.genderField: parameters.gender == null ? 'null' : parameters.gender!.name,
      ApiConstants.permissionsField: parameters.permissions.map((e) => e.name).join('--'),
      ApiConstants.isSuperField: parameters.isSuper.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.editAdminEndPoint,
      body: body,
      printErrorMessage: 'editAdminError',
    );
    return AdminModel.fromJson(response['admin']);
  }

  @override
  Future<void> deleteAdmin(DeleteAdminParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.adminIdField: parameters.adminId.toString(),
    };
    await HttpHelper.postData(
      endPoint: ApiConstants.deleteAdminEndPoint,
      body: body,
      printErrorMessage: 'deleteAdminError',
    );
  }
  // endregion

  // region Users
  @override
  Future<UsersResponse> getUsers(GetUsersParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.isPaginatedField: parameters.isPaginated.toString(),
      ApiConstants.limitField: parameters.limit.toString(),
      ApiConstants.pageField: parameters.page.toString(),
      ApiConstants.searchTextField: parameters.searchText.toString(),
      ApiConstants.filtersMapField: parameters.filtersMap.toString(),
      if(parameters.orderBy != null) ApiConstants.orderByField: parameters.orderBy!.query.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getUsersEndPoint,
      query: query,
      printErrorMessage: 'getUsersError',
    );
    return UsersResponse.fromJson(response);
  }

  @override
  Future<UserModel> insertUser(InsertUserParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.fullNameField: parameters.fullName.toString(),
      ApiConstants.personalImageField: parameters.personalImage.toString(),
      ApiConstants.coverImageField: parameters.coverImage.toString(),
      ApiConstants.bioField: parameters.bio.toString(),
      ApiConstants.emailAddressField: parameters.emailAddress.toString(),
      ApiConstants.passwordField: parameters.password.toString(),
      ApiConstants.dialingCodeField: parameters.dialingCode.toString(),
      ApiConstants.phoneNumberField: parameters.phoneNumber.toString(),
      ApiConstants.birthDateField: parameters.birthDate.toString(),
      ApiConstants.countryIdField: parameters.countryId.toString(),
      ApiConstants.genderField: parameters.gender == null ? 'null' : parameters.gender!.name,
      ApiConstants.latitudeField: parameters.latitude.toString(),
      ApiConstants.longitudeField: parameters.longitude.toString(),
      ApiConstants.balanceField: parameters.balance.toString(),
      ApiConstants.isFeaturedField: parameters.isFeatured.toString(),
      ApiConstants.signInMethodField: parameters.signInMethod.name,
      ApiConstants.createdAtField: parameters.createdAt.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.insertUserEndPoint,
      body: body,
      printErrorMessage: 'insertUserError',
    );
    return UserModel.fromJson(response['user']);
  }

  @override
  Future<UserModel> editUser(EditUserParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.userIdField: parameters.userId.toString(),
      ApiConstants.fullNameField: parameters.fullName.toString(),
      ApiConstants.personalImageField: parameters.personalImage.toString(),
      ApiConstants.coverImageField: parameters.coverImage.toString(),
      ApiConstants.bioField: parameters.bio.toString(),
      ApiConstants.emailAddressField: parameters.emailAddress.toString(),
      ApiConstants.passwordField: parameters.password.toString(),
      ApiConstants.dialingCodeField: parameters.dialingCode.toString(),
      ApiConstants.phoneNumberField: parameters.phoneNumber.toString(),
      ApiConstants.birthDateField: parameters.birthDate.toString(),
      ApiConstants.countryIdField: parameters.countryId.toString(),
      ApiConstants.genderField: parameters.gender == null ? 'null' : parameters.gender!.name,
      ApiConstants.latitudeField: parameters.latitude.toString(),
      ApiConstants.longitudeField: parameters.longitude.toString(),
      ApiConstants.balanceField: parameters.balance.toString(),
      ApiConstants.isFeaturedField: parameters.isFeatured.toString(),
      ApiConstants.signInMethodField: parameters.signInMethod.name,
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.editUserEndPoint,
      body: body,
      printErrorMessage: 'editUserError',
    );
    return UserModel.fromJson(response['user']);
  }

  @override
  Future<void> deleteUser(DeleteUserParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.userIdField: parameters.userId.toString(),
    };
    await HttpHelper.postData(
      endPoint: ApiConstants.deleteUserEndPoint,
      body: body,
      printErrorMessage: 'deleteUserError',
    );
  }
  // endregion

  // region Accounts
  @override
  Future<AccountsResponse> getAccounts(GetAccountsParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.isPaginatedField: parameters.isPaginated.toString(),
      ApiConstants.limitField: parameters.limit.toString(),
      ApiConstants.pageField: parameters.page.toString(),
      ApiConstants.searchTextField: parameters.searchText.toString(),
      ApiConstants.filtersMapField: parameters.filtersMap.toString(),
      if(parameters.orderBy != null) ApiConstants.orderByField: parameters.orderBy!.query.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getAccountsEndPoint,
      query: query,
      printErrorMessage: 'getAccountsError',
    );
    return AccountsResponse.fromJson(response);
  }

  @override
  Future<AccountModel> insertAccount(InsertAccountParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.mainCategoryIdField: parameters.mainCategoryId.toString(),
      ApiConstants.fullNameField: parameters.fullName.toString(),
      ApiConstants.personalImageField: parameters.personalImage.toString(),
      ApiConstants.coverImageField: parameters.coverImage.toString(),
      ApiConstants.bioField: parameters.bio.toString(),
      ApiConstants.emailAddressField: parameters.emailAddress.toString(),
      ApiConstants.passwordField: parameters.password.toString(),
      ApiConstants.dialingCodeField: parameters.dialingCode.toString(),
      ApiConstants.phoneNumberField: parameters.phoneNumber.toString(),
      ApiConstants.birthDateField: parameters.birthDate.toString(),
      ApiConstants.countryIdField: parameters.countryId.toString(),
      ApiConstants.genderField: parameters.gender == null ? 'null' : parameters.gender!.name,
      ApiConstants.latitudeField: parameters.latitude.toString(),
      ApiConstants.longitudeField: parameters.longitude.toString(),
      ApiConstants.balanceField: parameters.balance.toString(),
      ApiConstants.isFeaturedField: parameters.isFeatured.toString(),
      ApiConstants.signInMethodField: parameters.signInMethod.name,
      ApiConstants.accountStatusField: parameters.accountStatus.name,
      ApiConstants.reasonOfRejectField: parameters.reasonOfReject.toString(),
      ApiConstants.jobTitleField: parameters.jobTitle.toString(),
      ApiConstants.addressField: parameters.address.toString(),
      ApiConstants.consultationPriceField: parameters.consultationPrice.toString(),
      ApiConstants.tasksField: parameters.tasks.map((e) => e).join('--'),
      ApiConstants.featuresField: parameters.features.map((e) => e).join('--'),
      ApiConstants.photoGalleryField: parameters.photoGallery.map((e) => e).join('--'),
      ApiConstants.governorateIdField: parameters.governorateId.toString(),
      ApiConstants.isBookingByAppointmentField: parameters.isBookingByAppointment.toString(),
      ApiConstants.availablePeriodsField: parameters.availablePeriods.map((e) => e).join('--'),
      ApiConstants.identificationImagesField: parameters.identificationImages.map((e) => e).join('--'),
      ApiConstants.createdAtField: parameters.createdAt.toString(),
      ApiConstants.nationalIdField: parameters.nationalId.toString(),
      ApiConstants.nationalImageFrontSideField: parameters.nationalImageFrontSide.toString(),
      ApiConstants.nationalImageBackSideField: parameters.nationalImageBackSide.toString(),
      ApiConstants.cardNumberField: parameters.cardNumber.toString(),
      ApiConstants.cardImageField: parameters.cardImage.toString(),
      ApiConstants.categoriesIdsField: parameters.categoriesIds.toString(),
      ApiConstants.servicesIdsField: parameters.servicesIds.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.insertAccountEndPoint,
      body: body,
      printErrorMessage: 'insertAccountError',
    );
    return AccountModel.fromJson(response['account']);
  }

  @override
  Future<AccountModel> editAccount(EditAccountParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.accountIdField: parameters.accountId.toString(),
      ApiConstants.mainCategoryIdField: parameters.mainCategoryId.toString(),
      ApiConstants.fullNameField: parameters.fullName.toString(),
      ApiConstants.personalImageField: parameters.personalImage.toString(),
      ApiConstants.coverImageField: parameters.coverImage.toString(),
      ApiConstants.bioField: parameters.bio.toString(),
      ApiConstants.emailAddressField: parameters.emailAddress.toString(),
      ApiConstants.passwordField: parameters.password.toString(),
      ApiConstants.dialingCodeField: parameters.dialingCode.toString(),
      ApiConstants.phoneNumberField: parameters.phoneNumber.toString(),
      ApiConstants.birthDateField: parameters.birthDate.toString(),
      ApiConstants.countryIdField: parameters.countryId.toString(),
      ApiConstants.genderField: parameters.gender == null ? 'null' : parameters.gender!.name,
      ApiConstants.latitudeField: parameters.latitude.toString(),
      ApiConstants.longitudeField: parameters.longitude.toString(),
      ApiConstants.balanceField: parameters.balance.toString(),
      ApiConstants.isFeaturedField: parameters.isFeatured.toString(),
      ApiConstants.signInMethodField: parameters.signInMethod.name,
      ApiConstants.accountStatusField: parameters.accountStatus.name,
      ApiConstants.reasonOfRejectField: parameters.reasonOfReject.toString(),
      ApiConstants.jobTitleField: parameters.jobTitle.toString(),
      ApiConstants.addressField: parameters.address.toString(),
      ApiConstants.consultationPriceField: parameters.consultationPrice.toString(),
      ApiConstants.tasksField: parameters.tasks.map((e) => e).join('--'),
      ApiConstants.featuresField: parameters.features.map((e) => e).join('--'),
      ApiConstants.photoGalleryField: parameters.photoGallery.map((e) => e).join('--'),
      ApiConstants.governorateIdField: parameters.governorateId.toString(),
      ApiConstants.isBookingByAppointmentField: parameters.isBookingByAppointment.toString(),
      ApiConstants.availablePeriodsField: parameters.availablePeriods.map((e) => e).join('--'),
      ApiConstants.identificationImagesField: parameters.identificationImages.map((e) => e).join('--'),
      ApiConstants.nationalIdField: parameters.nationalId.toString(),
      ApiConstants.nationalImageFrontSideField: parameters.nationalImageFrontSide.toString(),
      ApiConstants.nationalImageBackSideField: parameters.nationalImageBackSide.toString(),
      ApiConstants.cardNumberField: parameters.cardNumber.toString(),
      ApiConstants.cardImageField: parameters.cardImage.toString(),
      ApiConstants.categoriesIdsField: parameters.categoriesIds.toString(),
      ApiConstants.servicesIdsField: parameters.servicesIds.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.editAccountEndPoint,
      body: body,
      printErrorMessage: 'editAccountError',
    );
    return AccountModel.fromJson(response['account']);
  }

  @override
  Future<void> deleteAccount(DeleteAccountParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.accountIdField: parameters.accountId.toString(),
    };
    await HttpHelper.postData(
      endPoint: ApiConstants.deleteAccountEndPoint,
      body: body,
      printErrorMessage: 'deleteAccountError',
    );
  }
  // endregion

  // region Statistics
  @override
  Future<List<StatisticModel>> getAdminStatistics(GetAdminStatisticsParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.startTimeTodayField: parameters.startTimeToday.toString(),
      ApiConstants.endTimeTodayField: parameters.endTimeToday.toString(),
      ApiConstants.startThisMonthField: parameters.startThisMonth.toString(),
      ApiConstants.endThisMonthField: parameters.endThisMonth.toString(),
      ApiConstants.startLastMonthField: parameters.startLastMonth.toString(),
      ApiConstants.endLastMonthField: parameters.endLastMonth.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getAdminStatisticsEndPoint,
      query: query,
      printErrorMessage: 'getAdminStatisticsError',
    );
    return List.from(response['adminStatistics']).map((e) => StatisticModel.fromJson(e)).toList();
  }

  @override
  Future<List<StatisticModel>> getAccountStatistics(GetAccountStatisticsParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.startTimeTodayField: parameters.startTimeToday.toString(),
      ApiConstants.endTimeTodayField: parameters.endTimeToday.toString(),
      ApiConstants.startThisMonthField: parameters.startThisMonth.toString(),
      ApiConstants.endThisMonthField: parameters.endThisMonth.toString(),
      ApiConstants.startLastMonthField: parameters.startLastMonth.toString(),
      ApiConstants.endLastMonthField: parameters.endLastMonth.toString(),
      ApiConstants.accountIdField: parameters.accountId.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getAccountStatisticsEndPoint,
      query: query,
      printErrorMessage: 'getAccountStatisticsError',
    );
    return List.from(response['accountStatistics']).map((e) => StatisticModel.fromJson(e)).toList();
  }
  // endregion

  // region About App
  @override
  Future<AboutAppModel> getAboutApp() async {
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getAboutAppEndPoint,
      printErrorMessage: 'getAboutAppError',
    );
    return AboutAppModel.fromJson(response['aboutApp']);
  }

  @override
  Future<AboutAppModel> editAboutApp(EditAboutAppParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.textArField: parameters.textAr.toString(),
      ApiConstants.textEnField: parameters.textEn.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.editAboutAppEndPoint,
      body: body,
      printErrorMessage: 'editAboutAppError',
    );
    return AboutAppModel.fromJson(response['aboutApp']);
  }
  // endregion

  // region Service Description
  @override
  Future<ServiceDescriptionModel> getServiceDescription() async {
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getServiceDescriptionEndPoint,
      printErrorMessage: 'getServiceDescriptionError',
    );
    return ServiceDescriptionModel.fromJson(response['serviceDescription']);
  }

  @override
  Future<ServiceDescriptionModel> editServiceDescription(EditServiceDescriptionParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.textArField: parameters.textAr.toString(),
      ApiConstants.textEnField: parameters.textEn.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.editServiceDescriptionEndPoint,
      body: body,
      printErrorMessage: 'editServiceDescriptionError',
    );
    return ServiceDescriptionModel.fromJson(response['serviceDescription']);
  }
  // endregion

  // region Privacy Policy
  @override
  Future<PrivacyPolicyModel> getPrivacyPolicy() async {
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getPrivacyPolicyEndPoint,
      printErrorMessage: 'getPrivacyPolicyError',
    );
    return PrivacyPolicyModel.fromJson(response['privacyPolicy']);
  }

  @override
  Future<PrivacyPolicyModel> editPrivacyPolicy(EditPrivacyPolicyParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.textArField: parameters.textAr.toString(),
      ApiConstants.textEnField: parameters.textEn.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.editPrivacyPolicyEndPoint,
      body: body,
      printErrorMessage: 'editPrivacyPolicyError',
    );
    return PrivacyPolicyModel.fromJson(response['privacyPolicy']);
  }
  // endregion

  // region Terms Of Use
  @override
  Future<TermsOfUseModel> getTermsOfUse() async {
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getTermsOfUseEndPoint,
      printErrorMessage: 'getTermsOfUseError',
    );
    return TermsOfUseModel.fromJson(response['termsOfUse']);
  }

  @override
  Future<TermsOfUseModel> editTermsOfUse(EditTermsOfUseParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.textArField: parameters.textAr.toString(),
      ApiConstants.textEnField: parameters.textEn.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.editTermsOfUseEndPoint,
      body: body,
      printErrorMessage: 'editTermsOfUseError',
    );
    return TermsOfUseModel.fromJson(response['termsOfUse']);
  }
  // endregion

  // region Sliders
  @override
  Future<SlidersResponse> getSliders(GetSlidersParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.isPaginatedField: parameters.isPaginated.toString(),
      ApiConstants.limitField: parameters.limit.toString(),
      ApiConstants.pageField: parameters.page.toString(),
      ApiConstants.searchTextField: parameters.searchText.toString(),
      ApiConstants.filtersMapField: parameters.filtersMap.toString(),
      if(parameters.orderBy != null) ApiConstants.orderByField: parameters.orderBy!.query.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getSlidersEndPoint,
      query: query,
      printErrorMessage: 'getSlidersError',
    );
    return SlidersResponse.fromJson(response);
  }

  @override
  Future<SliderModel> getSliderWithId(GetSliderWithIdParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.sliderIdField: parameters.sliderId.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getSliderWithIdEndPoint,
      query: query,
      printErrorMessage: 'getSliderWithIdError',
    );
    return SliderModel.fromJson(response['slider']);
  }

  @override
  Future<SliderModel> insertSlider(InsertSliderParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.imageField: parameters.image.toString(),
      ApiConstants.sliderTargetField: parameters.sliderTarget.name,
      ApiConstants.valueField: parameters.value.toString(),
      ApiConstants.createdAtField: parameters.createdAt.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.insertSliderEndPoint,
      body: body,
      printErrorMessage: 'insertSliderError',
    );
    return SliderModel.fromJson(response['slider']);
  }

  @override
  Future<SliderModel> editSlider(EditSliderParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.sliderIdField: parameters.sliderId.toString(),
      ApiConstants.imageField: parameters.image.toString(),
      ApiConstants.sliderTargetField: parameters.sliderTarget.name,
      ApiConstants.valueField: parameters.value.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.editSliderEndPoint,
      body: body,
      printErrorMessage: 'editSliderError',
    );
    return SliderModel.fromJson(response['slider']);
  }

  @override
  Future<void> deleteSlider(DeleteSliderParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.sliderIdField: parameters.sliderId.toString(),
    };
    await HttpHelper.postData(
      endPoint: ApiConstants.deleteSliderEndPoint,
      body: body,
      printErrorMessage: 'deleteSliderError',
    );
  }
  // endregion

  // region Notifications
  @override
  Future<NotificationsResponse> getNotifications(GetNotificationsParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.isPaginatedField: parameters.isPaginated.toString(),
      ApiConstants.limitField: parameters.limit.toString(),
      ApiConstants.pageField: parameters.page.toString(),
      ApiConstants.searchTextField: parameters.searchText.toString(),
      ApiConstants.filtersMapField: parameters.filtersMap.toString(),
      if(parameters.orderBy != null) ApiConstants.orderByField: parameters.orderBy!.query.toString(),
      ApiConstants.userTypeField: parameters.userType.name,
      ApiConstants.accountIdField: parameters.accountId.toString(),
      ApiConstants.userIdField: parameters.userId.toString(),
      ApiConstants.targetCreatedAtField: parameters.targetCreatedAt.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getNotificationsEndPoint,
      query: query,
      printErrorMessage: 'getNotificationsError',
    );
    return NotificationsResponse.fromJson(response);
  }

  @override
  Future<NotificationModel> getNotificationWithId(GetNotificationWithIdParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.notificationIdField: parameters.notificationId.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.getNotificationWithIdEndPoint,
      body: body,
      printErrorMessage: 'getNotificationWithIdError',
    );
    return NotificationModel.fromJson(response['notification']);
  }

  @override
  Future<NotificationModel> insertNotification(InsertNotificationParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.userIdField: parameters.userId.toString(),
      ApiConstants.accountIdField: parameters.accountId.toString(),
      ApiConstants.notificationToAppField: parameters.notificationToApp.name,
      ApiConstants.notificationToField: parameters.notificationTo.name,
      ApiConstants.titleField: parameters.title.toString(),
      ApiConstants.bodyField: parameters.body.toString(),
      ApiConstants.createdAtField: parameters.createdAt.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.insertNotificationEndPoint,
      body: body,
      printErrorMessage: 'insertNotificationError',
    );
    return NotificationModel.fromJson(response['notification']);
  }

  @override
  Future<void> deleteNotification(DeleteNotificationParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.notificationIdField: parameters.notificationId.toString(),
    };
    await HttpHelper.postData(
      endPoint: ApiConstants.deleteNotificationEndPoint,
      body: body,
      printErrorMessage: 'deleteNotificationError',
    );
  }
  // endregion

  // region Admin Notifications
  @override
  Future<AdminNotificationsResponse> getAdminNotifications(GetAdminNotificationsParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.isPaginatedField: parameters.isPaginated.toString(),
      ApiConstants.limitField: parameters.limit.toString(),
      ApiConstants.pageField: parameters.page.toString(),
      ApiConstants.searchTextField: parameters.searchText.toString(),
      ApiConstants.filtersMapField: parameters.filtersMap.toString(),
      if(parameters.orderBy != null) ApiConstants.orderByField: parameters.orderBy!.query.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getAdminNotificationsEndPoint,
      query: query,
      printErrorMessage: 'getAdminNotificationsError',
    );
    return AdminNotificationsResponse.fromJson(response);
  }

  @override
  Future<AdminNotificationModel> getAdminNotificationWithId(GetAdminNotificationWithIdParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.adminNotificationIdField: parameters.adminNotificationId.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.getAdminNotificationWithIdEndPoint,
      body: body,
      printErrorMessage: 'getAdminNotificationWithIdError',
    );
    return AdminNotificationModel.fromJson(response['adminNotification']);
  }

  @override
  Future<AdminNotificationModel> insertAdminNotification(InsertAdminNotificationParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.titleField: parameters.title.toString(),
      ApiConstants.bodyField: parameters.body.toString(),
      ApiConstants.isViewedField: parameters.isViewed.toString(),
      ApiConstants.createdAtField: parameters.createdAt.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.insertAdminNotificationEndPoint,
      body: body,
      printErrorMessage: 'insertAdminNotificationError',
    );
    return AdminNotificationModel.fromJson(response['adminNotification']);
  }

  @override
  Future<void> deleteAdminNotification(DeleteAdminNotificationParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.adminNotificationIdField: parameters.adminNotificationId.toString(),
    };
    await HttpHelper.postData(
      endPoint: ApiConstants.deleteAdminNotificationEndPoint,
      body: body,
      printErrorMessage: 'deleteAdminNotificationError',
    );
  }

  @override
  Future<bool> setIsViewed(SetIsViewedParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.adminNotificationIdField: parameters.adminNotificationId.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.setIsViewedEndPoint,
      body: body,
      printErrorMessage: 'setIsViewedError',
    );
    return response['isViewed'];
  }
  // endregion

  // region Complaints
  @override
  Future<ComplaintsResponse> getComplaints(GetComplaintsParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.isPaginatedField: parameters.isPaginated.toString(),
      ApiConstants.limitField: parameters.limit.toString(),
      ApiConstants.pageField: parameters.page.toString(),
      ApiConstants.searchTextField: parameters.searchText.toString(),
      ApiConstants.filtersMapField: parameters.filtersMap.toString(),
      if(parameters.orderBy != null) ApiConstants.orderByField: parameters.orderBy!.query.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getComplaintsEndPoint,
      query: query,
      printErrorMessage: 'getComplaintsError',
    );
    return ComplaintsResponse.fromJson(response);
  }

  @override
  Future<ComplaintModel> getComplaintWithId(GetComplaintWithIdParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.complaintIdField: parameters.complaintId.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getComplaintWithIdEndPoint,
      query: query,
      printErrorMessage: 'getComplaintWithIdError',
    );
    return ComplaintModel.fromJson(response['complaint']);
  }

  @override
  Future<ComplaintModel> insertComplaint(InsertComplaintParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.userIdField: parameters.userId.toString(),
      ApiConstants.complaintField: parameters.complaint.toString(),
      ApiConstants.createdAtField: parameters.createdAt.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.insertComplaintEndPoint,
      body: body,
      printErrorMessage: 'insertComplaintError',
    );
    return ComplaintModel.fromJson(response['complaint']);
  }

  @override
  Future<void> deleteComplaint(DeleteComplaintParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.complaintIdField: parameters.complaintId.toString(),
    };
    await HttpHelper.postData(
      endPoint: ApiConstants.deleteComplaintEndPoint,
      body: body,
      printErrorMessage: 'deleteComplaintError',
    );
  }
  // endregion

  // region Faqs
  @override
  Future<FaqsResponse> getFaqs(GetFaqsParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.isPaginatedField: parameters.isPaginated.toString(),
      ApiConstants.limitField: parameters.limit.toString(),
      ApiConstants.pageField: parameters.page.toString(),
      ApiConstants.searchTextField: parameters.searchText.toString(),
      ApiConstants.filtersMapField: parameters.filtersMap.toString(),
      if(parameters.orderBy != null) ApiConstants.orderByField: parameters.orderBy!.query.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getFaqsEndPoint,
      query: query,
      printErrorMessage: 'getFaqsError',
    );
    return FaqsResponse.fromJson(response);
  }

  @override
  Future<FaqModel> getFaqWithId(GetFaqWithIdParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.faqIdField: parameters.faqId.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getFaqWithIdEndPoint,
      query: query,
      printErrorMessage: 'getFaqWithIdError',
    );
    return FaqModel.fromJson(response['faq']);
  }

  @override
  Future<FaqModel> insertFaq(InsertFaqParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.questionArField: parameters.questionAr.toString(),
      ApiConstants.questionEnField: parameters.questionEn.toString(),
      ApiConstants.answerArField: parameters.answerAr.toString(),
      ApiConstants.answerEnField: parameters.answerEn.toString(),
      ApiConstants.createdAtField: parameters.createdAt.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.insertFaqEndPoint,
      body: body,
      printErrorMessage: 'insertFaqError',
    );
    return FaqModel.fromJson(response['faq']);
  }

  @override
  Future<FaqModel> editFaq(EditFaqParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.faqIdField: parameters.faqId.toString(),
      ApiConstants.questionArField: parameters.questionAr.toString(),
      ApiConstants.questionEnField: parameters.questionEn.toString(),
      ApiConstants.answerArField: parameters.answerAr.toString(),
      ApiConstants.answerEnField: parameters.answerEn.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.editFaqEndPoint,
      body: body,
      printErrorMessage: 'editFaqError',
    );
    return FaqModel.fromJson(response['faq']);
  }

  @override
  Future<void> deleteFaq(DeleteFaqParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.faqIdField: parameters.faqId.toString(),
    };
    await HttpHelper.postData(
      endPoint: ApiConstants.deleteFaqEndPoint,
      body: body,
      printErrorMessage: 'deleteFaqError',
    );
  }
  // endregion

  // region Articles
  @override
  Future<ArticlesResponse> getArticles(GetArticlesParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.isPaginatedField: parameters.isPaginated.toString(),
      ApiConstants.limitField: parameters.limit.toString(),
      ApiConstants.pageField: parameters.page.toString(),
      ApiConstants.searchTextField: parameters.searchText.toString(),
      ApiConstants.filtersMapField: parameters.filtersMap.toString(),
      if(parameters.orderBy != null) ApiConstants.orderByField: parameters.orderBy!.query.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getArticlesEndPoint,
      query: query,
      printErrorMessage: 'getArticlesError',
    );
    return ArticlesResponse.fromJson(response);
  }

  @override
  Future<ArticleModel> getArticleWithId(GetArticleWithIdParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.articleIdField: parameters.articleId.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getArticleWithIdEndPoint,
      query: query,
      printErrorMessage: 'getArticleWithIdError',
    );
    return ArticleModel.fromJson(response['article']);
  }

  @override
  Future<ArticleModel> insertArticle(InsertArticleParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.imageField: parameters.image.toString(),
      ApiConstants.titleArField: parameters.titleAr.toString(),
      ApiConstants.titleEnField: parameters.titleEn.toString(),
      ApiConstants.articleArField: parameters.articleAr.toString(),
      ApiConstants.articleEnField: parameters.articleEn.toString(),
      ApiConstants.customOrderField: parameters.customOrder.toString(),
      ApiConstants.isAvailableField: parameters.isAvailable.toString(),
      ApiConstants.createdAtField: parameters.createdAt.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.insertArticleEndPoint,
      body: body,
      printErrorMessage: 'insertArticleError',
    );
    return ArticleModel.fromJson(response['article']);
  }

  @override
  Future<ArticleModel> editArticle(EditArticleParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.articleIdField: parameters.articleId.toString(),
      ApiConstants.imageField: parameters.image.toString(),
      ApiConstants.titleArField: parameters.titleAr.toString(),
      ApiConstants.titleEnField: parameters.titleEn.toString(),
      ApiConstants.articleArField: parameters.articleAr.toString(),
      ApiConstants.articleEnField: parameters.articleEn.toString(),
      ApiConstants.customOrderField: parameters.customOrder.toString(),
      ApiConstants.isAvailableField: parameters.isAvailable.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.editArticleEndPoint,
      body: body,
      printErrorMessage: 'editArticleError',
    );
    return ArticleModel.fromJson(response['article']);
  }

  @override
  Future<void> deleteArticle(DeleteArticleParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.articleIdField: parameters.articleId.toString(),
    };
    await HttpHelper.postData(
      endPoint: ApiConstants.deleteArticleEndPoint,
      body: body,
      printErrorMessage: 'deleteArticleError',
    );
  }

  @override
  Future<ArticleModel> incrementArticleViews(IncrementArticleViewsParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.articleIdField: parameters.articleId.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.incrementArticleViewsEndPoint,
      body: body,
      printErrorMessage: 'incrementArticleViewsError',
    );
    return ArticleModel.fromJson(response['article']);
  }
  // endregion

  // region Social Media
  @override
  Future<SocialMediaResponse> getSocialMedia(GetSocialMediaParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.isPaginatedField: parameters.isPaginated.toString(),
      ApiConstants.limitField: parameters.limit.toString(),
      ApiConstants.pageField: parameters.page.toString(),
      ApiConstants.searchTextField: parameters.searchText.toString(),
      ApiConstants.filtersMapField: parameters.filtersMap.toString(),
      if(parameters.orderBy != null) ApiConstants.orderByField: parameters.orderBy!.query.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getSocialMediaEndPoint,
      query: query,
      printErrorMessage: 'getSocialMediaError',
    );
    return SocialMediaResponse.fromJson(response);
  }

  @override
  Future<SocialMediaModel> getSocialMediaWithId(GetSocialMediaWithIdParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.socialMediaIdField: parameters.socialMediaId.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getSocialMediaWithIdEndPoint,
      query: query,
      printErrorMessage: 'getSocialMediaWithIdError',
    );
    return SocialMediaModel.fromJson(response['socialMedia']);
  }

  @override
  Future<SocialMediaModel> insertSocialMedia(InsertSocialMediaParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.imageField: parameters.image.toString(),
      ApiConstants.nameArField: parameters.nameAr.toString(),
      ApiConstants.nameEnField: parameters.nameEn.toString(),
      ApiConstants.linkField: parameters.link.toString(),
      ApiConstants.isAvailableField: parameters.isAvailable.toString(),
      ApiConstants.createdAtField: parameters.createdAt.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.insertSocialMediaEndPoint,
      body: body,
      printErrorMessage: 'insertSocialMediaError',
    );
    return SocialMediaModel.fromJson(response['socialMedia']);
  }

  @override
  Future<SocialMediaModel> editSocialMedia(EditSocialMediaParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.socialMediaIdField: parameters.socialMediaId.toString(),
      ApiConstants.imageField: parameters.image.toString(),
      ApiConstants.nameArField: parameters.nameAr.toString(),
      ApiConstants.nameEnField: parameters.nameEn.toString(),
      ApiConstants.linkField: parameters.link.toString(),
      ApiConstants.isAvailableField: parameters.isAvailable.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.editSocialMediaEndPoint,
      body: body,
      printErrorMessage: 'editSocialMediaError',
    );
    return SocialMediaModel.fromJson(response['socialMedia']);
  }

  @override
  Future<void> deleteSocialMedia(DeleteSocialMediaParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.socialMediaIdField: parameters.socialMediaId.toString(),
    };
    await HttpHelper.postData(
      endPoint: ApiConstants.deleteSocialMediaEndPoint,
      body: body,
      printErrorMessage: 'deleteSocialMediaError',
    );
  }
  // endregion

  // region Suggested Messages
  @override
  Future<SuggestedMessagesResponse> getSuggestedMessages(GetSuggestedMessagesParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.isPaginatedField: parameters.isPaginated.toString(),
      ApiConstants.limitField: parameters.limit.toString(),
      ApiConstants.pageField: parameters.page.toString(),
      ApiConstants.searchTextField: parameters.searchText.toString(),
      ApiConstants.filtersMapField: parameters.filtersMap.toString(),
      if(parameters.orderBy != null) ApiConstants.orderByField: parameters.orderBy!.query.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getSuggestedMessagesEndPoint,
      query: query,
      printErrorMessage: 'getSuggestedMessagesError',
    );
    return SuggestedMessagesResponse.fromJson(response);
  }

  @override
  Future<SuggestedMessageModel> getSuggestedMessageWithId(GetSuggestedMessageWithIdParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.suggestedMessageIdField: parameters.suggestedMessageId.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getSuggestedMessageWithIdEndPoint,
      query: query,
      printErrorMessage: 'getSuggestedMessageWithIdError',
    );
    return SuggestedMessageModel.fromJson(response['suggestedMessage']);
  }

  @override
  Future<SuggestedMessageModel> insertSuggestedMessage(InsertSuggestedMessageParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.messageArField: parameters.messageAr.toString(),
      ApiConstants.messageEnField: parameters.messageEn.toString(),
      ApiConstants.answerArField: parameters.answerAr.toString(),
      ApiConstants.answerEnField: parameters.answerEn.toString(),
      ApiConstants.createdAtField: parameters.createdAt.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.insertSuggestedMessageEndPoint,
      body: body,
      printErrorMessage: 'insertSuggestedMessageError',
    );
    return SuggestedMessageModel.fromJson(response['suggestedMessage']);
  }

  @override
  Future<SuggestedMessageModel> editSuggestedMessage(EditSuggestedMessageParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.suggestedMessageIdField: parameters.suggestedMessageId.toString(),
      ApiConstants.messageArField: parameters.messageAr.toString(),
      ApiConstants.messageEnField: parameters.messageEn.toString(),
      ApiConstants.answerArField: parameters.answerAr.toString(),
      ApiConstants.answerEnField: parameters.answerEn.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.editSuggestedMessageEndPoint,
      body: body,
      printErrorMessage: 'editSuggestedMessageError',
    );
    return SuggestedMessageModel.fromJson(response['suggestedMessage']);
  }

  @override
  Future<void> deleteSuggestedMessage(DeleteSuggestedMessageParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.suggestedMessageIdField: parameters.suggestedMessageId.toString(),
    };
    await HttpHelper.postData(
      endPoint: ApiConstants.deleteSuggestedMessageEndPoint,
      body: body,
      printErrorMessage: 'deleteSuggestedMessageError',
    );
  }
  // endregion

  // region Wallet History
  @override
  Future<WalletHistoryResponse> getWalletHistory(GetWalletHistoryParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.isPaginatedField: parameters.isPaginated.toString(),
      ApiConstants.limitField: parameters.limit.toString(),
      ApiConstants.pageField: parameters.page.toString(),
      ApiConstants.searchTextField: parameters.searchText.toString(),
      ApiConstants.filtersMapField: parameters.filtersMap.toString(),
      if(parameters.orderBy != null) ApiConstants.orderByField: parameters.orderBy!.query.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getWalletHistoryEndPoint,
      query: query,
      printErrorMessage: 'getWalletHistoryError',
    );
    return WalletHistoryResponse.fromJson(response);
  }

  @override
  Future<WalletHistoryModel> getWalletHistoryWithId(GetWalletHistoryWithIdParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.walletHistoryIdField: parameters.walletHistoryId.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getWalletHistoryWithIdEndPoint,
      query: query,
      printErrorMessage: 'getWalletHistoryWithIdError',
    );
    return WalletHistoryModel.fromJson(response['walletHistory']);
  }

  @override
  Future<WalletHistoryModel> insertWalletHistory(InsertWalletHistoryParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.userTypeField: parameters.userType.name,
      ApiConstants.accountIdField: parameters.accountId.toString(),
      ApiConstants.userIdField: parameters.userId.toString(),
      ApiConstants.amountField: parameters.amount.toString(),
      ApiConstants.walletTransactionTypeField: parameters.walletTransactionType.name,
      ApiConstants.textArField: parameters.textAr.toString(),
      ApiConstants.textEnField: parameters.textEn.toString(),
      ApiConstants.createdAtField: parameters.createdAt.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.insertWalletHistoryEndPoint,
      body: body,
      printErrorMessage: 'insertWalletHistoryError',
    );
    return WalletHistoryModel.fromJson(response['walletHistory']);
  }

  @override
  Future<WalletHistoryModel> editWalletHistory(EditWalletHistoryParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.walletHistoryIdField: parameters.walletHistoryId.toString(),
      ApiConstants.userTypeField: parameters.userType.name,
      ApiConstants.accountIdField: parameters.accountId.toString(),
      ApiConstants.userIdField: parameters.userId.toString(),
      ApiConstants.amountField: parameters.amount.toString(),
      ApiConstants.walletTransactionTypeField: parameters.walletTransactionType.name,
      ApiConstants.textArField: parameters.textAr.toString(),
      ApiConstants.textEnField: parameters.textEn.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.editWalletHistoryEndPoint,
      body: body,
      printErrorMessage: 'editWalletHistoryError',
    );
    return WalletHistoryModel.fromJson(response['walletHistory']);
  }

  @override
  Future<void> deleteWalletHistory(DeleteWalletHistoryParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.walletHistoryIdField: parameters.walletHistoryId.toString(),
    };
    await HttpHelper.postData(
      endPoint: ApiConstants.deleteWalletHistoryEndPoint,
      body: body,
      printErrorMessage: 'deleteWalletHistoryError',
    );
  }
  // endregion

  // region Categories
  @override
  Future<CategoriesResponse> getCategories(GetCategoriesParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.isPaginatedField: parameters.isPaginated.toString(),
      ApiConstants.limitField: parameters.limit.toString(),
      ApiConstants.pageField: parameters.page.toString(),
      ApiConstants.searchTextField: parameters.searchText.toString(),
      ApiConstants.filtersMapField: parameters.filtersMap.toString(),
      if(parameters.orderBy != null) ApiConstants.orderByField: parameters.orderBy!.query.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getCategoriesEndPoint,
      query: query,
      printErrorMessage: 'getCategoriesError',
    );
    return CategoriesResponse.fromJson(response);
  }

  @override
  Future<CategoryModel> getCategoryWithId(GetCategoryWithIdParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.categoryIdField: parameters.categoryId.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getCategoryWithIdEndPoint,
      query: query,
      printErrorMessage: 'getCategoryWithIdError',
    );
    return CategoryModel.fromJson(response['category']);
  }

  @override
  Future<CategoryModel> insertCategory(InsertCategoryParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.mainCategoryIdField: parameters.mainCategoryId.toString(),
      ApiConstants.nameArField: parameters.nameAr.toString(),
      ApiConstants.nameEnField: parameters.nameEn.toString(),
      ApiConstants.imageField: parameters.image.toString(),
      ApiConstants.customOrderField: parameters.customOrder.toString(),
      ApiConstants.createdAtField: parameters.createdAt.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.insertCategoryEndPoint,
      body: body,
      printErrorMessage: 'insertCategoryError',
    );
    return CategoryModel.fromJson(response['category']);
  }

  @override
  Future<CategoryModel> editCategory(EditCategoryParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.categoryIdField: parameters.categoryId.toString(),
      ApiConstants.mainCategoryIdField: parameters.mainCategoryId.toString(),
      ApiConstants.nameArField: parameters.nameAr.toString(),
      ApiConstants.nameEnField: parameters.nameEn.toString(),
      ApiConstants.imageField: parameters.image.toString(),
      ApiConstants.customOrderField: parameters.customOrder.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.editCategoryEndPoint,
      body: body,
      printErrorMessage: 'editCategoryError',
    );
    return CategoryModel.fromJson(response['category']);
  }

  @override
  Future<void> deleteCategory(DeleteCategoryParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.categoryIdField: parameters.categoryId.toString(),
    };
    await HttpHelper.postData(
      endPoint: ApiConstants.deleteCategoryEndPoint,
      body: body,
      printErrorMessage: 'deleteCategoryError',
    );
  }
  // endregion

  // region Main Categories
  @override
  Future<MainCategoriesResponse> getMainCategories(GetMainCategoriesParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.isPaginatedField: parameters.isPaginated.toString(),
      ApiConstants.limitField: parameters.limit.toString(),
      ApiConstants.pageField: parameters.page.toString(),
      ApiConstants.searchTextField: parameters.searchText.toString(),
      ApiConstants.filtersMapField: parameters.filtersMap.toString(),
      if(parameters.orderBy != null) ApiConstants.orderByField: parameters.orderBy!.query.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getMainCategoriesEndPoint,
      query: query,
      printErrorMessage: 'getMainCategoriesError',
    );
    return MainCategoriesResponse.fromJson(response);
  }

  @override
  Future<MainCategoryModel> getMainCategoryWithId(GetMainCategoryWithIdParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.mainCategoryIdField: parameters.mainCategoryId.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getMainCategoryWithIdEndPoint,
      query: query,
      printErrorMessage: 'getMainCategoryWithIdError',
    );
    return MainCategoryModel.fromJson(response['mainCategory']);
  }

  @override
  Future<MainCategoryModel> insertMainCategory(InsertMainCategoryParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.nameArField: parameters.nameAr.toString(),
      ApiConstants.nameEnField: parameters.nameEn.toString(),
      ApiConstants.imageField: parameters.image.toString(),
      ApiConstants.customOrderField: parameters.customOrder.toString(),
      ApiConstants.createdAtField: parameters.createdAt.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.insertMainCategoryEndPoint,
      body: body,
      printErrorMessage: 'insertMainCategoryError',
    );
    return MainCategoryModel.fromJson(response['mainCategory']);
  }

  @override
  Future<MainCategoryModel> editMainCategory(EditMainCategoryParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.mainCategoryIdField: parameters.mainCategoryId.toString(),
      ApiConstants.nameArField: parameters.nameAr.toString(),
      ApiConstants.nameEnField: parameters.nameEn.toString(),
      ApiConstants.imageField: parameters.image.toString(),
      ApiConstants.customOrderField: parameters.customOrder.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.editMainCategoryEndPoint,
      body: body,
      printErrorMessage: 'editMainCategoryError',
    );
    return MainCategoryModel.fromJson(response['mainCategory']);
  }

  @override
  Future<void> deleteMainCategory(DeleteMainCategoryParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.mainCategoryIdField: parameters.mainCategoryId.toString(),
    };
    await HttpHelper.postData(
      endPoint: ApiConstants.deleteMainCategoryEndPoint,
      body: body,
      printErrorMessage: 'deleteMainCategoryError',
    );
  }
  // endregion

  // region Jobs
  @override
  Future<JobsResponse> getJobs(GetJobsParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.isPaginatedField: parameters.isPaginated.toString(),
      ApiConstants.limitField: parameters.limit.toString(),
      ApiConstants.pageField: parameters.page.toString(),
      ApiConstants.searchTextField: parameters.searchText.toString(),
      ApiConstants.filtersMapField: parameters.filtersMap.toString(),
      if(parameters.orderBy != null) ApiConstants.orderByField: parameters.orderBy!.query.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getJobsEndPoint,
      query: query,
      printErrorMessage: 'getJobsError',
    );
    return JobsResponse.fromJson(response);
  }

  @override
  Future<JobModel> getJobWithId(GetJobWithIdParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.jobIdField: parameters.jobId.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getJobWithIdEndPoint,
      query: query,
      printErrorMessage: 'getJobWithIdError',
    );
    return JobModel.fromJson(response['job']);
  }

  @override
  Future<JobModel> insertJob(InsertJobParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.accountIdField: parameters.accountId.toString(),
      ApiConstants.imageField: parameters.image.toString(),
      ApiConstants.jobTitleField: parameters.jobTitle.toString(),
      ApiConstants.companyNameField: parameters.companyName.toString(),
      ApiConstants.aboutCompanyField: parameters.aboutCompany.toString(),
      ApiConstants.minSalaryField: parameters.minSalary.toString(),
      ApiConstants.maxSalaryField: parameters.maxSalary.toString(),
      ApiConstants.jobLocationField: parameters.jobLocation.toString(),
      ApiConstants.featuresField: parameters.features.map((e) => e).join('--'),
      ApiConstants.detailsField: parameters.details.toString(),
      ApiConstants.jobStatusField: parameters.jobStatus.name,
      ApiConstants.reasonOfRejectField: parameters.reasonOfReject.toString(),
      ApiConstants.isAvailableField: parameters.isAvailable.toString(),
      ApiConstants.createdAtField: parameters.createdAt.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.insertJobEndPoint,
      body: body,
      printErrorMessage: 'insertJobError',
    );
    return JobModel.fromJson(response['job']);
  }

  @override
  Future<JobModel> editJob(EditJobParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.jobIdField: parameters.jobId.toString(),
      ApiConstants.accountIdField: parameters.accountId.toString(),
      ApiConstants.imageField: parameters.image.toString(),
      ApiConstants.jobTitleField: parameters.jobTitle.toString(),
      ApiConstants.companyNameField: parameters.companyName.toString(),
      ApiConstants.aboutCompanyField: parameters.aboutCompany.toString(),
      ApiConstants.minSalaryField: parameters.minSalary.toString(),
      ApiConstants.maxSalaryField: parameters.maxSalary.toString(),
      ApiConstants.jobLocationField: parameters.jobLocation.toString(),
      ApiConstants.featuresField: parameters.features.map((e) => e).join('--'),
      ApiConstants.detailsField: parameters.details.toString(),
      ApiConstants.jobStatusField: parameters.jobStatus.name,
      ApiConstants.reasonOfRejectField: parameters.reasonOfReject.toString(),
      ApiConstants.isAvailableField: parameters.isAvailable.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.editJobEndPoint,
      body: body,
      printErrorMessage: 'editJobError',
    );
    return JobModel.fromJson(response['job']);
  }

  @override
  Future<void> deleteJob(DeleteJobParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.jobIdField: parameters.jobId.toString(),
    };
    await HttpHelper.postData(
      endPoint: ApiConstants.deleteJobEndPoint,
      body: body,
      printErrorMessage: 'deleteJobError',
    );
  }

  @override
  Future<JobModel> incrementJobViews(IncrementJobViewsParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.jobIdField: parameters.jobId.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.incrementJobViewsEndPoint,
      body: body,
      printErrorMessage: 'incrementJobViewsError',
    );
    return JobModel.fromJson(response['job']);
  }

  @override
  Future<JobModel> changeJobStatus(ChangeJobStatusParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.jobIdField: parameters.jobId.toString(),
      ApiConstants.jobStatusField: parameters.jobStatus.name,
      ApiConstants.reasonOfRejectField: parameters.reasonOfReject.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.changeJobStatusEndPoint,
      body: body,
      printErrorMessage: 'changeJobStatusError',
    );
    return JobModel.fromJson(response['job']);
  }
  // endregion

  // region Employment Applications
  @override
  Future<EmploymentApplicationsResponse> getEmploymentApplications(GetEmploymentApplicationsParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.isPaginatedField: parameters.isPaginated.toString(),
      ApiConstants.limitField: parameters.limit.toString(),
      ApiConstants.pageField: parameters.page.toString(),
      ApiConstants.searchTextField: parameters.searchText.toString(),
      ApiConstants.filtersMapField: parameters.filtersMap.toString(),
      if(parameters.orderBy != null) ApiConstants.orderByField: parameters.orderBy!.query.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getEmploymentApplicationsEndPoint,
      query: query,
      printErrorMessage: 'getEmploymentApplicationsError',
    );
    return EmploymentApplicationsResponse.fromJson(response);
  }

  @override
  Future<EmploymentApplicationModel> getEmploymentApplicationWithId(GetEmploymentApplicationWithIdParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.employmentApplicationIdField: parameters.employmentApplicationId.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getEmploymentApplicationWithIdEndPoint,
      query: query,
      printErrorMessage: 'getEmploymentApplicationWithIdError',
    );
    return EmploymentApplicationModel.fromJson(response['employmentApplication']);
  }

  @override
  Future<EmploymentApplicationModel> insertEmploymentApplication(InsertEmploymentApplicationParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.userIdField: parameters.userId.toString(),
      ApiConstants.jobIdField: parameters.jobId.toString(),
      ApiConstants.accountIdField: parameters.accountId.toString(),
      ApiConstants.cvField: parameters.cv.toString(),
      ApiConstants.createdAtField: parameters.createdAt.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.insertEmploymentApplicationEndPoint,
      body: body,
      printErrorMessage: 'insertEmploymentApplicationError',
    );
    return EmploymentApplicationModel.fromJson(response['employmentApplication']);
  }

  @override
  Future<EmploymentApplicationModel> editEmploymentApplication(EditEmploymentApplicationParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.employmentApplicationIdField: parameters.employmentApplicationId.toString(),
      ApiConstants.userIdField: parameters.userId.toString(),
      ApiConstants.jobIdField: parameters.jobId.toString(),
      ApiConstants.accountIdField: parameters.accountId.toString(),
      ApiConstants.cvField: parameters.cv.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.editEmploymentApplicationEndPoint,
      body: body,
      printErrorMessage: 'editEmploymentApplicationError',
    );
    return EmploymentApplicationModel.fromJson(response['employmentApplication']);
  }

  @override
  Future<void> deleteEmploymentApplication(DeleteEmploymentApplicationParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.employmentApplicationIdField: parameters.employmentApplicationId.toString(),
    };
    await HttpHelper.postData(
      endPoint: ApiConstants.deleteEmploymentApplicationEndPoint,
      body: body,
      printErrorMessage: 'deleteEmploymentApplicationError',
    );
  }
  // endregion

  // region Services
  @override
  Future<ServicesResponse> getServices(GetServicesParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.isPaginatedField: parameters.isPaginated.toString(),
      ApiConstants.limitField: parameters.limit.toString(),
      ApiConstants.pageField: parameters.page.toString(),
      ApiConstants.searchTextField: parameters.searchText.toString(),
      ApiConstants.filtersMapField: parameters.filtersMap.toString(),
      if(parameters.orderBy != null) ApiConstants.orderByField: parameters.orderBy!.query.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getServicesEndPoint,
      query: query,
      printErrorMessage: 'getServicesError',
    );
    return ServicesResponse.fromJson(response);
  }

  @override
  Future<ServiceModel> getServiceWithId(GetServiceWithIdParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.serviceIdField: parameters.serviceId.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getServiceWithIdEndPoint,
      query: query,
      printErrorMessage: 'getServiceWithIdError',
    );
    return ServiceModel.fromJson(response['service']);
  }

  @override
  Future<ServiceModel> insertService(InsertServiceParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.mainCategoryIdField: parameters.mainCategoryId.toString(),
      ApiConstants.nameArField: parameters.nameAr.toString(),
      ApiConstants.nameEnField: parameters.nameEn.toString(),
      ApiConstants.serviceInfoArField: parameters.serviceInfoAr.toString(),
      ApiConstants.serviceInfoEnField: parameters.serviceInfoEn.toString(),
      ApiConstants.serviceImageField: parameters.serviceImage.toString(),
      ApiConstants.additionalImageField: parameters.additionalImage.toString(),
      ApiConstants.availableForAccountField: parameters.availableForAccount.toString(),
      ApiConstants.serviceProviderCanSubscribeField: parameters.serviceProviderCanSubscribe.toString(),
      ApiConstants.customOrderField: parameters.customOrder.toString(),
      ApiConstants.createdAtField: parameters.createdAt.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.insertServiceEndPoint,
      body: body,
      printErrorMessage: 'insertServiceError',
    );
    return ServiceModel.fromJson(response['service']);
  }

  @override
  Future<ServiceModel> editService(EditServiceParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.serviceIdField: parameters.serviceId.toString(),
      ApiConstants.mainCategoryIdField: parameters.mainCategoryId.toString(),
      ApiConstants.nameArField: parameters.nameAr.toString(),
      ApiConstants.nameEnField: parameters.nameEn.toString(),
      ApiConstants.serviceInfoArField: parameters.serviceInfoAr.toString(),
      ApiConstants.serviceInfoEnField: parameters.serviceInfoEn.toString(),
      ApiConstants.serviceImageField: parameters.serviceImage.toString(),
      ApiConstants.additionalImageField: parameters.additionalImage.toString(),
      ApiConstants.availableForAccountField: parameters.availableForAccount.toString(),
      ApiConstants.serviceProviderCanSubscribeField: parameters.serviceProviderCanSubscribe.toString(),
      ApiConstants.customOrderField: parameters.customOrder.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.editServiceEndPoint,
      body: body,
      printErrorMessage: 'editServiceError',
    );
    return ServiceModel.fromJson(response['service']);
  }

  @override
  Future<void> deleteService(DeleteServiceParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.serviceIdField: parameters.serviceId.toString(),
    };
    await HttpHelper.postData(
      endPoint: ApiConstants.deleteServiceEndPoint,
      body: body,
      printErrorMessage: 'deleteServiceError',
    );
  }
  // endregion

  // region Features
  @override
  Future<FeaturesResponse> getFeatures(GetFeaturesParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.isPaginatedField: parameters.isPaginated.toString(),
      ApiConstants.limitField: parameters.limit.toString(),
      ApiConstants.pageField: parameters.page.toString(),
      ApiConstants.searchTextField: parameters.searchText.toString(),
      ApiConstants.filtersMapField: parameters.filtersMap.toString(),
      if(parameters.orderBy != null) ApiConstants.orderByField: parameters.orderBy!.query.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getFeaturesEndPoint,
      query: query,
      printErrorMessage: 'getFeaturesError',
    );
    return FeaturesResponse.fromJson(response);
  }

  @override
  Future<FeatureModel> getFeatureWithId(GetFeatureWithIdParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.featureIdField: parameters.featureId.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getFeatureWithIdEndPoint,
      query: query,
      printErrorMessage: 'getFeatureWithIdError',
    );
    return FeatureModel.fromJson(response['feature']);
  }

  @override
  Future<FeatureModel> insertFeature(InsertFeatureParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.mainCategoryIdField: parameters.mainCategoryId.toString(),
      ApiConstants.featureArField: parameters.featureAr.toString(),
      ApiConstants.featureEnField: parameters.featureEn.toString(),
      ApiConstants.createdAtField: parameters.createdAt.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.insertFeatureEndPoint,
      body: body,
      printErrorMessage: 'insertFeatureError',
    );
    return FeatureModel.fromJson(response['feature']);
  }

  @override
  Future<FeatureModel> editFeature(EditFeatureParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.featureIdField: parameters.featureId.toString(),
      ApiConstants.mainCategoryIdField: parameters.mainCategoryId.toString(),
      ApiConstants.featureArField: parameters.featureAr.toString(),
      ApiConstants.featureEnField: parameters.featureEn.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.editFeatureEndPoint,
      body: body,
      printErrorMessage: 'editFeatureError',
    );
    return FeatureModel.fromJson(response['feature']);
  }

  @override
  Future<void> deleteFeature(DeleteFeatureParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.featureIdField: parameters.featureId.toString(),
    };
    await HttpHelper.postData(
      endPoint: ApiConstants.deleteFeatureEndPoint,
      body: body,
      printErrorMessage: 'deleteFeatureError',
    );
  }
  // endregion

  // region Reviews
  @override
  Future<ReviewsResponse> getReviews(GetReviewsParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.isPaginatedField: parameters.isPaginated.toString(),
      ApiConstants.limitField: parameters.limit.toString(),
      ApiConstants.pageField: parameters.page.toString(),
      ApiConstants.searchTextField: parameters.searchText.toString(),
      ApiConstants.filtersMapField: parameters.filtersMap.toString(),
      if(parameters.orderBy != null) ApiConstants.orderByField: parameters.orderBy!.query.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getReviewsEndPoint,
      query: query,
      printErrorMessage: 'getReviewsError',
    );
    return ReviewsResponse.fromJson(response);
  }

  @override
  Future<ReviewModel> getReviewWithId(GetReviewWithIdParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.reviewIdField: parameters.reviewId.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getReviewWithIdEndPoint,
      query: query,
      printErrorMessage: 'getReviewWithIdError',
    );
    return ReviewModel.fromJson(response['review']);
  }

  @override
  Future<ReviewModel> insertReview(InsertReviewParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.accountIdField: parameters.accountId.toString(),
      ApiConstants.userIdField: parameters.userId.toString(),
      ApiConstants.commentField: parameters.comment.toString(),
      ApiConstants.ratingField: parameters.rating.toString(),
      ApiConstants.featuresArField: parameters.featuresAr.map((e) => e).join('--'),
      ApiConstants.featuresEnField: parameters.featuresEn.map((e) => e).join('--'),
      ApiConstants.createdAtField: parameters.createdAt.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.insertReviewEndPoint,
      body: body,
      printErrorMessage: 'insertReviewError',
    );
    return ReviewModel.fromJson(response['review']);
  }

  @override
  Future<ReviewModel> editReview(EditReviewParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.reviewIdField: parameters.reviewId.toString(),
      ApiConstants.accountIdField: parameters.accountId.toString(),
      ApiConstants.userIdField: parameters.userId.toString(),
      ApiConstants.commentField: parameters.comment.toString(),
      ApiConstants.ratingField: parameters.rating.toString(),
      ApiConstants.featuresArField: parameters.featuresAr.map((e) => e).join('--'),
      ApiConstants.featuresEnField: parameters.featuresEn.map((e) => e).join('--'),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.editReviewEndPoint,
      body: body,
      printErrorMessage: 'editReviewError',
    );
    return ReviewModel.fromJson(response['review']);
  }

  @override
  Future<void> deleteReview(DeleteReviewParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.reviewIdField: parameters.reviewId.toString(),
    };
    await HttpHelper.postData(
      endPoint: ApiConstants.deleteReviewEndPoint,
      body: body,
      printErrorMessage: 'deleteReviewError',
    );
  }
  // endregion

  // region Playlists
  @override
  Future<PlaylistsResponse> getPlaylists(GetPlaylistsParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.isPaginatedField: parameters.isPaginated.toString(),
      ApiConstants.limitField: parameters.limit.toString(),
      ApiConstants.pageField: parameters.page.toString(),
      ApiConstants.searchTextField: parameters.searchText.toString(),
      ApiConstants.filtersMapField: parameters.filtersMap.toString(),
      if(parameters.orderBy != null) ApiConstants.orderByField: parameters.orderBy!.query.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getPlaylistsEndPoint,
      query: query,
      printErrorMessage: 'getPlaylistsError',
    );
    return PlaylistsResponse.fromJson(response);
  }

  @override
  Future<PlaylistModel> getPlaylistWithId(GetPlaylistWithIdParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.playlistIdField: parameters.playlistId.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getPlaylistWithIdEndPoint,
      query: query,
      printErrorMessage: 'getPlaylistWithIdError',
    );
    return PlaylistModel.fromJson(response['playlist']);
  }

  @override
  Future<PlaylistModel> insertPlaylist(InsertPlaylistParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.imageField: parameters.image.toString(),
      ApiConstants.playlistNameArField: parameters.playlistNameAr.toString(),
      ApiConstants.playlistNameEnField: parameters.playlistNameEn.toString(),
      ApiConstants.createdAtField: parameters.createdAt.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.insertPlaylistEndPoint,
      body: body,
      printErrorMessage: 'insertPlaylistError',
    );
    return PlaylistModel.fromJson(response['playlist']);
  }

  @override
  Future<PlaylistModel> editPlaylist(EditPlaylistParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.playlistIdField: parameters.playlistId.toString(),
      ApiConstants.imageField: parameters.image.toString(),
      ApiConstants.playlistNameArField: parameters.playlistNameAr.toString(),
      ApiConstants.playlistNameEnField: parameters.playlistNameEn.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.editPlaylistEndPoint,
      body: body,
      printErrorMessage: 'editPlaylistError',
    );
    return PlaylistModel.fromJson(response['playlist']);
  }

  @override
  Future<void> deletePlaylist(DeletePlaylistParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.playlistIdField: parameters.playlistId.toString(),
    };
    await HttpHelper.postData(
      endPoint: ApiConstants.deletePlaylistEndPoint,
      body: body,
      printErrorMessage: 'deletePlaylistError',
    );
  }
  // endregion

  // region Videos
  @override
  Future<VideosResponse> getVideos(GetVideosParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.isPaginatedField: parameters.isPaginated.toString(),
      ApiConstants.limitField: parameters.limit.toString(),
      ApiConstants.pageField: parameters.page.toString(),
      ApiConstants.searchTextField: parameters.searchText.toString(),
      ApiConstants.filtersMapField: parameters.filtersMap.toString(),
      if(parameters.orderBy != null) ApiConstants.orderByField: parameters.orderBy!.query.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getVideosEndPoint,
      query: query,
      printErrorMessage: 'getVideosError',
    );
    return VideosResponse.fromJson(response);
  }

  @override
  Future<VideoModel> getVideoWithId(GetVideoWithIdParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.videoIdField: parameters.videoId.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getVideoWithIdEndPoint,
      query: query,
      printErrorMessage: 'getVideoWithIdError',
    );
    return VideoModel.fromJson(response['video']);
  }

  @override
  Future<VideoModel> insertVideo(InsertVideoParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.playlistIdField: parameters.playlistId.toString(),
      ApiConstants.titleArField: parameters.titleAr.toString(),
      ApiConstants.titleEnField: parameters.titleEn.toString(),
      ApiConstants.linkField: parameters.link.toString(),
      ApiConstants.aboutVideoArField: parameters.aboutVideoAr.toString(),
      ApiConstants.aboutVideoEnField: parameters.aboutVideoEn.toString(),
      ApiConstants.createdAtField: parameters.createdAt.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.insertVideoEndPoint,
      body: body,
      printErrorMessage: 'insertVideoError',
    );
    return VideoModel.fromJson(response['video']);
  }

  @override
  Future<VideoModel> editVideo(EditVideoParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.videoIdField: parameters.videoId.toString(),
      ApiConstants.playlistIdField: parameters.playlistId.toString(),
      ApiConstants.titleArField: parameters.titleAr.toString(),
      ApiConstants.titleEnField: parameters.titleEn.toString(),
      ApiConstants.linkField: parameters.link.toString(),
      ApiConstants.aboutVideoArField: parameters.aboutVideoAr.toString(),
      ApiConstants.aboutVideoEnField: parameters.aboutVideoEn.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.editVideoEndPoint,
      body: body,
      printErrorMessage: 'editVideoError',
    );
    return VideoModel.fromJson(response['video']);
  }

  @override
  Future<void> deleteVideo(DeleteVideoParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.videoIdField: parameters.videoId.toString(),
    };
    await HttpHelper.postData(
      endPoint: ApiConstants.deleteVideoEndPoint,
      body: body,
      printErrorMessage: 'deleteVideoError',
    );
  }
  // endregion

  // region Playlists Comments
  @override
  Future<PlaylistsCommentsResponse> getPlaylistsComments(GetPlaylistsCommentsParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.isPaginatedField: parameters.isPaginated.toString(),
      ApiConstants.limitField: parameters.limit.toString(),
      ApiConstants.pageField: parameters.page.toString(),
      ApiConstants.searchTextField: parameters.searchText.toString(),
      ApiConstants.filtersMapField: parameters.filtersMap.toString(),
      if(parameters.orderBy != null) ApiConstants.orderByField: parameters.orderBy!.query.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getPlaylistsCommentsEndPoint,
      query: query,
      printErrorMessage: 'getPlaylistsCommentsError',
    );
    return PlaylistsCommentsResponse.fromJson(response);
  }

  @override
  Future<PlaylistCommentModel> getPlaylistCommentWithId(GetPlaylistCommentWithIdParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.playlistCommentIdField: parameters.playlistCommentId.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getPlaylistCommentWithIdEndPoint,
      query: query,
      printErrorMessage: 'getPlaylistCommentWithIdError',
    );
    return PlaylistCommentModel.fromJson(response['playlistComment']);
  }

  @override
  Future<PlaylistCommentModel> insertPlaylistComment(InsertPlaylistCommentParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.playlistIdField: parameters.playlistId.toString(),
      ApiConstants.userIdField: parameters.userId.toString(),
      ApiConstants.commentField: parameters.comment.toString(),
      ApiConstants.createdAtField: parameters.createdAt.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.insertPlaylistCommentEndPoint,
      body: body,
      printErrorMessage: 'insertPlaylistCommentError',
    );
    return PlaylistCommentModel.fromJson(response['playlistComment']);
  }

  @override
  Future<PlaylistCommentModel> editPlaylistComment(EditPlaylistCommentParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.playlistCommentIdField: parameters.playlistCommentId.toString(),
      ApiConstants.playlistIdField: parameters.playlistId.toString(),
      ApiConstants.userIdField: parameters.userId.toString(),
      ApiConstants.commentField: parameters.comment.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.editPlaylistCommentEndPoint,
      body: body,
      printErrorMessage: 'editPlaylistCommentError',
    );
    return PlaylistCommentModel.fromJson(response['playlistComment']);
  }

  @override
  Future<void> deletePlaylistComment(DeletePlaylistCommentParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.playlistCommentIdField: parameters.playlistCommentId.toString(),
    };
    await HttpHelper.postData(
      endPoint: ApiConstants.deletePlaylistCommentEndPoint,
      body: body,
      printErrorMessage: 'deletePlaylistCommentError',
    );
  }
  // endregion

  // region Phone Number Requests
  @override
  Future<PhoneNumberRequestsResponse> getPhoneNumberRequests(GetPhoneNumberRequestsParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.isPaginatedField: parameters.isPaginated.toString(),
      ApiConstants.limitField: parameters.limit.toString(),
      ApiConstants.pageField: parameters.page.toString(),
      ApiConstants.searchTextField: parameters.searchText.toString(),
      ApiConstants.filtersMapField: parameters.filtersMap.toString(),
      if(parameters.orderBy != null) ApiConstants.orderByField: parameters.orderBy!.query.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getPhoneNumberRequestsEndPoint,
      query: query,
      printErrorMessage: 'getPhoneNumberRequestsError',
    );
    return PhoneNumberRequestsResponse.fromJson(response);
  }

  @override
  Future<PhoneNumberRequestModel> getPhoneNumberRequestWithId(GetPhoneNumberRequestWithIdParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.phoneNumberRequestIdField: parameters.phoneNumberRequestId.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getPhoneNumberRequestWithIdEndPoint,
      query: query,
      printErrorMessage: 'getPhoneNumberRequestWithIdError',
    );
    return PhoneNumberRequestModel.fromJson(response['phoneNumberRequest']);
  }

  @override
  Future<PhoneNumberRequestModel> insertPhoneNumberRequest(InsertPhoneNumberRequestParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.accountIdField: parameters.accountId.toString(),
      ApiConstants.userIdField: parameters.userId.toString(),
      ApiConstants.isViewedField: parameters.isViewed.toString(),
      ApiConstants.createdAtField: parameters.createdAt.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.insertPhoneNumberRequestEndPoint,
      body: body,
      printErrorMessage: 'insertPhoneNumberRequestError',
    );
    return PhoneNumberRequestModel.fromJson(response['phoneNumberRequest']);
  }

  @override
  Future<PhoneNumberRequestModel> editPhoneNumberRequest(EditPhoneNumberRequestParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.phoneNumberRequestIdField: parameters.phoneNumberRequestId.toString(),
      ApiConstants.accountIdField: parameters.accountId.toString(),
      ApiConstants.userIdField: parameters.userId.toString(),
      ApiConstants.isViewedField: parameters.isViewed.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.editPhoneNumberRequestEndPoint,
      body: body,
      printErrorMessage: 'editPhoneNumberRequestError',
    );
    return PhoneNumberRequestModel.fromJson(response['phoneNumberRequest']);
  }

  @override
  Future<void> deletePhoneNumberRequest(DeletePhoneNumberRequestParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.phoneNumberRequestIdField: parameters.phoneNumberRequestId.toString(),
    };
    await HttpHelper.postData(
      endPoint: ApiConstants.deletePhoneNumberRequestEndPoint,
      body: body,
      printErrorMessage: 'deletePhoneNumberRequestError',
    );
  }
  // endregion

  // region Booking Appointments
  @override
  Future<BookingAppointmentsResponse> getBookingAppointments(GetBookingAppointmentsParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.isPaginatedField: parameters.isPaginated.toString(),
      ApiConstants.limitField: parameters.limit.toString(),
      ApiConstants.pageField: parameters.page.toString(),
      ApiConstants.searchTextField: parameters.searchText.toString(),
      ApiConstants.filtersMapField: parameters.filtersMap.toString(),
      if(parameters.orderBy != null) ApiConstants.orderByField: parameters.orderBy!.query.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getBookingAppointmentsEndPoint,
      query: query,
      printErrorMessage: 'getBookingAppointmentsError',
    );
    return BookingAppointmentsResponse.fromJson(response);
  }

  @override
  Future<BookingAppointmentModel> getBookingAppointmentWithId(GetBookingAppointmentWithIdParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.bookingAppointmentIdField: parameters.bookingAppointmentId.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getBookingAppointmentWithIdEndPoint,
      query: query,
      printErrorMessage: 'getBookingAppointmentWithIdError',
    );
    return BookingAppointmentModel.fromJson(response['bookingAppointment']);
  }

  @override
  Future<BookingAppointmentModel> insertBookingAppointment(InsertBookingAppointmentParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.accountIdField: parameters.accountId.toString(),
      ApiConstants.userIdField: parameters.userId.toString(),
      ApiConstants.bookingDateField: parameters.bookingDate.toString(),
      ApiConstants.isViewedField: parameters.isViewed.toString(),
      ApiConstants.createdAtField: parameters.createdAt.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.insertBookingAppointmentEndPoint,
      body: body,
      printErrorMessage: 'insertBookingAppointmentError',
    );
    return BookingAppointmentModel.fromJson(response['bookingAppointment']);
  }

  @override
  Future<BookingAppointmentModel> editBookingAppointment(EditBookingAppointmentParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.bookingAppointmentIdField: parameters.bookingAppointmentId.toString(),
      ApiConstants.accountIdField: parameters.accountId.toString(),
      ApiConstants.userIdField: parameters.userId.toString(),
      ApiConstants.bookingDateField: parameters.bookingDate.toString(),
      ApiConstants.isViewedField: parameters.isViewed.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.editBookingAppointmentEndPoint,
      body: body,
      printErrorMessage: 'editBookingAppointmentError',
    );
    return BookingAppointmentModel.fromJson(response['bookingAppointment']);
  }

  @override
  Future<void> deleteBookingAppointment(DeleteBookingAppointmentParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.bookingAppointmentIdField: parameters.bookingAppointmentId.toString(),
    };
    await HttpHelper.postData(
      endPoint: ApiConstants.deleteBookingAppointmentEndPoint,
      body: body,
      printErrorMessage: 'deleteBookingAppointmentError',
    );
  }
  // endregion

  // region Instant Consultations
  @override
  Future<InstantConsultationsResponse> getInstantConsultations(GetInstantConsultationsParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.isPaginatedField: parameters.isPaginated.toString(),
      ApiConstants.limitField: parameters.limit.toString(),
      ApiConstants.pageField: parameters.page.toString(),
      ApiConstants.searchTextField: parameters.searchText.toString(),
      ApiConstants.filtersMapField: parameters.filtersMap.toString(),
      if(parameters.orderBy != null) ApiConstants.orderByField: parameters.orderBy!.query.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getInstantConsultationsEndPoint,
      query: query,
      printErrorMessage: 'getInstantConsultationsError',
    );
    return InstantConsultationsResponse.fromJson(response);
  }

  @override
  Future<InstantConsultationModel> getInstantConsultationWithId(GetInstantConsultationWithIdParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.instantConsultationIdField: parameters.instantConsultationId.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getInstantConsultationWithIdEndPoint,
      query: query,
      printErrorMessage: 'getInstantConsultationWithIdError',
    );
    return InstantConsultationModel.fromJson(response['bookingAppointment']);
  }

  @override
  Future<InstantConsultationModel> insertInstantConsultation(InsertInstantConsultationParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.userIdField: parameters.userId.toString(),
      ApiConstants.consultationField: parameters.consultation.toString(),
      ApiConstants.isDoneField: parameters.isDone.toString(),
      ApiConstants.bestAccountIdField: parameters.bestAccountId.toString(),
      ApiConstants.isViewedField: parameters.isViewed.toString(),
      ApiConstants.imagesField: parameters.images.map((e) => e).join('--'),
      ApiConstants.createdAtField: parameters.createdAt.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.insertInstantConsultationEndPoint,
      body: body,
      printErrorMessage: 'insertInstantConsultationError',
    );
    return InstantConsultationModel.fromJson(response['instantConsultation']);
  }

  @override
  Future<InstantConsultationModel> editInstantConsultation(EditInstantConsultationParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.instantConsultationIdField: parameters.instantConsultationId.toString(),
      ApiConstants.userIdField: parameters.userId.toString(),
      ApiConstants.consultationField: parameters.consultation.toString(),
      ApiConstants.isDoneField: parameters.isDone.toString(),
      ApiConstants.bestAccountIdField: parameters.bestAccountId.toString(),
      ApiConstants.isViewedField: parameters.isViewed.toString(),
      ApiConstants.imagesField: parameters.images.map((e) => e).join('--'),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.editInstantConsultationEndPoint,
      body: body,
      printErrorMessage: 'editInstantConsultationError',
    );
    return InstantConsultationModel.fromJson(response['instantConsultation']);
  }

  @override
  Future<void> deleteInstantConsultation(DeleteInstantConsultationParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.instantConsultationIdField: parameters.instantConsultationId.toString(),
    };
    await HttpHelper.postData(
      endPoint: ApiConstants.deleteInstantConsultationEndPoint,
      body: body,
      printErrorMessage: 'deleteInstantConsultationError',
    );
  }
  // endregion

  // region Instant Consultations Comments
  @override
  Future<InstantConsultationsCommentsResponse> getInstantConsultationsComments(GetInstantConsultationsCommentsParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.isPaginatedField: parameters.isPaginated.toString(),
      ApiConstants.limitField: parameters.limit.toString(),
      ApiConstants.pageField: parameters.page.toString(),
      ApiConstants.searchTextField: parameters.searchText.toString(),
      ApiConstants.filtersMapField: parameters.filtersMap.toString(),
      if(parameters.orderBy != null) ApiConstants.orderByField: parameters.orderBy!.query.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getInstantConsultationsCommentsEndPoint,
      query: query,
      printErrorMessage: 'getInstantConsultationsCommentsError',
    );
    return InstantConsultationsCommentsResponse.fromJson(response);
  }

  @override
  Future<InstantConsultationCommentModel> getInstantConsultationCommentWithId(GetInstantConsultationCommentWithIdParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.instantConsultationCommentIdField: parameters.instantConsultationCommentId.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getInstantConsultationCommentWithIdEndPoint,
      query: query,
      printErrorMessage: 'getInstantConsultationCommentWithIdError',
    );
    return InstantConsultationCommentModel.fromJson(response['instantConsultationComment']);
  }

  @override
  Future<InstantConsultationCommentModel> insertInstantConsultationComment(InsertInstantConsultationCommentParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.instantConsultationIdField: parameters.instantConsultationId.toString(),
      ApiConstants.accountIdField: parameters.accountId.toString(),
      ApiConstants.commentField: parameters.comment.toString(),
      ApiConstants.commentStatusField: parameters.commentStatus.name,
      ApiConstants.reasonOfRejectField: parameters.reasonOfReject.toString(),
      ApiConstants.createdAtField: parameters.createdAt.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.insertInstantConsultationCommentEndPoint,
      body: body,
      printErrorMessage: 'insertInstantConsultationCommentError',
    );
    return InstantConsultationCommentModel.fromJson(response['instantConsultationComment']);
  }

  @override
  Future<InstantConsultationCommentModel> editInstantConsultationComment(EditInstantConsultationCommentParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.instantConsultationCommentIdField: parameters.instantConsultationCommentId.toString(),
      ApiConstants.instantConsultationIdField: parameters.instantConsultationId.toString(),
      ApiConstants.accountIdField: parameters.accountId.toString(),
      ApiConstants.commentField: parameters.comment.toString(),
      ApiConstants.commentStatusField: parameters.commentStatus.name,
      ApiConstants.reasonOfRejectField: parameters.reasonOfReject.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.editInstantConsultationCommentEndPoint,
      body: body,
      printErrorMessage: 'editInstantConsultationCommentError',
    );
    return InstantConsultationCommentModel.fromJson(response['instantConsultationComment']);
  }

  @override
  Future<void> deleteInstantConsultationComment(DeleteInstantConsultationCommentParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.instantConsultationCommentIdField: parameters.instantConsultationCommentId.toString(),
    };
    await HttpHelper.postData(
      endPoint: ApiConstants.deleteInstantConsultationCommentEndPoint,
      body: body,
      printErrorMessage: 'deleteInstantConsultationCommentError',
    );
  }
  // endregion

  // region Secret Consultations
  @override
  Future<SecretConsultationsResponse> getSecretConsultations(GetSecretConsultationsParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.isPaginatedField: parameters.isPaginated.toString(),
      ApiConstants.limitField: parameters.limit.toString(),
      ApiConstants.pageField: parameters.page.toString(),
      ApiConstants.searchTextField: parameters.searchText.toString(),
      ApiConstants.filtersMapField: parameters.filtersMap.toString(),
      if(parameters.orderBy != null) ApiConstants.orderByField: parameters.orderBy!.query.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getSecretConsultationsEndPoint,
      query: query,
      printErrorMessage: 'getSecretConsultationsError',
    );
    return SecretConsultationsResponse.fromJson(response);
  }

  @override
  Future<SecretConsultationModel> getSecretConsultationWithId(GetSecretConsultationWithIdParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.secretConsultationIdField: parameters.secretConsultationId.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getSecretConsultationWithIdEndPoint,
      query: query,
      printErrorMessage: 'getSecretConsultationWithIdError',
    );
    return SecretConsultationModel.fromJson(response['secretConsultation']);
  }

  @override
  Future<SecretConsultationModel> insertSecretConsultation(InsertSecretConsultationParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.userIdField: parameters.userId.toString(),
      ApiConstants.consultationField: parameters.consultation.toString(),
      ApiConstants.isViewedField: parameters.isViewed.toString(),
      ApiConstants.isRepliedField: parameters.isReplied.toString(),
      ApiConstants.secretConsultationReplyTypeField: parameters.secretConsultationReplyType.name,
      ApiConstants.replyTypeValueField: parameters.replyTypeValue.toString(),
      ApiConstants.imagesField: parameters.images.map((e) => e).join('--'),
      ApiConstants.createdAtField: parameters.createdAt.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.insertSecretConsultationEndPoint,
      body: body,
      printErrorMessage: 'insertSecretConsultationError',
    );
    return SecretConsultationModel.fromJson(response['secretConsultation']);
  }

  @override
  Future<SecretConsultationModel> editSecretConsultation(EditSecretConsultationParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.secretConsultationIdField: parameters.secretConsultationId.toString(),
      ApiConstants.userIdField: parameters.userId.toString(),
      ApiConstants.consultationField: parameters.consultation.toString(),
      ApiConstants.isViewedField: parameters.isViewed.toString(),
      ApiConstants.isRepliedField: parameters.isReplied.toString(),
      ApiConstants.secretConsultationReplyTypeField: parameters.secretConsultationReplyType.name,
      ApiConstants.replyTypeValueField: parameters.replyTypeValue.toString(),
      ApiConstants.imagesField: parameters.images.map((e) => e).join('--'),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.editSecretConsultationEndPoint,
      body: body,
      printErrorMessage: 'editSecretConsultationError',
    );
    return SecretConsultationModel.fromJson(response['secretConsultation']);
  }

  @override
  Future<void> deleteSecretConsultation(DeleteSecretConsultationParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.secretConsultationIdField: parameters.secretConsultationId.toString(),
    };
    await HttpHelper.postData(
      endPoint: ApiConstants.deleteSecretConsultationEndPoint,
      body: body,
      printErrorMessage: 'deleteSecretConsultationError',
    );
  }
  // endregion

  // region Withdrawal Requests
  @override
  Future<WithdrawalRequestsResponse> getWithdrawalRequests(GetWithdrawalRequestsParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.isPaginatedField: parameters.isPaginated.toString(),
      ApiConstants.limitField: parameters.limit.toString(),
      ApiConstants.pageField: parameters.page.toString(),
      ApiConstants.searchTextField: parameters.searchText.toString(),
      ApiConstants.filtersMapField: parameters.filtersMap.toString(),
      if(parameters.orderBy != null) ApiConstants.orderByField: parameters.orderBy!.query.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getWithdrawalRequestsEndPoint,
      query: query,
      printErrorMessage: 'getWithdrawalRequestsError',
    );
    return WithdrawalRequestsResponse.fromJson(response);
  }

  @override
  Future<WithdrawalRequestModel> getWithdrawalRequestWithId(GetWithdrawalRequestWithIdParameters parameters) async {
    Map<String, String> query = {
      ApiConstants.withdrawalRequestIdField: parameters.withdrawalRequestId.toString(),
    };
    var response = await HttpHelper.getData(
      endPoint: ApiConstants.getWithdrawalRequestWithIdEndPoint,
      query: query,
      printErrorMessage: 'getWithdrawalRequestWithIdError',
    );
    return WithdrawalRequestModel.fromJson(response['withdrawalRequest']);
  }

  @override
  Future<WithdrawalRequestModel> insertWithdrawalRequest(InsertWithdrawalRequestParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.accountIdField: parameters.accountId.toString(),
      ApiConstants.withdrawalRequestStatusField: parameters.withdrawalRequestStatus.name,
      ApiConstants.reasonOfRejectField: parameters.reasonOfReject.toString(),
      ApiConstants.balanceField: parameters.balance.toString(),
      ApiConstants.paymentTypeField: parameters.paymentType.name,
      ApiConstants.paymentTypeValueField: parameters.paymentTypeValue.toString(),
      ApiConstants.createdAtField: parameters.createdAt.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.insertWithdrawalRequestEndPoint,
      body: body,
      printErrorMessage: 'insertWithdrawalRequestError',
    );
    return WithdrawalRequestModel.fromJson(response['withdrawalRequest']);
  }

  @override
  Future<WithdrawalRequestModel> editWithdrawalRequest(EditWithdrawalRequestParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.withdrawalRequestIdField: parameters.withdrawalRequestId.toString(),
      ApiConstants.accountIdField: parameters.accountId.toString(),
      ApiConstants.withdrawalRequestStatusField: parameters.withdrawalRequestStatus.name,
      ApiConstants.reasonOfRejectField: parameters.reasonOfReject.toString(),
      ApiConstants.balanceField: parameters.balance.toString(),
      ApiConstants.paymentTypeField: parameters.paymentType.name,
      ApiConstants.paymentTypeValueField: parameters.paymentTypeValue.toString(),
    };
    var response = await HttpHelper.postData(
      endPoint: ApiConstants.editWithdrawalRequestEndPoint,
      body: body,
      printErrorMessage: 'editWithdrawalRequestError',
    );
    return WithdrawalRequestModel.fromJson(response['withdrawalRequest']);
  }

  @override
  Future<void> deleteWithdrawalRequest(DeleteWithdrawalRequestParameters parameters) async {
    Map<String, String> body = {
      ApiConstants.withdrawalRequestIdField: parameters.withdrawalRequestId.toString(),
    };
    await HttpHelper.postData(
      endPoint: ApiConstants.deleteWithdrawalRequestEndPoint,
      body: body,
      printErrorMessage: 'deleteWithdrawalRequestError',
    );
  }
  // endregion
}