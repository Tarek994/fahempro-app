class ApiConstants {

  // region Base URL
  static String baseUrl = "";
  // static const String baseUrl = "https://fahem.com/fahem_api/";
  // static const String baseUrl = "http://192.168.1.5/projects/fahem_api/";
  // endregion

  // region End Points

  // region Upload File
  static const String uploadFileEndPoint = "upload_file.php";
  // endregion

  // region Version
  static const String getVersionEndPoint = "version/get_version.php";
  static const String editVersionEndPoint = "version/edit_version.php";
  // endregion

  // region Authentication Admin
  static const String loginAdminEndPoint = "authentication_admin/login_admin.php";
  static const String checkAdminEmailToResetPasswordEndPoint = "authentication_admin/check_admin_email_to_reset_password.php";
  static const String resetAdminPasswordEndPoint = "authentication_admin/reset_admin_password.php";
  static const String changeAdminPasswordEndPoint = "authentication_admin/change_admin_password.php";
  static const String editAdminProfileEndPoint = "authentication_admin/edit_admin_profile.php";
  static const String getAdminWithIdEndPoint = "authentication_admin/get_admin_with_id.php";
  static const String isAdminExistEndPoint = "authentication_admin/is_admin_exist.php";
  static const String isAdminEmailExistEndPoint = "authentication_admin/is_admin_email_exist.php";
  static const String deleteAdminAccountEndPoint = "authentication_admin/delete_admin_account.php";
  // endregion

  // region Authentication User
  static const String loginUserEndPoint = "authentication_user/login_user.php";
  static const String registerUserEndPoint = "authentication_user/register_user.php";
  static const String checkUserEmailToResetPasswordEndPoint = "authentication_user/check_user_email_to_reset_password.php";
  static const String checkUserExistWithPhoneNumberAndGetEndPoint = "authentication_user/check_user_exist_with_phone_number_and_get.php";
  static const String resetUserPasswordEndPoint = "authentication_user/reset_user_password.php";
  static const String changeUserPasswordEndPoint = "authentication_user/change_user_password.php";
  static const String editUserProfileEndPoint = "authentication_user/edit_user_profile.php";
  static const String getUserWithIdEndPoint = "authentication_user/get_user_with_id.php";
  static const String isUserExistEndPoint = "authentication_user/is_user_exist.php";
  static const String isUserEmailExistEndPoint = "authentication_user/is_user_email_exist.php";
  static const String deleteUserAccountEndPoint = "authentication_user/delete_user_account.php";
  // endregion

  // region Authentication Account
  static const String loginAccountEndPoint = "authentication_account/login_account.php";
  static const String registerAccountEndPoint = "authentication_account/register_account.php";
  static const String checkAccountEmailToResetPasswordEndPoint = "authentication_account/check_account_email_to_reset_password.php";
  static const String resetAccountPasswordEndPoint = "authentication_account/reset_account_password.php";
  static const String changeAccountPasswordEndPoint = "authentication_account/change_account_password.php";
  static const String editAccountProfileEndPoint = "authentication_account/edit_account_profile.php";
  static const String getAccountWithIdEndPoint = "authentication_account/get_account_with_id.php";
  static const String isAccountExistEndPoint = "authentication_account/is_account_exist.php";
  static const String isAccountEmailExistEndPoint = "authentication_account/is_account_email_exist.php";
  static const String deleteAccountAccountEndPoint = "authentication_account/delete_account_account.php";
  // endregion

  // region Admins
  static const String getAdminsEndPoint = "admins/get_admins.php";
  static const String insertAdminEndPoint = "admins/insert_admin.php";
  static const String editAdminEndPoint = "admins/edit_admin.php";
  static const String deleteAdminEndPoint = "admins/delete_admin.php";
  // endregion

  // region Users
  static const String getUsersEndPoint = "users/get_users.php";
  static const String insertUserEndPoint = "users/insert_user.php";
  static const String editUserEndPoint = "users/edit_user.php";
  static const String deleteUserEndPoint = "users/delete_user.php";
  // endregion

  // region Accounts
  static const String getAccountsEndPoint = "accounts/get_accounts.php";
  static const String insertAccountEndPoint = "accounts/insert_account.php";
  static const String editAccountEndPoint = "accounts/edit_account.php";
  static const String deleteAccountEndPoint = "accounts/delete_account.php";
  // endregion

  // region Statistics
  static const String getAdminStatisticsEndPoint = "statistics/get_admin_statistics.php";
  static const String getAccountStatisticsEndPoint = "statistics/get_account_statistics.php";
  // endregion

  // region About App
  static const String getAboutAppEndPoint = "about_app/get_about_app.php";
  static const String editAboutAppEndPoint = "about_app/edit_about_app.php";
  // endregion

  // region Service Description
  static const String getServiceDescriptionEndPoint = "service_description/get_service_description.php";
  static const String editServiceDescriptionEndPoint = "service_description/edit_service_description.php";
  // endregion

  // region Privacy Policy
  static const String getPrivacyPolicyEndPoint = "privacy_policy/get_privacy_policy.php";
  static const String editPrivacyPolicyEndPoint = "privacy_policy/edit_privacy_policy.php";
  // endregion

  // region Terms Of Use
  static const String getTermsOfUseEndPoint = "terms_of_use/get_terms_of_use.php";
  static const String editTermsOfUseEndPoint = "terms_of_use/edit_terms_of_use.php";
  // endregion

  // region Sliders
  static const String getSlidersEndPoint = "sliders/get_sliders.php";
  static const String getSliderWithIdEndPoint = "sliders/get_slider_with_id.php";
  static const String insertSliderEndPoint = "sliders/insert_slider.php";
  static const String editSliderEndPoint = "sliders/edit_slider.php";
  static const String deleteSliderEndPoint = "sliders/delete_slider.php";
  // endregion

  // region Notifications
  static const String getNotificationsEndPoint = "notifications/get_notifications.php";
  static const String getNotificationWithIdEndPoint = "notifications/get_notification_with_id.php";
  static const String insertNotificationEndPoint = "notifications/insert_notification.php";
  static const String deleteNotificationEndPoint = "notifications/delete_notification.php";
  // endregion

  // region Admin Notifications
  static const String getAdminNotificationsEndPoint = "admin_notifications/get_admin_notifications.php";
  static const String getAdminNotificationWithIdEndPoint = "admin_notifications/get_admin_notification_with_id.php";
  static const String insertAdminNotificationEndPoint = "admin_notifications/insert_admin_notification.php";
  static const String deleteAdminNotificationEndPoint = "admin_notifications/delete_admin_notification.php";
  static const String setIsViewedEndPoint = "admin_notifications/set_is_viewed.php";
  // endregion

  // region Complaints
  static const String getComplaintsEndPoint = "complaints/get_complaints.php";
  static const String getComplaintWithIdEndPoint = "complaints/get_complaint_with_id.php";
  static const String insertComplaintEndPoint = "complaints/insert_complaint.php";
  static const String deleteComplaintEndPoint = "complaints/delete_complaint.php";
  // endregion

  // region Faqs
  static const String getFaqsEndPoint = "faqs/get_faqs.php";
  static const String getFaqWithIdEndPoint = "faqs/get_faq_with_id.php";
  static const String insertFaqEndPoint = "faqs/insert_faq.php";
  static const String editFaqEndPoint = "faqs/edit_faq.php";
  static const String deleteFaqEndPoint = "faqs/delete_faq.php";
  // endregion

  // region Articles
  static const String getArticlesEndPoint = "articles/get_articles.php";
  static const String getArticleWithIdEndPoint = "articles/get_article_with_id.php";
  static const String insertArticleEndPoint = "articles/insert_article.php";
  static const String editArticleEndPoint = "articles/edit_article.php";
  static const String deleteArticleEndPoint = "articles/delete_article.php";
  static const String incrementArticleViewsEndPoint = "articles/increment_article_views.php";
  // endregion

  // region Social Media
  static const String getSocialMediaEndPoint = "social_media/get_social_media.php";
  static const String getSocialMediaWithIdEndPoint = "social_media/get_social_media_with_id.php";
  static const String insertSocialMediaEndPoint = "social_media/insert_social_media.php";
  static const String editSocialMediaEndPoint = "social_media/edit_social_media.php";
  static const String deleteSocialMediaEndPoint = "social_media/delete_social_media.php";
  // endregion

  // region Suggested Messages
  static const String getSuggestedMessagesEndPoint = "suggested_messages/get_suggested_messages.php";
  static const String getSuggestedMessageWithIdEndPoint = "suggested_messages/get_suggested_message_with_id.php";
  static const String insertSuggestedMessageEndPoint = "suggested_messages/insert_suggested_message.php";
  static const String editSuggestedMessageEndPoint = "suggested_messages/edit_suggested_message.php";
  static const String deleteSuggestedMessageEndPoint = "suggested_messages/delete_suggested_message.php";
  // endregion

  // region Wallet History
  static const String getWalletHistoryEndPoint = "wallet_history/get_wallet_history.php";
  static const String getWalletHistoryWithIdEndPoint = "wallet_history/get_wallet_history_with_id.php";
  static const String insertWalletHistoryEndPoint = "wallet_history/insert_wallet_history.php";
  static const String editWalletHistoryEndPoint = "wallet_history/edit_wallet_history.php";
  static const String deleteWalletHistoryEndPoint = "wallet_history/delete_wallet_history.php";
  // endregion

  // region Categories
  static const String getCategoriesEndPoint = "categories/get_categories.php";
  static const String getCategoryWithIdEndPoint = "categories/get_category_with_id.php";
  static const String insertCategoryEndPoint = "categories/insert_category.php";
  static const String editCategoryEndPoint = "categories/edit_category.php";
  static const String deleteCategoryEndPoint = "categories/delete_category.php";
  // endregion

  // region Main Categories
  static const String getMainCategoriesEndPoint = "main_categories/get_main_categories.php";
  static const String getMainCategoryWithIdEndPoint = "main_categories/get_main_category_with_id.php";
  static const String insertMainCategoryEndPoint = "main_categories/insert_main_category.php";
  static const String editMainCategoryEndPoint = "main_categories/edit_main_category.php";
  static const String deleteMainCategoryEndPoint = "main_categories/delete_main_category.php";
  // endregion

  // region Jobs
  static const String getJobsEndPoint = "jobs/get_jobs.php";
  static const String getJobWithIdEndPoint = "jobs/get_job_with_id.php";
  static const String insertJobEndPoint = "jobs/insert_job.php";
  static const String editJobEndPoint = "jobs/edit_job.php";
  static const String deleteJobEndPoint = "jobs/delete_job.php";
  static const String incrementJobViewsEndPoint = "jobs/increment_job_views.php";
  static const String changeJobStatusEndPoint = "jobs/change_job_status.php";
  // endregion

  // region Employment Applications
  static const String getEmploymentApplicationsEndPoint = "employment_applications/get_employment_applications.php";
  static const String getEmploymentApplicationWithIdEndPoint = "employment_applications/get_employment_application_with_id.php";
  static const String insertEmploymentApplicationEndPoint = "employment_applications/insert_employment_application.php";
  static const String editEmploymentApplicationEndPoint = "employment_applications/edit_employment_application.php";
  static const String deleteEmploymentApplicationEndPoint = "employment_applications/delete_employment_application.php";
  // endregion

  // region Services
  static const String getServicesEndPoint = "services/get_services.php";
  static const String getServiceWithIdEndPoint = "services/get_service_with_id.php";
  static const String insertServiceEndPoint = "services/insert_service.php";
  static const String editServiceEndPoint = "services/edit_service.php";
  static const String deleteServiceEndPoint = "services/delete_service.php";
  // endregion

  // region Features
  static const String getFeaturesEndPoint = "features/get_features.php";
  static const String getFeatureWithIdEndPoint = "features/get_feature_with_id.php";
  static const String insertFeatureEndPoint = "features/insert_feature.php";
  static const String editFeatureEndPoint = "features/edit_feature.php";
  static const String deleteFeatureEndPoint = "features/delete_feature.php";
  // endregion

  // region Reviews
  static const String getReviewsEndPoint = "reviews/get_reviews.php";
  static const String getReviewWithIdEndPoint = "reviews/get_review_with_id.php";
  static const String insertReviewEndPoint = "reviews/insert_review.php";
  static const String editReviewEndPoint = "reviews/edit_review.php";
  static const String deleteReviewEndPoint = "reviews/delete_review.php";
  // endregion

  // region Playlists
  static const String getPlaylistsEndPoint = "playlists/get_playlists.php";
  static const String getPlaylistWithIdEndPoint = "playlists/get_playlist_with_id.php";
  static const String insertPlaylistEndPoint = "playlists/insert_playlist.php";
  static const String editPlaylistEndPoint = "playlists/edit_playlist.php";
  static const String deletePlaylistEndPoint = "playlists/delete_playlist.php";
  // endregion

  // region Videos
  static const String getVideosEndPoint = "videos/get_videos.php";
  static const String getVideoWithIdEndPoint = "videos/get_video_with_id.php";
  static const String insertVideoEndPoint = "videos/insert_video.php";
  static const String editVideoEndPoint = "videos/edit_video.php";
  static const String deleteVideoEndPoint = "videos/delete_video.php";
  // endregion

  // region Playlists Comments
  static const String getPlaylistsCommentsEndPoint = "playlists_comments/get_playlists_comments.php";
  static const String getPlaylistCommentWithIdEndPoint = "playlists_comments/get_playlist_comment_with_id.php";
  static const String insertPlaylistCommentEndPoint = "playlists_comments/insert_playlist_comment.php";
  static const String editPlaylistCommentEndPoint = "playlists_comments/edit_playlist_comment.php";
  static const String deletePlaylistCommentEndPoint = "playlists_comments/delete_playlist_comment.php";
  // endregion

  // region Phone Number Requests
  static const String getPhoneNumberRequestsEndPoint = "phone_number_requests/get_phone_number_requests.php";
  static const String getPhoneNumberRequestWithIdEndPoint = "phone_number_requests/get_phone_number_request_with_id.php";
  static const String insertPhoneNumberRequestEndPoint = "phone_number_requests/insert_phone_number_request.php";
  static const String editPhoneNumberRequestEndPoint = "phone_number_requests/edit_phone_number_request.php";
  static const String deletePhoneNumberRequestEndPoint = "phone_number_requests/delete_phone_number_request.php";
  // endregion

  // region Booking Appointments
  static const String getBookingAppointmentsEndPoint = "booking_appointments/get_booking_appointments.php";
  static const String getBookingAppointmentWithIdEndPoint = "booking_appointments/get_booking_appointment_with_id.php";
  static const String insertBookingAppointmentEndPoint = "booking_appointments/insert_booking_appointment.php";
  static const String editBookingAppointmentEndPoint = "booking_appointments/edit_booking_appointment.php";
  static const String deleteBookingAppointmentEndPoint = "booking_appointments/delete_booking_appointment.php";
  // endregion

  // region Instant Consultations
  static const String getInstantConsultationsEndPoint = "instant_consultations/get_instant_consultations.php";
  static const String getInstantConsultationWithIdEndPoint = "instant_consultations/get_instant_consultation_with_id.php";
  static const String insertInstantConsultationEndPoint = "instant_consultations/insert_instant_consultation.php";
  static const String editInstantConsultationEndPoint = "instant_consultations/edit_instant_consultation.php";
  static const String deleteInstantConsultationEndPoint = "instant_consultations/delete_instant_consultation.php";
  // endregion

  // region Instant Consultations Comments
  static const String getInstantConsultationsCommentsEndPoint = "instant_consultations_comments/get_instant_consultations_comments.php";
  static const String getInstantConsultationCommentWithIdEndPoint = "instant_consultations_comments/get_instant_consultation_comment_with_id.php";
  static const String insertInstantConsultationCommentEndPoint = "instant_consultations_comments/insert_instant_consultation_comment.php";
  static const String editInstantConsultationCommentEndPoint = "instant_consultations_comments/edit_instant_consultation_comment.php";
  static const String deleteInstantConsultationCommentEndPoint = "instant_consultations_comments/delete_instant_consultation_comment.php";
  // endregion

  // region Secret Consultations
  static const String getSecretConsultationsEndPoint = "secret_consultations/get_secret_consultations.php";
  static const String getSecretConsultationWithIdEndPoint = "secret_consultations/get_secret_consultation_with_id.php";
  static const String insertSecretConsultationEndPoint = "secret_consultations/insert_secret_consultation.php";
  static const String editSecretConsultationEndPoint = "secret_consultations/edit_secret_consultation.php";
  static const String deleteSecretConsultationEndPoint = "secret_consultations/delete_secret_consultation.php";
  // endregion

  // region Withdrawal Requests
  static const String getWithdrawalRequestsEndPoint = "withdrawal_requests/get_withdrawal_requests.php";
  static const String getWithdrawalRequestWithIdEndPoint = "withdrawal_requests/get_withdrawal_request_with_id.php";
  static const String insertWithdrawalRequestEndPoint = "withdrawal_requests/insert_withdrawal_request.php";
  static const String editWithdrawalRequestEndPoint = "withdrawal_requests/edit_withdrawal_request.php";
  static const String deleteWithdrawalRequestEndPoint = "withdrawal_requests/delete_withdrawal_request.php";
  // endregion
  // endregion

  // region Fields
  static const String adminIdField = "adminId";
  static const String userIdField = "userId";
  static const String accountIdField = "accountId";
  static const String sliderIdField = "sliderId";
  static const String notificationIdField = "notificationId";
  static const String adminNotificationIdField = "adminNotificationId";
  static const String complaintIdField = "complaintId";
  static const String faqIdField = "faqId";
  static const String articleIdField = "articleId";
  static const String socialMediaIdField = "socialMediaId";
  static const String suggestedMessageIdField = "suggestedMessageId";
  static const String walletHistoryIdField = "walletHistoryId";
  static const String categoryIdField = "categoryId";
  static const String mainCategoryIdField = "mainCategoryId";
  static const String jobIdField = "jobId";
  static const String employmentApplicationIdField = "employmentApplicationId";
  static const String serviceIdField = "serviceId";
  static const String featureIdField = "featureId";
  static const String reviewIdField = "reviewId";
  static const String playlistIdField = "playlistId";
  static const String videoIdField = "videoId";
  static const String playlistCommentIdField = "playlistCommentId";
  static const String phoneNumberRequestIdField = "phoneNumberRequestId";
  static const String bookingAppointmentIdField = "bookingAppointmentId";
  static const String instantConsultationIdField = "instantConsultationId";
  static const String instantConsultationCommentIdField = "instantConsultationCommentId";
  static const String secretConsultationIdField = "secretConsultationId";
  static const String withdrawalRequestIdField = "withdrawalRequestId";
  static const String countryIdField = "countryId";
  static const String bestInstantConsultationCommentIdField = "bestInstantConsultationCommentId";
  static const String isPaginatedField = "isPaginated";
  static const String isForceUpdateField = "isForceUpdate";
  static const String isClearCacheField = "isClearCache";
  static const String isMaintenanceNowField = "isMaintenanceNow";
  static const String inReviewField = "inReview";
  static const String isActiveField = "isActive";
  static const String isSuperField = "isSuper";
  static const String isFeaturedField = "isFeatured";
  static const String isAvailableField = "isAvailable";
  static const String isBookingByAppointmentField = "isBookingByAppointment";
  static const String isViewedField = "isViewed";
  static const String isDoneField = "isDone";
  static const String isRepliedField = "isReplied";
  static const String customOrderField = "customOrder";
  static const String cvField = "cv";
  static const String fullNameField = "fullName";
  static const String dateField = "date";
  static const String fileField = "file";
  static const String directoryField = "directory";
  static const String targetCreatedAtField = "targetCreatedAt";
  static const String appField = "app";
  static const String versionField = "version";
  static const String startTimeTodayField = "startTimeToday";
  static const String endTimeTodayField = "endTimeToday";
  static const String startThisMonthField = "startThisMonth";
  static const String endThisMonthField = "endThisMonth";
  static const String startLastMonthField = "startLastMonth";
  static const String endLastMonthField = "endLastMonth";
  static const String linkField = "link";
  static const String personalImageField = "personalImage";
  static const String coverImageField = "coverImage";
  static const String bioField = "bio";
  static const String emailAddressField = "emailAddress";
  static const String passwordField = "password";
  static const String reasonForRegisteringField = "reasonForRegistering";
  static const String oldPasswordField = "oldPassword";
  static const String newPasswordField = "newPassword";
  static const String dialingCodeField = "dialingCode";
  static const String phoneNumberField = "phoneNumber";
  static const String birthDateField = "birthDate";
  static const String genderField = "gender";
  static const String latitudeField = "latitude";
  static const String longitudeField = "longitude";
  static const String balanceField = "balance";
  static const String viewsField = "views";
  static const String permissionsField = "permissions";
  static const String signInMethodField = "signInMethod";
  static const String createdAtField = "createdAt";
  static const String complaintField = "complaint";
  static const String imageField = "image";
  static const String serviceImageField = "serviceImage";
  static const String additionalImageField = "additionalImage";
  static const String availableForAccountField = "availableForAccount";
  static const String serviceProviderCanSubscribeField = "serviceProviderCanSubscribe";
  static const String serviceInfoEnField = "serviceInfoEn";
  static const String serviceInfoArField = "serviceInfoAr";
  static const String sliderTargetField = "sliderTarget";
  static const String valueField = "value";
  static const String reasonOfRejectField = "reasonOfReject";
  static const String notificationToAppField = "notificationToApp";
  static const String notificationToField = "notificationTo";
  static const String titleField = "title";
  static const String detailsField = "details";
  static const String bodyField = "body";
  static const String textArField = "textAr";
  static const String textEnField = "textEn";
  static const String nameArField = "nameAr";
  static const String nameEnField = "nameEn";
  static const String questionArField = "questionAr";
  static const String questionEnField = "questionEn";
  static const String messageArField = "messageAr";
  static const String messageEnField = "messageEn";
  static const String answerArField = "answerAr";
  static const String answerEnField = "answerEn";
  static const String titleArField = "titleAr";
  static const String titleEnField = "titleEn";
  static const String articleArField = "articleAr";
  static const String articleEnField = "articleEn";
  static const String playlistNameArField = "playlistNameAr";
  static const String playlistNameEnField = "playlistNameEn";
  static const String aboutVideoArField = "aboutVideoAr";
  static const String aboutVideoEnField = "aboutVideoEn";
  static const String userTypeField = "userType";
  static const String amountField = "amount";
  static const String walletTransactionTypeField = "walletTransactionType";
  static const String withdrawalRequestStatusField = "withdrawalRequestStatus";
  static const String paymentTypeField = "paymentType";
  static const String paymentTypeValueField = "paymentTypeValue";
  static const String limitField = "limit";
  static const String pageField = "page";
  static const String searchTextField = "searchText";
  static const String filtersMapField = "filtersMap";
  static const String orderByField = "orderBy";
  static const String featureArField = "featureAr";
  static const String featureEnField = "featureEn";
  static const String jobTitleField = "jobTitle";
  static const String minSalaryField = "minSalary";
  static const String maxSalaryField = "maxSalary";
  static const String jobLocationField = "jobLocation";
  static const String jobStatusField = "jobStatus";
  static const String aboutCompanyField = "aboutCompany";
  static const String companyNameField = "companyName";
  static const String addressField = "address";
  static const String consultationPriceField = "consultationPrice";
  static const String tasksField = "tasks";
  static const String featuresField = "features";
  static const String photoGalleryField = "photoGallery";
  static const String governorateIdField = "governorateId";
  static const String accountStatusField = "accountStatus";
  static const String availablePeriodsField = "availablePeriods";
  static const String identificationImagesField = "identificationImages";
  static const String nationalIdField = "nationalId";
  static const String nationalImageFrontSideField = "nationalImageFrontSide";
  static const String nationalImageBackSideField = "nationalImageBackSide";
  static const String cardNumberField = "cardNumber";
  static const String cardImageField = "cardImage";
  static const String categoriesIdsField = "categoriesIds";
  static const String servicesIdsField = "servicesIds";
  static const String ratingField = "rating";
  static const String commentField = "comment";
  static const String featuresArField = "featuresAr";
  static const String featuresEnField = "featuresEn";
  static const String bookingDateField = "bookingDate";
  static const String consultationField = "consultation";
  static const String commentStatusField = "commentStatus";
  static const String secretConsultationReplyTypeField = "secretConsultationReplyType";
  static const String replyTypeValueField = "replyTypeValue";
  static const String imagesField = "images";
  // endregion

  // region Images Directory
  static const String adminsDirectory = "admins";
  static const String usersDirectory = "users";
  static const String accountsDirectory = "accounts";
  static const String slidersDirectory = "sliders";
  static const String articlesDirectory = "articles";
  static const String socialMediaDirectory = "social_media";
  static const String categoriesDirectory = "categories";
  static const String mainCategoriesDirectory = "main_categories";
  static const String jobsDirectory = "jobs";
  static const String employmentApplicationsDirectory = "employment_applications";
  static const String servicesDirectory = "services";
  static const String accountsGalleryDirectory = "accounts_gallery";
  static const String accountsIdentificationDirectory = "accounts_identification";
  static const String playlistsDirectory = "playlists";
  static const String instantConsultationsDirectory = "instant_consultations";
  static const String secretConsultationsDirectory = "secret_consultations";
  // endregion

  // region File URL
  static String fileUrl({required String fileName}) => '${baseUrl}upload/$fileName';
  // endregion
}