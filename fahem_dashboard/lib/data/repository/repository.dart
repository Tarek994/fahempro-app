import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/data/models/account_model.dart';
import 'package:fahem_dashboard/data/models/feature_model.dart';
import 'package:fahem_dashboard/data/models/main_category_model.dart';
import 'package:fahem_dashboard/data/models/playlist_comment_model.dart';
import 'package:fahem_dashboard/data/models/playlist_model.dart';
import 'package:fahem_dashboard/data/models/review_model.dart';
import 'package:fahem_dashboard/data/models/service_description_model.dart';
import 'package:fahem_dashboard/data/models/service_model.dart';
import 'package:fahem_dashboard/data/models/statistic_model.dart';
import 'package:fahem_dashboard/data/models/suggested_message_model.dart';
import 'package:fahem_dashboard/data/models/user_model.dart';
import 'package:fahem_dashboard/data/models/admin_model.dart';
import 'package:fahem_dashboard/data/models/video_model.dart';
import 'package:fahem_dashboard/data/models/wallet_history_model.dart';
import 'package:fahem_dashboard/data/models/withdrawal_request_model.dart';
import 'package:fahem_dashboard/data/response/accounts_response.dart';
import 'package:fahem_dashboard/data/response/admins_response.dart';
import 'package:fahem_dashboard/data/response/features_response.dart';
import 'package:fahem_dashboard/data/response/main_categories_response.dart';
import 'package:fahem_dashboard/data/response/playlists_comments_response.dart';
import 'package:fahem_dashboard/data/response/playlists_response.dart';
import 'package:fahem_dashboard/data/response/reviews_response.dart';
import 'package:fahem_dashboard/data/response/services_response.dart';
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
import 'package:fahem_dashboard/domain/usecases/chats/add_chat_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/chats/add_message_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/chats/update_message_mode_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/features/delete_feature_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/features/edit_feature_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/features/get_feature_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/features/get_features_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/features/insert_feature_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/jobs/change_job_status_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/jobs/increment_job_views_usecase.dart';
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
import 'package:fahem_dashboard/domain/usecases/service_description/edit_service_description_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/services/delete_service_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/services/edit_service_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/services/get_service_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/services/get_services_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/services/insert_service_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/social_media/delete_social_media_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/social_media/get_social_media_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/social_media/get_social_media_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/articles/insert_article_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/social_media/insert_social_media_usecase.dart';
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
import 'package:flutter/material.dart';
import 'package:fahem_dashboard/core/error/exceptions.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/core/network/network_info.dart';
import 'package:fahem_dashboard/data/data_source/remote/remote_data_source.dart';
import 'package:fahem_dashboard/data/models/about_app_model.dart';
import 'package:fahem_dashboard/data/models/category_model.dart';
import 'package:fahem_dashboard/data/models/complaint_model.dart';
import 'package:fahem_dashboard/data/models/faq_model.dart';
import 'package:fahem_dashboard/data/models/phone_number_request_model.dart';
import 'package:fahem_dashboard/data/models/booking_appointment_model.dart';
import 'package:fahem_dashboard/data/models/instant_consultation_model.dart';
import 'package:fahem_dashboard/data/models/instant_consultation_comment_model.dart';
import 'package:fahem_dashboard/data/models/secret_consultation_model.dart';
import 'package:fahem_dashboard/data/models/article_model.dart';
import 'package:fahem_dashboard/data/models/notification_model.dart';
import 'package:fahem_dashboard/data/models/admin_notification_model.dart';
import 'package:fahem_dashboard/data/models/privacy_policy_model.dart';
import 'package:fahem_dashboard/data/models/slider_model.dart';
import 'package:fahem_dashboard/data/models/job_model.dart';
import 'package:fahem_dashboard/data/models/employment_application_model.dart';
import 'package:fahem_dashboard/data/models/social_media_model.dart';
import 'package:fahem_dashboard/data/models/terms_of_use_model.dart';
import 'package:fahem_dashboard/data/models/version_model.dart';
import 'package:fahem_dashboard/data/response/categories_response.dart';
import 'package:fahem_dashboard/data/response/complaints_response.dart';
import 'package:fahem_dashboard/data/response/faqs_response.dart';
import 'package:fahem_dashboard/data/response/phone_number_requests_response.dart';
import 'package:fahem_dashboard/data/response/booking_appointments_response.dart';
import 'package:fahem_dashboard/data/response/instant_consultations_response.dart';
import 'package:fahem_dashboard/data/response/instant_consultations_comments_response.dart';
import 'package:fahem_dashboard/data/response/secret_consultations_response.dart';
import 'package:fahem_dashboard/data/response/articles_response.dart';
import 'package:fahem_dashboard/data/response/notifications_response.dart';
import 'package:fahem_dashboard/data/response/admin_notifications_response.dart';
import 'package:fahem_dashboard/data/response/sliders_response.dart';
import 'package:fahem_dashboard/data/response/jobs_response.dart';
import 'package:fahem_dashboard/data/response/employment_applications_response.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/about_app/edit_about_app_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/categories/delete_category_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/categories/edit_category_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/categories/insert_category_usecase.dart';
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
import 'package:fahem_dashboard/domain/usecases/privacy_policy/edit_privacy_policy_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/admin_notifications/delete_admin_notification_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/admin_notifications/get_admin_notification_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/admin_notifications/get_admin_notifications_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/admin_notifications/insert_admin_notification_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/sliders/delete_slider_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/sliders/edit_slider_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/sliders/get_slider_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/sliders/get_sliders_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/sliders/insert_slider_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/jobs/delete_job_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/jobs/edit_job_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/jobs/get_jobs_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/jobs/get_job_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/jobs/insert_job_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/employment_applications/delete_employment_application_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/employment_applications/edit_employment_application_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/employment_applications/get_employment_applications_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/employment_applications/get_employment_application_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/employment_applications/insert_employment_application_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/social_media/edit_social_media_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/statistics/get_admin_statistics_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/terms_of_use/edit_terms_of_use_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/categories/get_categories_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/categories/get_category_with_id_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/upload_file/upload_file_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/users/delete_user_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/users/edit_user_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/users/get_users_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/users/insert_user_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/version/edit_version_usecase.dart';
import 'package:fahem_dashboard/domain/usecases/version/get_version_usecase.dart';

class Repository extends BaseRepository {
  final BaseRemoteDataSource _baseRemoteDataSource;
  // final BaseLocalDataSource _baseLocalDataSource;
  final BaseNetworkInfo _baseNetworkInfo;

  Repository(this._baseRemoteDataSource, this._baseNetworkInfo);

  Future<Either<Failure, T>> _repositoryImpl<T>({required Future<T> remoteDataMethod, required String printMessage}) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        T result = await remoteDataMethod;
        debugPrint(printMessage);
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  // region Upload File
  @override
  Future<Either<Failure, String>> uploadFile(UploadFileParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.uploadFile(parameters);
        debugPrint('uploadFile');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }
  // endregion

  // region Version
  @override
  Future<Either<Failure, VersionModel>> getVersion(GetVersionParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getVersion(parameters);
        debugPrint('getVersion');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, VersionModel>> editVersion(EditVersionParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.editVersion(parameters);
        debugPrint('editVersion');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }
  // endregion

  // region Authentication Admin
  @override
  Future<Either<Failure, AdminModel>> loginAdmin(LoginAdminParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.loginAdmin(parameters);
        debugPrint('loginAdmin');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, bool>> checkAdminEmailToResetPassword(CheckAdminEmailToResetPasswordParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.checkAdminEmailToResetPassword(parameters);
        debugPrint('checkAdminEmailToResetPassword');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, AdminModel>> resetAdminPassword(ResetAdminPasswordParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.resetAdminPassword(parameters);
        debugPrint('resetAdminPassword');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, AdminModel>> changeAdminPassword(ChangeAdminPasswordParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.changeAdminPassword(parameters);
        debugPrint('changeAdminPassword');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, AdminModel>> editAdminProfile(EditAdminProfileParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.editAdminProfile(parameters);
        debugPrint('editAdminProfile');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, AdminModel>> getAdminWithId(GetAdminWithIdParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getAdminWithId(parameters);
        debugPrint('getAdminWithId');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, bool>> isAdminExist(IsAdminExistParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.isAdminExist(parameters);
        debugPrint('isAdminExist');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, bool>> isAdminEmailExist(IsAdminEmailExistParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.isAdminEmailExist(parameters);
        debugPrint('isAdminEmailExist');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAdminAccount(DeleteAdminAccountParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.deleteAdminAccount(parameters);
        debugPrint('deleteAdminAccount');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, bool>> setIsViewed(SetIsViewedParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.setIsViewed(parameters);
        debugPrint('setIsViewed');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }
  // endregion

  // region Authentication User
  @override
  Future<Either<Failure, UserModel>> loginUser(LoginUserParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.loginUser(parameters);
        debugPrint('loginUser');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> registerUser(RegisterUserParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.registerUser(parameters);
        debugPrint('registerUser');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, bool>> checkUserEmailToResetPassword(CheckUserEmailToResetPasswordParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.checkUserEmailToResetPassword(parameters);
        debugPrint('checkUserEmailToResetPassword');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> resetUserPassword(ResetUserPasswordParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.resetUserPassword(parameters);
        debugPrint('resetUserPassword');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> changeUserPassword(ChangeUserPasswordParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.changeUserPassword(parameters);
        debugPrint('changeUserPassword');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> editUserProfile(EditUserProfileParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.editUserProfile(parameters);
        debugPrint('editUserProfile');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUserWithId(GetUserWithIdParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getUserWithId(parameters);
        debugPrint('getUserWithId');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, bool>> isUserExist(IsUserExistParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.isUserExist(parameters);
        debugPrint('isUserExist');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, bool>> isUserEmailExist(IsUserEmailExistParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.isUserEmailExist(parameters);
        debugPrint('isUserEmailExist');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUserAccount(DeleteUserAccountParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.deleteUserAccount(parameters);
        debugPrint('deleteUserAccount');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }
  // endregion

  // region Authentication Account
  @override
  Future<Either<Failure, AccountModel>> loginAccount(LoginAccountParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.loginAccount(parameters);
        debugPrint('loginAccount');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, AccountModel>> registerAccount(RegisterAccountParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.registerAccount(parameters);
        debugPrint('registerAccount');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, bool>> checkAccountEmailToResetPassword(CheckAccountEmailToResetPasswordParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.checkAccountEmailToResetPassword(parameters);
        debugPrint('checkAccountEmailToResetPassword');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, AccountModel>> resetAccountPassword(ResetAccountPasswordParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.resetAccountPassword(parameters);
        debugPrint('resetAccountPassword');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, AccountModel>> changeAccountPassword(ChangeAccountPasswordParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.changeAccountPassword(parameters);
        debugPrint('changeAccountPassword');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, AccountModel>> editAccountProfile(EditAccountProfileParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.editAccountProfile(parameters);
        debugPrint('editAccountProfile');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, AccountModel>> getAccountWithId(GetAccountWithIdParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getAccountWithId(parameters);
        debugPrint('getAccountWithId');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, bool>> isAccountExist(IsAccountExistParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.isAccountExist(parameters);
        debugPrint('isAccountExist');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, bool>> isAccountEmailExist(IsAccountEmailExistParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.isAccountEmailExist(parameters);
        debugPrint('isAccountEmailExist');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccountAccount(DeleteAccountAccountParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.deleteAccountAccount(parameters);
        debugPrint('deleteAccountAccount');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }
  // endregion

  // region Admins
  @override
  Future<Either<Failure, AdminsResponse>> getAdmins(GetAdminsParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getAdmins(parameters);
        debugPrint('getAdmins');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, AdminModel>> insertAdmin(InsertAdminParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.insertAdmin(parameters);
        debugPrint('insertAdmin');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, AdminModel>> editAdmin(EditAdminParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.editAdmin(parameters);
        debugPrint('editAdmin');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAdmin(DeleteAdminParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.deleteAdmin(parameters);
        debugPrint('deleteAdmin');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }
  // endregion

  // region Users
  @override
  Future<Either<Failure, UsersResponse>> getUsers(GetUsersParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getUsers(parameters);
        debugPrint('getUsers');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> insertUser(InsertUserParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.insertUser(parameters);
        debugPrint('insertUser');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> editUser(EditUserParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.editUser(parameters);
        debugPrint('editUser');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUser(DeleteUserParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.deleteUser(parameters);
        debugPrint('deleteUser');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }
  // endregion

  // region Accounts
  @override
  Future<Either<Failure, AccountsResponse>> getAccounts(GetAccountsParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getAccounts(parameters);
        debugPrint('getAccounts');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, AccountModel>> insertAccount(InsertAccountParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.insertAccount(parameters);
        debugPrint('insertAccount');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, AccountModel>> editAccount(EditAccountParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.editAccount(parameters);
        debugPrint('editAccount');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount(DeleteAccountParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.deleteAccount(parameters);
        debugPrint('deleteAccount');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }
  // endregion

  // region Statistics
  @override
  Future<Either<Failure, List<StatisticModel>>> getAdminStatistics(GetAdminStatisticsParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getAdminStatistics(parameters);
        debugPrint('getAdminStatistics');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }
  // endregion

  // region About App
  @override
  Future<Either<Failure, AboutAppModel>> getAboutApp() async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getAboutApp();
        debugPrint('getAboutApp');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, AboutAppModel>> editAboutApp(EditAboutAppParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.editAboutApp(parameters);
        debugPrint('editAboutApp');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }
  // endregion

  // region Service Description
  @override
  Future<Either<Failure, ServiceDescriptionModel>> getServiceDescription() async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getServiceDescription();
        debugPrint('getServiceDescription');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, ServiceDescriptionModel>> editServiceDescription(EditServiceDescriptionParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.editServiceDescription(parameters);
        debugPrint('editServiceDescription');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }
  // endregion

  // region Privacy Policy
  @override
  Future<Either<Failure, PrivacyPolicyModel>> getPrivacyPolicy() async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getPrivacyPolicy();
        debugPrint('getPrivacyPolicy');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, PrivacyPolicyModel>> editPrivacyPolicy(EditPrivacyPolicyParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.editPrivacyPolicy(parameters);
        debugPrint('editPrivacyPolicy');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }
  // endregion

  // region Terms Of Use
  @override
  Future<Either<Failure, TermsOfUseModel>> getTermsOfUse() async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getTermsOfUse();
        debugPrint('getTermsOfUse');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, TermsOfUseModel>> editTermsOfUse(EditTermsOfUseParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.editTermsOfUse(parameters);
        debugPrint('editTermsOfUse');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }
  // endregion

  // region Sliders
  @override
  Future<Either<Failure, SlidersResponse>> getSliders(GetSlidersParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getSliders(parameters);
        debugPrint('getSliders');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, SliderModel>> getSliderWithId(GetSliderWithIdParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getSliderWithId(parameters);
        debugPrint('getSliderWithId');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, SliderModel>> insertSlider(InsertSliderParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.insertSlider(parameters);
        debugPrint('insertSlider');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, SliderModel>> editSlider(EditSliderParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.editSlider(parameters);
        debugPrint('editSlider');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteSlider(DeleteSliderParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.deleteSlider(parameters);
        debugPrint('deleteSlider');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }
  // endregion

  // region Notifications
  @override
  Future<Either<Failure, NotificationsResponse>> getNotifications(GetNotificationsParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getNotifications(parameters);
        debugPrint('getNotifications');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, NotificationModel>> getNotificationWithId(GetNotificationWithIdParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getNotificationWithId(parameters);
        debugPrint('getNotificationWithId');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, NotificationModel>> insertNotification(InsertNotificationParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.insertNotification(parameters);
        debugPrint('insertNotification');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteNotification(DeleteNotificationParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.deleteNotification(parameters);
        debugPrint('deleteNotification');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }
  // endregion

  // region Admin Notifications
  @override
  Future<Either<Failure, AdminNotificationsResponse>> getAdminNotifications(GetAdminNotificationsParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getAdminNotifications(parameters);
        debugPrint('getAdminNotifications');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, AdminNotificationModel>> getAdminNotificationWithId(GetAdminNotificationWithIdParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getAdminNotificationWithId(parameters);
        debugPrint('getAdminNotificationWithId');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, AdminNotificationModel>> insertAdminNotification(InsertAdminNotificationParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.insertAdminNotification(parameters);
        debugPrint('insertAdminNotification');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAdminNotification(DeleteAdminNotificationParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.deleteAdminNotification(parameters);
        debugPrint('deleteAdminNotification');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }
  // endregion

  // region Complaints
  @override
  Future<Either<Failure, ComplaintsResponse>> getComplaints(GetComplaintsParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getComplaints(parameters);
        debugPrint('getComplaints');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, ComplaintModel>> getComplaintWithId(GetComplaintWithIdParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getComplaintWithId(parameters);
        debugPrint('getComplaintWithId');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, ComplaintModel>> insertComplaint(InsertComplaintParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.insertComplaint(parameters);
        debugPrint('insertComplaint');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteComplaint(DeleteComplaintParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.deleteComplaint(parameters);
        debugPrint('deleteComplaint');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }
  // endregion

  // region Faqs
  @override
  Future<Either<Failure, FaqsResponse>> getFaqs(GetFaqsParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getFaqs(parameters);
        debugPrint('getFaqs');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, FaqModel>> getFaqWithId(GetFaqWithIdParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getFaqWithId(parameters);
        debugPrint('getFaqWithId');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, FaqModel>> insertFaq(InsertFaqParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.insertFaq(parameters);
        debugPrint('insertFaq');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, FaqModel>> editFaq(EditFaqParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.editFaq(parameters);
        debugPrint('editFaq');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteFaq(DeleteFaqParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.deleteFaq(parameters);
        debugPrint('deleteFaq');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }
  // endregion

  // region Articles
  @override
  Future<Either<Failure, ArticlesResponse>> getArticles(GetArticlesParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getArticles(parameters);
        debugPrint('getArticles');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, ArticleModel>> getArticleWithId(GetArticleWithIdParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getArticleWithId(parameters);
        debugPrint('getArticleWithId');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, ArticleModel>> insertArticle(InsertArticleParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.insertArticle(parameters);
        debugPrint('insertArticle');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, ArticleModel>> editArticle(EditArticleParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.editArticle(parameters);
        debugPrint('editArticle');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteArticle(DeleteArticleParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.deleteArticle(parameters);
        debugPrint('deleteArticle');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, ArticleModel>> incrementArticleViews(IncrementArticleViewsParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.incrementArticleViews(parameters);
        debugPrint('incrementArticleViews');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }
  // endregion

  // region Social Media
  @override
  Future<Either<Failure, SocialMediaResponse>> getSocialMedia(GetSocialMediaParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getSocialMedia(parameters);
        debugPrint('getSocialMedia');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, SocialMediaModel>> getSocialMediaWithId(GetSocialMediaWithIdParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getSocialMediaWithId(parameters);
        debugPrint('getSocialMediaWithId');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, SocialMediaModel>> insertSocialMedia(InsertSocialMediaParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.insertSocialMedia(parameters);
        debugPrint('insertSocialMedia');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, SocialMediaModel>> editSocialMedia(EditSocialMediaParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.editSocialMedia(parameters);
        debugPrint('editSocialMedia');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteSocialMedia(DeleteSocialMediaParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.deleteSocialMedia(parameters);
        debugPrint('deleteSocialMedia');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }
  // endregion

  // region Suggested Messages
  @override
  Future<Either<Failure, SuggestedMessagesResponse>> getSuggestedMessages(GetSuggestedMessagesParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getSuggestedMessages(parameters);
        debugPrint('getSuggestedMessages');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, SuggestedMessageModel>> getSuggestedMessageWithId(GetSuggestedMessageWithIdParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getSuggestedMessageWithId(parameters);
        debugPrint('getSuggestedMessageWithId');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, SuggestedMessageModel>> insertSuggestedMessage(InsertSuggestedMessageParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.insertSuggestedMessage(parameters);
        debugPrint('insertSuggestedMessage');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, SuggestedMessageModel>> editSuggestedMessage(EditSuggestedMessageParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.editSuggestedMessage(parameters);
        debugPrint('editSuggestedMessage');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteSuggestedMessage(DeleteSuggestedMessageParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.deleteSuggestedMessage(parameters);
        debugPrint('deleteSuggestedMessage');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }
  // endregion

  // region Wallet history
  @override
  Future<Either<Failure, WalletHistoryResponse>> getWalletHistory(GetWalletHistoryParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getWalletHistory(parameters);
        debugPrint('getWalletHistory');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, WalletHistoryModel>> getWalletHistoryWithId(GetWalletHistoryWithIdParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getWalletHistoryWithId(parameters);
        debugPrint('getWalletHistoryWithId');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, WalletHistoryModel>> insertWalletHistory(InsertWalletHistoryParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.insertWalletHistory(parameters);
        debugPrint('insertWalletHistory');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, WalletHistoryModel>> editWalletHistory(EditWalletHistoryParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.editWalletHistory(parameters);
        debugPrint('editWalletHistory');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteWalletHistory(DeleteWalletHistoryParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.deleteWalletHistory(parameters);
        debugPrint('deleteWalletHistory');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }
  // endregion

  // region Categories
  @override
  Future<Either<Failure, CategoriesResponse>> getCategories(GetCategoriesParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getCategories(parameters);
        debugPrint('getCategories');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, CategoryModel>> getCategoryWithId(GetCategoryWithIdParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getCategoryWithId(parameters);
        debugPrint('getCategoryWithId');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, CategoryModel>> insertCategory(InsertCategoryParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.insertCategory(parameters);
        debugPrint('insertCategory');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, CategoryModel>> editCategory(EditCategoryParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.editCategory(parameters);
        debugPrint('editCategory');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCategory(DeleteCategoryParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.deleteCategory(parameters);
        debugPrint('deleteCategory');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }
  // endregion

  // region Main Categories
  @override
  Future<Either<Failure, MainCategoriesResponse>> getMainCategories(GetMainCategoriesParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getMainCategories(parameters);
        debugPrint('getMainCategories');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, MainCategoryModel>> getMainCategoryWithId(GetMainCategoryWithIdParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getMainCategoryWithId(parameters);
        debugPrint('getMainCategoryWithId');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, MainCategoryModel>> insertMainCategory(InsertMainCategoryParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.insertMainCategory(parameters);
        debugPrint('insertMainCategory');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, MainCategoryModel>> editMainCategory(EditMainCategoryParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.editMainCategory(parameters);
        debugPrint('editMainCategory');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteMainCategory(DeleteMainCategoryParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.deleteMainCategory(parameters);
        debugPrint('deleteMainCategory');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }
  // endregion

  // region Jobs
  @override
  Future<Either<Failure, JobsResponse>> getJobs(GetJobsParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getJobs(parameters);
        debugPrint('getJobs');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, JobModel>> getJobWithId(GetJobWithIdParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getJobWithId(parameters);
        debugPrint('getJobWithId');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, JobModel>> insertJob(InsertJobParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.insertJob(parameters);
        debugPrint('insertJob');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, JobModel>> editJob(EditJobParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.editJob(parameters);
        debugPrint('editJob');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteJob(DeleteJobParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.deleteJob(parameters);
        debugPrint('deleteJob');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, JobModel>> incrementJobViews(IncrementJobViewsParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.incrementJobViews(parameters);
        debugPrint('incrementJobViews');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, JobModel>> changeJobStatus(ChangeJobStatusParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.changeJobStatus(parameters);
        debugPrint('changeJobStatus');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }
  // endregion

  // region Employment Applications
  @override
  Future<Either<Failure, EmploymentApplicationsResponse>> getEmploymentApplications(GetEmploymentApplicationsParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getEmploymentApplications(parameters);
        debugPrint('getEmploymentApplications');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, EmploymentApplicationModel>> getEmploymentApplicationWithId(GetEmploymentApplicationWithIdParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getEmploymentApplicationWithId(parameters);
        debugPrint('getEmploymentApplicationWithId');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, EmploymentApplicationModel>> insertEmploymentApplication(InsertEmploymentApplicationParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.insertEmploymentApplication(parameters);
        debugPrint('insertEmploymentApplication');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, EmploymentApplicationModel>> editEmploymentApplication(EditEmploymentApplicationParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.editEmploymentApplication(parameters);
        debugPrint('editEmploymentApplication');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteEmploymentApplication(DeleteEmploymentApplicationParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.deleteEmploymentApplication(parameters);
        debugPrint('deleteEmploymentApplication');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }
  // endregion

  // region Services
  @override
  Future<Either<Failure, ServicesResponse>> getServices(GetServicesParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getServices(parameters);
        debugPrint('getServices');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, ServiceModel>> getServiceWithId(GetServiceWithIdParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getServiceWithId(parameters);
        debugPrint('getServiceWithId');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, ServiceModel>> insertService(InsertServiceParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.insertService(parameters);
        debugPrint('insertService');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, ServiceModel>> editService(EditServiceParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.editService(parameters);
        debugPrint('editService');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteService(DeleteServiceParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.deleteService(parameters);
        debugPrint('deleteService');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }
  // endregion

  // region Features
  @override
  Future<Either<Failure, FeaturesResponse>> getFeatures(GetFeaturesParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getFeatures(parameters);
        debugPrint('getFeatures');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, FeatureModel>> getFeatureWithId(GetFeatureWithIdParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getFeatureWithId(parameters);
        debugPrint('getFeatureWithId');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, FeatureModel>> insertFeature(InsertFeatureParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.insertFeature(parameters);
        debugPrint('insertFeature');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, FeatureModel>> editFeature(EditFeatureParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.editFeature(parameters);
        debugPrint('editFeature');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteFeature(DeleteFeatureParameters parameters) async {
      if(await _baseNetworkInfo.isConnected) {
        try {
          var result = await _baseRemoteDataSource.deleteFeature(parameters);
          debugPrint('deleteFeature');
          return Right(result);
        }
        on ServerException catch(error) {
          return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
        }
      }
      else {
        return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
      }
    }
  // endregion

  // region Reviews
  @override
  Future<Either<Failure, ReviewsResponse>> getReviews(GetReviewsParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getReviews(parameters);
        debugPrint('getReviews');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, ReviewModel>> getReviewWithId(GetReviewWithIdParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getReviewWithId(parameters);
        debugPrint('getReviewWithId');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, ReviewModel>> insertReview(InsertReviewParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.insertReview(parameters);
        debugPrint('insertReview');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, ReviewModel>> editReview(EditReviewParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.editReview(parameters);
        debugPrint('editReview');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteReview(DeleteReviewParameters parameters) async {
      if(await _baseNetworkInfo.isConnected) {
        try {
          var result = await _baseRemoteDataSource.deleteReview(parameters);
          debugPrint('deleteReview');
          return Right(result);
        }
        on ServerException catch(error) {
          return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
        }
      }
      else {
        return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
      }
    }
  // endregion

  // region Playlists
  @override
  Future<Either<Failure, PlaylistsResponse>> getPlaylists(GetPlaylistsParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getPlaylists(parameters);
        debugPrint('getPlaylists');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, PlaylistModel>> getPlaylistWithId(GetPlaylistWithIdParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getPlaylistWithId(parameters);
        debugPrint('getPlaylistWithId');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, PlaylistModel>> insertPlaylist(InsertPlaylistParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.insertPlaylist(parameters);
        debugPrint('insertPlaylist');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, PlaylistModel>> editPlaylist(EditPlaylistParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.editPlaylist(parameters);
        debugPrint('editPlaylist');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> deletePlaylist(DeletePlaylistParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.deletePlaylist(parameters);
        debugPrint('deletePlaylist');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }
  // endregion

  // region Videos
  @override
  Future<Either<Failure, VideosResponse>> getVideos(GetVideosParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getVideos(parameters);
        debugPrint('getVideos');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, VideoModel>> getVideoWithId(GetVideoWithIdParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getVideoWithId(parameters);
        debugPrint('getVideoWithId');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, VideoModel>> insertVideo(InsertVideoParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.insertVideo(parameters);
        debugPrint('insertVideo');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, VideoModel>> editVideo(EditVideoParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.editVideo(parameters);
        debugPrint('editVideo');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteVideo(DeleteVideoParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.deleteVideo(parameters);
        debugPrint('deleteVideo');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }
  // endregion

  // region Playlists Comments
  @override
  Future<Either<Failure, PlaylistsCommentsResponse>> getPlaylistsComments(GetPlaylistsCommentsParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getPlaylistsComments(parameters);
        debugPrint('getPlaylistsComments');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, PlaylistCommentModel>> getPlaylistCommentWithId(GetPlaylistCommentWithIdParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getPlaylistCommentWithId(parameters);
        debugPrint('getPlaylistCommentWithId');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, PlaylistCommentModel>> insertPlaylistComment(InsertPlaylistCommentParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.insertPlaylistComment(parameters);
        debugPrint('insertPlaylistComment');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, PlaylistCommentModel>> editPlaylistComment(EditPlaylistCommentParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.editPlaylistComment(parameters);
        debugPrint('editPlaylistComment');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> deletePlaylistComment(DeletePlaylistCommentParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.deletePlaylistComment(parameters);
        debugPrint('deletePlaylistComment');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }
  // endregion

  // region Phone Number Requests
  @override
  Future<Either<Failure, PhoneNumberRequestsResponse>> getPhoneNumberRequests(GetPhoneNumberRequestsParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getPhoneNumberRequests(parameters);
        debugPrint('getPhoneNumberRequests');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, PhoneNumberRequestModel>> getPhoneNumberRequestWithId(GetPhoneNumberRequestWithIdParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getPhoneNumberRequestWithId(parameters);
        debugPrint('getPhoneNumberRequestWithId');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, PhoneNumberRequestModel>> insertPhoneNumberRequest(InsertPhoneNumberRequestParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.insertPhoneNumberRequest(parameters);
        debugPrint('insertPhoneNumberRequest');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, PhoneNumberRequestModel>> editPhoneNumberRequest(EditPhoneNumberRequestParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.editPhoneNumberRequest(parameters);
        debugPrint('editPhoneNumberRequest');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> deletePhoneNumberRequest(DeletePhoneNumberRequestParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.deletePhoneNumberRequest(parameters);
        debugPrint('deletePhoneNumberRequest');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }
  // endregion

  // region Booking Appointments
  @override
  Future<Either<Failure, BookingAppointmentsResponse>> getBookingAppointments(GetBookingAppointmentsParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getBookingAppointments(parameters);
        debugPrint('getBookingAppointments');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, BookingAppointmentModel>> getBookingAppointmentWithId(GetBookingAppointmentWithIdParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getBookingAppointmentWithId(parameters);
        debugPrint('getBookingAppointmentWithId');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, BookingAppointmentModel>> insertBookingAppointment(InsertBookingAppointmentParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.insertBookingAppointment(parameters);
        debugPrint('insertBookingAppointment');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, BookingAppointmentModel>> editBookingAppointment(EditBookingAppointmentParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.editBookingAppointment(parameters);
        debugPrint('editBookingAppointment');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteBookingAppointment(DeleteBookingAppointmentParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.deleteBookingAppointment(parameters);
        debugPrint('deleteBookingAppointment');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }
  // endregion

  // region Instant Consultations
  @override
  Future<Either<Failure, InstantConsultationsResponse>> getInstantConsultations(GetInstantConsultationsParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getInstantConsultations(parameters);
        debugPrint('getInstantConsultations');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, InstantConsultationModel>> getInstantConsultationWithId(GetInstantConsultationWithIdParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getInstantConsultationWithId(parameters);
        debugPrint('getInstantConsultationWithId');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, InstantConsultationModel>> insertInstantConsultation(InsertInstantConsultationParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.insertInstantConsultation(parameters);
        debugPrint('insertInstantConsultation');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, InstantConsultationModel>> editInstantConsultation(EditInstantConsultationParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.editInstantConsultation(parameters);
        debugPrint('editInstantConsultation');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteInstantConsultation(DeleteInstantConsultationParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.deleteInstantConsultation(parameters);
        debugPrint('deleteInstantConsultation');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }
  // endregion

  // region Instant Consultations Comments
  @override
  Future<Either<Failure, InstantConsultationsCommentsResponse>> getInstantConsultationsComments(GetInstantConsultationsCommentsParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getInstantConsultationsComments(parameters);
        debugPrint('getInstantConsultationsComments');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, InstantConsultationCommentModel>> getInstantConsultationCommentWithId(GetInstantConsultationCommentWithIdParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getInstantConsultationCommentWithId(parameters);
        debugPrint('getInstantConsultationCommentWithId');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, InstantConsultationCommentModel>> insertInstantConsultationComment(InsertInstantConsultationCommentParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.insertInstantConsultationComment(parameters);
        debugPrint('insertInstantConsultationComment');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, InstantConsultationCommentModel>> editInstantConsultationComment(EditInstantConsultationCommentParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.editInstantConsultationComment(parameters);
        debugPrint('editInstantConsultationComment');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteInstantConsultationComment(DeleteInstantConsultationCommentParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.deleteInstantConsultationComment(parameters);
        debugPrint('deleteInstantConsultationComment');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }
  // endregion

  // region Secret Consultations
  @override
  Future<Either<Failure, SecretConsultationsResponse>> getSecretConsultations(GetSecretConsultationsParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getSecretConsultations(parameters);
        debugPrint('getSecretConsultations');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, SecretConsultationModel>> getSecretConsultationWithId(GetSecretConsultationWithIdParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getSecretConsultationWithId(parameters);
        debugPrint('getSecretConsultationWithId');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, SecretConsultationModel>> insertSecretConsultation(InsertSecretConsultationParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.insertSecretConsultation(parameters);
        debugPrint('insertSecretConsultation');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, SecretConsultationModel>> editSecretConsultation(EditSecretConsultationParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.editSecretConsultation(parameters);
        debugPrint('editSecretConsultation');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteSecretConsultation(DeleteSecretConsultationParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.deleteSecretConsultation(parameters);
        debugPrint('deleteSecretConsultation');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }
  // endregion

  // region Withdrawal Requests
  @override
  Future<Either<Failure, WithdrawalRequestsResponse>> getWithdrawalRequests(GetWithdrawalRequestsParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getWithdrawalRequests(parameters);
        debugPrint('getWithdrawalRequests');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, WithdrawalRequestModel>> getWithdrawalRequestWithId(GetWithdrawalRequestWithIdParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.getWithdrawalRequestWithId(parameters);
        debugPrint('getWithdrawalRequestWithId');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, WithdrawalRequestModel>> insertWithdrawalRequest(InsertWithdrawalRequestParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.insertWithdrawalRequest(parameters);
        debugPrint('insertWithdrawalRequest');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, WithdrawalRequestModel>> editWithdrawalRequest(EditWithdrawalRequestParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.editWithdrawalRequest(parameters);
        debugPrint('editWithdrawalRequest');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteWithdrawalRequest(DeleteWithdrawalRequestParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.deleteWithdrawalRequest(parameters);
        debugPrint('deleteWithdrawalRequest');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'Check your internet connection'));
    }
  }
  // endregion

  // region Firebase
  @override
  Future<Either<Failure, void>> addChat(AddChatParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.addChat(parameters);
        debugPrint('addChat');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> addMessage(AddMessageParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.addMessage(parameters);
        debugPrint('addMessage');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> updateMessageMode(UpdateMessageModeParameters parameters) async {
    if(await _baseNetworkInfo.isConnected) {
      try {
        var result = await _baseRemoteDataSource.updateMessageMode(parameters);
        debugPrint('updateMessageMode');
        return Right(result);
      }
      on ServerException catch(error) {
        return Left(ServerFailure(messageAr: error.messageAr, messageEn: error.messageEn));
      }
    }
    else {
      return Left(LocalFailure(messageAr: 'تحقق من اتصالك بالانترنت', messageEn: 'check your internet connection'));
    }
  }
  // endregion
}