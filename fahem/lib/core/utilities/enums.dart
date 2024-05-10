import 'package:fahem/core/network/api_constants.dart';
import 'package:fahem/core/resources/assets_manager.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/presentation/screens/home/screens/home_screen.dart';
import 'package:fahem/presentation/screens/menu/menu_screen.dart';
import 'package:fahem/presentation/screens/search/screens/search_screen.dart';
import 'package:fahem/presentation/screens/transactions/screens/transactions_screen.dart';
import 'package:fahem/presentation/screens/wallet/screens/wallet_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fahem/core/resources/constants_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';

enum App {fahem, fahemBusiness, fahemDashboard}

enum UserType {
  account, user;

  static String toText(UserType userType) {
  switch(userType) {
    case UserType.account: return Methods.getText(StringsManager.businessAccount).toTitleCase();
    case UserType.user: return Methods.getText(StringsManager.userAccount).toTitleCase();
  }
}
}

enum SignInMethod {emailAndPassword, phoneNumber, google}

enum Gender {
  male, female, notSpecified;

  static String toText(Gender gender) {
    switch(gender) {
      case Gender.male: return Methods.getText(StringsManager.male).toTitleCase();
      case Gender.female: return Methods.getText(StringsManager.female).toTitleCase();
      case Gender.notSpecified: return Methods.getText(StringsManager.notSpecified).toTitleCase();
    }
  }
}

enum AccountStatus {
  active, pending, rejected;

  static String toText(AccountStatus accountStatus) {
    switch(accountStatus) {
      case AccountStatus.active: return Methods.getText(StringsManager.active).toTitleCase();
      case AccountStatus.pending: return Methods.getText(StringsManager.pending).toTitleCase();
      case AccountStatus.rejected: return Methods.getText(StringsManager.rejected).toTitleCase();
    }
  }

  static Color getColor(AccountStatus accountStatus) {
    switch(accountStatus) {
      case AccountStatus.active: return ColorsManager.green;
      case AccountStatus.pending: return ColorsManager.amber;
      case AccountStatus.rejected: return ColorsManager.red;
    }
  }

  static IconData getIcon(AccountStatus accountStatus) {
    switch(accountStatus) {
      case AccountStatus.active: return Icons.check;
      case AccountStatus.pending: return Icons.pending;
      case AccountStatus.rejected: return Icons.close;
    }
  }
}

enum JobStatus {
  active, pending, rejected;

  static String toText(JobStatus jobStatus) {
    switch(jobStatus) {
      case JobStatus.active: return Methods.getText(StringsManager.active).toTitleCase();
      case JobStatus.pending: return Methods.getText(StringsManager.pending).toTitleCase();
      case JobStatus.rejected: return Methods.getText(StringsManager.rejected).toTitleCase();
    }
  }

  static Color getColor(JobStatus jobStatus) {
    switch(jobStatus) {
      case JobStatus.active: return ColorsManager.green;
      case JobStatus.pending: return ColorsManager.amber;
      case JobStatus.rejected: return ColorsManager.red;
    }
  }

  static IconData getIcon(JobStatus jobStatus) {
    switch(jobStatus) {
      case JobStatus.active: return Icons.check;
      case JobStatus.pending: return Icons.pending;
      case JobStatus.rejected: return Icons.close;
    }
  }
}

enum CommentStatus {
  active, pending, rejected;

  static String toText(CommentStatus commentStatus) {
    switch(commentStatus) {
      case CommentStatus.active: return Methods.getText(StringsManager.active).toTitleCase();
      case CommentStatus.pending: return Methods.getText(StringsManager.pending).toTitleCase();
      case CommentStatus.rejected: return Methods.getText(StringsManager.rejected).toTitleCase();
    }
  }

  static Color getColor(CommentStatus commentStatus) {
    switch(commentStatus) {
      case CommentStatus.active: return ColorsManager.green;
      case CommentStatus.pending: return ColorsManager.amber;
      case CommentStatus.rejected: return ColorsManager.red;
    }
  }

  static IconData getIcon(CommentStatus commentStatus) {
    switch(commentStatus) {
      case CommentStatus.active: return Icons.check;
      case CommentStatus.pending: return Icons.pending;
      case CommentStatus.rejected: return Icons.close;
    }
  }
}

enum NotificationTo {
  all, one;

  static String toText(NotificationTo notificationTo) {
    switch(notificationTo) {
      case NotificationTo.all: return Methods.getText(StringsManager.all).toTitleCase();
      default: return Methods.getText(StringsManager.oneUser).toTitleCase();
    }
  }
}

enum NotificationToApp {
  fahem, fahemBusiness;

  static String toText(NotificationToApp notificationToApp) {
    switch(notificationToApp) {
      case NotificationToApp.fahem: return Methods.getText(StringsManager.fahem).toTitleCase();
      case NotificationToApp.fahemBusiness: return Methods.getText(StringsManager.fahemBusiness).toTitleCase();
    }
  }
}

enum SliderTarget {
  externalLink, whatsapp, openImage;

  static String toText(SliderTarget sliderTarget) {
    switch(sliderTarget) {
      case SliderTarget.externalLink: return Methods.getText(StringsManager.openExternalLink).toTitleCase();
      case SliderTarget.whatsapp: return Methods.getText(StringsManager.openWhatsapp).toTitleCase();
      case SliderTarget.openImage: return Methods.getText(StringsManager.openImage).toTitleCase();
      // case SliderTarget.jobDetails: return Methods.getText(StringsManager.openJobDetailsPage).toTitleCase();
    }
  }
}

enum WalletTransactionType {
  chargeWallet, instantConsultation, secretConsultation, bestResponse;

  static String toText(WalletTransactionType walletTransactionType) {
    switch(walletTransactionType) {
      case WalletTransactionType.chargeWallet: return Methods.getText(StringsManager.chargeWallet).toCapitalized();
      case WalletTransactionType.instantConsultation: return Methods.getText(StringsManager.instantConsultationTransactionType).toCapitalized();
      case WalletTransactionType.secretConsultation: return Methods.getText(StringsManager.secretConsultationTransactionType).toCapitalized();
      case WalletTransactionType.bestResponse: return Methods.getText(StringsManager.bestResponse).toCapitalized();
      // case WalletTransactionType.refund: return Methods.getText(StringsManager.refund).toCapitalized();
    }
  }
}

enum WithdrawalRequestStatus {
  done, pending, rejected;

  static String toText(WithdrawalRequestStatus withdrawalRequestStatus) {
    switch(withdrawalRequestStatus) {
      case WithdrawalRequestStatus.done: return Methods.getText(StringsManager.done).toTitleCase();
      case WithdrawalRequestStatus.pending: return Methods.getText(StringsManager.pending).toTitleCase();
      case WithdrawalRequestStatus.rejected: return Methods.getText(StringsManager.rejected).toTitleCase();
    }
  }

  static Color getColor(WithdrawalRequestStatus withdrawalRequestStatus) {
    switch(withdrawalRequestStatus) {
      case WithdrawalRequestStatus.done: return ColorsManager.green;
      case WithdrawalRequestStatus.pending: return ColorsManager.amber;
      case WithdrawalRequestStatus.rejected: return ColorsManager.red;
    }
  }

  static IconData getIcon(WithdrawalRequestStatus withdrawalRequestStatus) {
    switch(withdrawalRequestStatus) {
      case WithdrawalRequestStatus.done: return Icons.check;
      case WithdrawalRequestStatus.pending: return Icons.pending;
      case WithdrawalRequestStatus.rejected: return Icons.close;
    }
  }
}

enum PaymentType {
  wallet, instaPay;

  static String toText(PaymentType paymentType) {
    switch(paymentType) {
      case PaymentType.wallet: return Methods.getText(StringsManager.wallet).toTitleCase();
      case PaymentType.instaPay: return Methods.getText(StringsManager.instaPay);
    }
  }
}

enum SecretConsultationReplyType {
  call, whatsapp;

  static String toText(SecretConsultationReplyType secretConsultationReplyType) {
    switch(secretConsultationReplyType) {
      case SecretConsultationReplyType.call: return Methods.getText(StringsManager.callReplyType).toTitleCase();
      case SecretConsultationReplyType.whatsapp: return Methods.getText(StringsManager.whatsappReplyType);
    }
  }
}

////////////////////////////////////////////////////////////////////////////////

enum BottomNavigationBarPages {
  home(title: StringsManager.home, page: HomeScreen(), image: IconsManager.home),
  search(title: StringsManager.theSearch, page: SearchScreen(), image: IconsManager.search),
  transactions(title: StringsManager.myTransactions, page: TransactionsScreen(), image: IconsManager.transaction),
  wallet(title: StringsManager.myWallet, page: WalletHistoryScreen(), image: IconsManager.wallet),
  menu(title: StringsManager.menu, page: MenuScreen(), image: IconsManager.menu);

  final String title;
  final Widget page;
  final IconData? icon;
  final String? image;

  const BottomNavigationBarPages({
    required this.title,
    required this.page,
    this.icon,
    this.image,
  });
}

enum WordStatusLabel {year, month, week, day, hour, minute, second, like, comment, lesson, student, point, product, video, user}

enum ViewStyle {list, grid}

enum ShowMessage {success, failure}

enum MessageMode {send, delete}

enum DataState {loading, error, empty, done}

enum FiltersType {
  gender, commentStatus, userType, walletTransactionType, withdrawalRequestStatus, paymentType,
  isFeatured, isSuper, isAvailable, isDone, dateOfCreated, periodDate, singleDate,
  user, account, mainCategory, category, playlist, instantConsultation, country, currency;
}

enum PopupMenu {
  edit, delete, changeLanguage, logout;

  static String toText(PopupMenu popupMenu) {
    switch(popupMenu) {
      case PopupMenu.edit: return Methods.getText(StringsManager.edit).toTitleCase();
      case PopupMenu.delete: return Methods.getText(StringsManager.delete).toTitleCase();
      case PopupMenu.changeLanguage: return Methods.getText(StringsManager.changeLanguage).toTitleCase();
      case PopupMenu.logout: return Methods.getText(StringsManager.logout).toTitleCase();
    }
  }

  static IconData getIcon(PopupMenu popupMenu) {
    switch(popupMenu) {
      case PopupMenu.edit: return FontAwesomeIcons.solidPenToSquare;
      case PopupMenu.delete: return FontAwesomeIcons.trash;
      case PopupMenu.changeLanguage: return FontAwesomeIcons.earthAfrica;
      case PopupMenu.logout: return FontAwesomeIcons.arrowRightFromBracket;
    }
  }
}

enum DaysOfWeek {
  saturday, sunday, monday, tuesday, wednesday, thursday, friday;

  static String toText(DaysOfWeek daysOfWeek) {
    switch(daysOfWeek) {
      case DaysOfWeek.saturday: return Methods.getText(StringsManager.saturday).toTitleCase();
      case DaysOfWeek.sunday: return Methods.getText(StringsManager.sunday).toTitleCase();
      case DaysOfWeek.monday: return Methods.getText(StringsManager.monday).toTitleCase();
      case DaysOfWeek.tuesday: return Methods.getText(StringsManager.tuesday).toTitleCase();
      case DaysOfWeek.wednesday: return Methods.getText(StringsManager.wednesday).toTitleCase();
      case DaysOfWeek.thursday: return Methods.getText(StringsManager.thursday).toTitleCase();
      case DaysOfWeek.friday: return Methods.getText(StringsManager.friday).toTitleCase();
    }
  }
}

enum OrderByType {
  adminsNewestFirst(title: StringsManager.newestFirst, query: '${ApiConstants.adminIdField} ${ConstantsManager.desc}'),
  adminsOldestFirst(title: StringsManager.oldestFirst, query: '${ApiConstants.adminIdField} ${ConstantsManager.asc}'),
  usersNewestFirst(title: StringsManager.newestFirst, query: '${ApiConstants.userIdField} ${ConstantsManager.desc}'),
  usersOldestFirst(title: StringsManager.oldestFirst, query: '${ApiConstants.userIdField} ${ConstantsManager.asc}'),
  accountsNewestFirst(title: StringsManager.newestFirst, query: '${ApiConstants.accountIdField} ${ConstantsManager.desc}'),
  accountsOldestFirst(title: StringsManager.oldestFirst, query: '${ApiConstants.accountIdField} ${ConstantsManager.asc}'),
  slidersNewestFirst(title: StringsManager.newestFirst, query: '${ApiConstants.sliderIdField} ${ConstantsManager.desc}'),
  slidersOldestFirst(title: StringsManager.oldestFirst, query: '${ApiConstants.sliderIdField} ${ConstantsManager.asc}'),
  notificationsNewestFirst(title: StringsManager.newestFirst, query: '${ApiConstants.notificationIdField} ${ConstantsManager.desc}'),
  notificationsOldestFirst(title: StringsManager.oldestFirst, query: '${ApiConstants.notificationIdField} ${ConstantsManager.asc}'),
  complaintsNewestFirst(title: StringsManager.newestFirst, query: '${ApiConstants.complaintIdField} ${ConstantsManager.desc}'),
  complaintsOldestFirst(title: StringsManager.oldestFirst, query: '${ApiConstants.complaintIdField} ${ConstantsManager.asc}'),
  faqsNewestFirst(title: StringsManager.newestFirst, query: '${ApiConstants.faqIdField} ${ConstantsManager.desc}'),
  faqsOldestFirst(title: StringsManager.oldestFirst, query: '${ApiConstants.faqIdField} ${ConstantsManager.asc}'),
  articlesNewestFirst(title: StringsManager.newestFirst, query: '${ApiConstants.articleIdField} ${ConstantsManager.desc}'),
  articlesOldestFirst(title: StringsManager.oldestFirst, query: '${ApiConstants.articleIdField} ${ConstantsManager.asc}'),
  socialMediaNewestFirst(title: StringsManager.newestFirst, query: '${ApiConstants.socialMediaIdField} ${ConstantsManager.desc}'),
  socialMediaOldestFirst(title: StringsManager.oldestFirst, query: '${ApiConstants.socialMediaIdField} ${ConstantsManager.asc}'),
  suggestedMessagesNewestFirst(title: StringsManager.newestFirst, query: '${ApiConstants.suggestedMessageIdField} ${ConstantsManager.desc}'),
  suggestedMessagesOldestFirst(title: StringsManager.oldestFirst, query: '${ApiConstants.suggestedMessageIdField} ${ConstantsManager.asc}'),
  walletHistoryNewestFirst(title: StringsManager.newestFirst, query: '${ApiConstants.walletHistoryIdField} ${ConstantsManager.desc}'),
  walletHistoryOldestFirst(title: StringsManager.oldestFirst, query: '${ApiConstants.walletHistoryIdField} ${ConstantsManager.asc}'),
  categoriesNewestFirst(title: StringsManager.newestFirst, query: '${ApiConstants.categoryIdField} ${ConstantsManager.desc}'),
  categoriesOldestFirst(title: StringsManager.oldestFirst, query: '${ApiConstants.categoryIdField} ${ConstantsManager.asc}'),
  mainCategoriesNewestFirst(title: StringsManager.newestFirst, query: '${ApiConstants.mainCategoryIdField} ${ConstantsManager.desc}'),
  mainCategoriesOldestFirst(title: StringsManager.oldestFirst, query: '${ApiConstants.mainCategoryIdField} ${ConstantsManager.asc}'),
  jobsNewestFirst(title: StringsManager.newestFirst, query: '${ApiConstants.jobIdField} ${ConstantsManager.desc}'),
  jobsOldestFirst(title: StringsManager.oldestFirst, query: '${ApiConstants.jobIdField} ${ConstantsManager.asc}'),
  employmentApplicationsNewestFirst(title: StringsManager.newestFirst, query: '${ApiConstants.employmentApplicationIdField} ${ConstantsManager.desc}'),
  employmentApplicationsOldestFirst(title: StringsManager.oldestFirst, query: '${ApiConstants.employmentApplicationIdField} ${ConstantsManager.asc}'),
  servicesNewestFirst(title: StringsManager.newestFirst, query: '${ApiConstants.serviceIdField} ${ConstantsManager.desc}'),
  servicesOldestFirst(title: StringsManager.oldestFirst, query: '${ApiConstants.serviceIdField} ${ConstantsManager.asc}'),
  featuresNewestFirst(title: StringsManager.newestFirst, query: '${ApiConstants.featureIdField} ${ConstantsManager.desc}'),
  featuresOldestFirst(title: StringsManager.oldestFirst, query: '${ApiConstants.featureIdField} ${ConstantsManager.asc}'),
  reviewsNewestFirst(title: StringsManager.newestFirst, query: '${ApiConstants.reviewIdField} ${ConstantsManager.desc}'),
  reviewsOldestFirst(title: StringsManager.oldestFirst, query: '${ApiConstants.reviewIdField} ${ConstantsManager.asc}'),
  playlistsNewestFirst(title: StringsManager.newestFirst, query: '${ApiConstants.playlistIdField} ${ConstantsManager.desc}'),
  playlistsOldestFirst(title: StringsManager.oldestFirst, query: '${ApiConstants.playlistIdField} ${ConstantsManager.asc}'),
  videosNewestFirst(title: StringsManager.newestFirst, query: '${ApiConstants.videoIdField} ${ConstantsManager.desc}'),
  videosOldestFirst(title: StringsManager.oldestFirst, query: '${ApiConstants.videoIdField} ${ConstantsManager.asc}'),
  playlistsCommentsNewestFirst(title: StringsManager.newestFirst, query: '${ApiConstants.playlistCommentIdField} ${ConstantsManager.desc}'),
  playlistsCommentsOldestFirst(title: StringsManager.oldestFirst, query: '${ApiConstants.playlistCommentIdField} ${ConstantsManager.asc}'),
  phoneNumberRequestsNewestFirst(title: StringsManager.newestFirst, query: '${ApiConstants.phoneNumberRequestIdField} ${ConstantsManager.desc}'),
  phoneNumberRequestsOldestFirst(title: StringsManager.oldestFirst, query: '${ApiConstants.phoneNumberRequestIdField} ${ConstantsManager.asc}'),
  bookingAppointmentsNewestFirst(title: StringsManager.newestFirst, query: '${ApiConstants.bookingAppointmentIdField} ${ConstantsManager.desc}'),
  bookingAppointmentsOldestFirst(title: StringsManager.oldestFirst, query: '${ApiConstants.bookingAppointmentIdField} ${ConstantsManager.asc}'),
  instantConsultationsNewestFirst(title: StringsManager.newestFirst, query: '${ApiConstants.instantConsultationIdField} ${ConstantsManager.desc}'),
  instantConsultationsOldestFirst(title: StringsManager.oldestFirst, query: '${ApiConstants.instantConsultationIdField} ${ConstantsManager.asc}'),
  instantConsultationsCommentsNewestFirst(title: StringsManager.newestFirst, query: '${ApiConstants.instantConsultationCommentIdField} ${ConstantsManager.desc}'),
  instantConsultationsCommentsOldestFirst(title: StringsManager.oldestFirst, query: '${ApiConstants.instantConsultationCommentIdField} ${ConstantsManager.asc}'),
  secretConsultationsNewestFirst(title: StringsManager.newestFirst, query: '${ApiConstants.secretConsultationIdField} ${ConstantsManager.desc}'),
  secretConsultationsOldestFirst(title: StringsManager.oldestFirst, query: '${ApiConstants.secretConsultationIdField} ${ConstantsManager.asc}'),
  withdrawalRequestsNewestFirst(title: StringsManager.newestFirst, query: '${ApiConstants.withdrawalRequestIdField} ${ConstantsManager.desc}'),
  withdrawalRequestsOldestFirst(title: StringsManager.oldestFirst, query: '${ApiConstants.withdrawalRequestIdField} ${ConstantsManager.asc}'),

  adminNameAZ(title: StringsManager.adminNameAZ, query: '${ApiConstants.fullNameField} ${ConstantsManager.asc}'),
  adminNameZA(title: StringsManager.adminNameZA, query: '${ApiConstants.fullNameField} ${ConstantsManager.desc}'),
  userNameAZ(title: StringsManager.userNameAZ, query: '${ApiConstants.fullNameField} ${ConstantsManager.asc}'),
  userNameZA(title: StringsManager.userNameZA, query: '${ApiConstants.fullNameField} ${ConstantsManager.desc}'),
  accountNameAZ(title: StringsManager.accountNameAZ, query: '${ApiConstants.fullNameField} ${ConstantsManager.asc}'),
  accountNameZA(title: StringsManager.accountNameZA, query: '${ApiConstants.fullNameField} ${ConstantsManager.desc}'),

  customOrderAsc(title: '', query: '${ApiConstants.customOrderField} ${ConstantsManager.asc}'),
  customOrderDesc(title: '', query: '${ApiConstants.customOrderField} ${ConstantsManager.desc}'),
  latestDate(title: StringsManager.newestFirst, query: '${ApiConstants.dateField} ${ConstantsManager.desc}'),
  latestCreatedAt(title: StringsManager.newestFirst, query: '${ApiConstants.createdAtField} ${ConstantsManager.desc}'),
  highestViews(title: StringsManager.highestViews, query: '${ApiConstants.viewsField} ${ConstantsManager.desc}'),
  lowestViews(title: StringsManager.lowestViews, query: '${ApiConstants.viewsField} ${ConstantsManager.asc}'),
  isFeatured(title: '', query: '${ApiConstants.isFeaturedField} ${ConstantsManager.desc}'),
  highestRating(title: StringsManager.highestRating, query: '${ApiConstants.ratingField} ${ConstantsManager.desc}'),
  lowestRating(title: StringsManager.lowestRating, query: '${ApiConstants.ratingField} ${ConstantsManager.asc}');

  final String title;
  final String query;

  const OrderByType({required this.title, required this.query});
}

enum AdminPermissions {
  showStatistics(nameAr: 'عرض الإحصائيات', nameEn: 'Show statistics'),

  addAdmin(nameAr: 'اضافة ادمن', nameEn: 'Add admin'),
  editAdmin(nameAr: 'تعديل ادمن', nameEn: 'Edit admin'),
  deleteAdmin(nameAr: 'حذف ادمن', nameEn: 'Delete admin'),
  showAdmins(nameAr: 'عرض المسئولين', nameEn: 'Show admins'),

  addUser(nameAr: 'اضافة مستخدم', nameEn: 'Add user'),
  editUser(nameAr: 'تعديل مستخدم', nameEn: 'Edit user'),
  deleteUser(nameAr: 'حذف مستخدم', nameEn: 'Delete user'),
  showUsers(nameAr: 'عرض المستخدمين', nameEn: 'Show users'),

  addAccount(nameAr: 'اضافة حساب', nameEn: 'Add account'),
  editAccount(nameAr: 'تعديل حساب', nameEn: 'Edit account'),
  deleteAccount(nameAr: 'حذف حساب', nameEn: 'Delete account'),
  showAccounts(nameAr: 'عرض الحسابات', nameEn: 'Show accounts'),

  addSlider(nameAr: 'اضافة بانر', nameEn: 'Add slider'),
  editSlider(nameAr: 'تعديل بانر', nameEn: 'Edit slider'),
  deleteSlider(nameAr: 'حذف بانر', nameEn: 'Delete slider'),
  showSliders(nameAr: 'عرض البانرات', nameEn: 'Show sliders'),

  addFaq(nameAr: 'اضافة سؤال شائع', nameEn: 'Add faq'),
  editFaq(nameAr: 'تعديل سؤال شائع', nameEn: 'Edit faq'),
  deleteFaq(nameAr: 'حذف سؤال شائع', nameEn: 'Delete faq'),
  showFaqs(nameAr: 'عرض الاسئلة الشائعة', nameEn: 'Show faqs'),

  addArticle(nameAr: 'اضافة مقالة', nameEn: 'Add article'),
  editArticle(nameAr: 'تعديل مقالة', nameEn: 'Edit article'),
  deleteArticle(nameAr: 'حذف مقالة', nameEn: 'Delete article'),
  showArticles(nameAr: 'عرض المقالات', nameEn: 'Show articles'),

  addSocialMedia(nameAr: 'اضافة وسيلة تواصل', nameEn: 'Add social media'),
  editSocialMedia(nameAr: 'تعديل وسيلة تواصل', nameEn: 'Edit social media'),
  deleteSocialMedia(nameAr: 'حذف وسيلة تواصل', nameEn: 'Delete social media'),
  showSocialMedia(nameAr: 'عرض وسائل التواصل', nameEn: 'Show social media'),

  addSuggestedMessage(nameAr: 'اضافة رسالة مقترحة', nameEn: 'Add suggested message'),
  editSuggestedMessage(nameAr: 'تعديل رسالة مقترحة', nameEn: 'Edit suggested message'),
  deleteSuggestedMessage(nameAr: 'حذف رسالة مقترحة', nameEn: 'Delete suggested message'),
  showSuggestedMessages(nameAr: 'عرض الرسائل المقترحة', nameEn: 'Show suggested messages'),

  addCategory(nameAr: 'اضافة فئة', nameEn: 'Add category'),
  editCategory(nameAr: 'تعديل فئة', nameEn: 'Edit category'),
  deleteCategory(nameAr: 'حذف فئة', nameEn: 'Delete category'),
  showCategories(nameAr: 'عرض الفئات', nameEn: 'Show categories'),

  addMainCategory(nameAr: 'اضافة قسم رئيسى', nameEn: 'Add main category'),
  editMainCategory(nameAr: 'تعديل قسم رئيسى', nameEn: 'Edit main category'),
  deleteMainCategory(nameAr: 'حذف قسم رئيسى', nameEn: 'Delete main category'),
  showMainCategories(nameAr: 'عرض الاقسام الرئيسية', nameEn: 'Show main categories'),

  addJob(nameAr: 'اضافة وظيفة', nameEn: 'Add job'),
  editJob(nameAr: 'تعديل وظيفة', nameEn: 'Edit job'),
  deleteJob(nameAr: 'حذف وظيفة', nameEn: 'Delete job'),
  showJobs(nameAr: 'عرض الوظائف', nameEn: 'Show jobs'),

  addService(nameAr: 'اضافة خدمة', nameEn: 'Add service'),
  editService(nameAr: 'تعديل خدمة', nameEn: 'Edit service'),
  deleteService(nameAr: 'حذف خدمة', nameEn: 'Delete service'),
  showServices(nameAr: 'عرض الخدمات', nameEn: 'Show services'),

  addFeature(nameAr: 'اضافة ميزة', nameEn: 'Add feature'),
  editFeature(nameAr: 'تعديل ميزة', nameEn: 'Edit feature'),
  deleteFeature(nameAr: 'حذف ميزة', nameEn: 'Delete feature'),
  showFeatures(nameAr: 'عرض الميزات', nameEn: 'Show features'),

  addReview(nameAr: 'اضافة مراجعة', nameEn: 'Add review'),
  editReview(nameAr: 'تعديل مراجعة', nameEn: 'Edit review'),
  deleteReview(nameAr: 'حذف مراجعة', nameEn: 'Delete review'),
  showReviews(nameAr: 'عرض المراجعات', nameEn: 'Show reviews'),

  addPlaylist(nameAr: 'اضافة قائمة فيديوهات', nameEn: 'Add playlist'),
  editPlaylist(nameAr: 'تعديل قائمة فيديوهات', nameEn: 'Edit playlist'),
  deletePlaylist(nameAr: 'حذف قائمة فيديوهات', nameEn: 'Delete playlist'),
  showPlaylists(nameAr: 'عرض قوائم الفيديوهات', nameEn: 'Show playlists'),

  addVideo(nameAr: 'اضافة فيديو', nameEn: 'Add video'),
  editVideo(nameAr: 'تعديل فيديو', nameEn: 'Edit video'),
  deleteVideo(nameAr: 'حذف فيديو', nameEn: 'Delete video'),
  showVideos(nameAr: 'عرض الفيديوهات', nameEn: 'Show videos'),

  addPlaylistComment(nameAr: 'اضافة تعليق فيديو', nameEn: 'Add playlist comment'),
  editPlaylistComment(nameAr: 'تعديل تعليق فيديو', nameEn: 'Edit playlist comment'),
  deletePlaylistComment(nameAr: 'حذف تعليق فيديو', nameEn: 'Delete playlist comment'),
  showPlaylistsComments(nameAr: 'عرض تعليقات الفيديوهات', nameEn: 'Show playlists comments'),

  addPhoneNumberRequest(nameAr: 'اضافة طلب رقم الهاتف', nameEn: 'Add phone number request'),
  editPhoneNumberRequest(nameAr: 'تعديل طلب رقم الهاتف', nameEn: 'Edit phone number request'),
  deletePhoneNumberRequest(nameAr: 'حذف طلب رقم الهاتف', nameEn: 'Delete phone number request'),
  showPhoneNumberRequests(nameAr: 'عرض طلبات رقم الهاتف', nameEn: 'Show phone number requests'),

  addBookingAppointment(nameAr: 'اضافة حجز موعد', nameEn: 'Add booking appointment'),
  editBookingAppointment(nameAr: 'تعديل حجز موعد', nameEn: 'Edit booking appointment'),
  deleteBookingAppointment(nameAr: 'حذف حجز موعد', nameEn: 'Delete booking appointment'),
  showBookingAppointments(nameAr: 'عرض حجز المواعيد', nameEn: 'Show booking appointments'),

  addInstantConsultation(nameAr: 'اضافة استشارة فورية', nameEn: 'Add instant consultation'),
  editInstantConsultation(nameAr: 'تعديل استشارة فورية', nameEn: 'Edit instant consultation'),
  deleteInstantConsultation(nameAr: 'حذف استشارة فورية', nameEn: 'Delete instant consultation'),
  showInstantConsultations(nameAr: 'عرض الاستشارات الفورية', nameEn: 'Show instant consultations'),

  addInstantConsultationComment(nameAr: 'اضافة تعليق استشارة فورية', nameEn: 'Add instant consultation comment'),
  editInstantConsultationComment(nameAr: 'تعديل تعليق استشارة فورية', nameEn: 'Edit instant consultation comment'),
  deleteInstantConsultationComment(nameAr: 'حذف تعليق استشارة فورية', nameEn: 'Delete instant consultation comment'),
  showInstantConsultationComments(nameAr: 'عرض تعليقات الاستشارات الفورية', nameEn: 'Show instant consultation comments'),

  addSecretConsultation(nameAr: 'اضافة استشارة سرية', nameEn: 'Add secret consultation'),
  editSecretConsultation(nameAr: 'تعديل استشارة سرية', nameEn: 'Edit secret consultation'),
  deleteSecretConsultation(nameAr: 'حذف استشارة سرية', nameEn: 'Delete secret consultation'),
  showSecretConsultations(nameAr: 'عرض الاستشارات السرية', nameEn: 'Show secret consultations'),

  addWithdrawalRequest(nameAr: 'اضافة طلب سحب رصيد', nameEn: 'Add withdrawal request'),
  editWithdrawalRequest(nameAr: 'تعديل طلب سحب رصيد', nameEn: 'Edit withdrawal request'),
  deleteWithdrawalRequest(nameAr: 'حذف طلب سحب رصيد', nameEn: 'Delete withdrawal request'),
  showWithdrawalRequests(nameAr: 'عرض طلبات سحب الرصيد', nameEn: 'Show withdrawal requests'),

  addWalletHistory(nameAr: 'اضافة سجل رصيد', nameEn: 'Add wallet history'),
  editWalletHistory(nameAr: 'تعديل سجل رصيد', nameEn: 'Edit wallet history'),
  deleteWalletHistory(nameAr: 'حذف سجل رصيد', nameEn: 'Delete wallet history'),
  showWalletHistory(nameAr: 'عرض سجلات الرصيد', nameEn: 'Show wallet history'),

  deleteComplaint(nameAr: 'حذف شكوى', nameEn: 'Delete complaint'),
  showComplaints(nameAr: 'عرض الشكاوى', nameEn: 'Show complaints'),

  deleteEmploymentApplication(nameAr: 'حذف طلب توظيف', nameEn: 'Delete employment application'),
  showEmploymentApplications(nameAr: 'عرض طلبات التوظيف', nameEn: 'Show employment applications'),

  showFinancialAccounts(nameAr: 'عرض الحسابات المالية', nameEn: 'Show financial accounts'),

  editAboutApp(nameAr: 'تعديل عن التطبيق', nameEn: 'Edit about app'),
  showAboutApp(nameAr: 'عرض عن التطبيق', nameEn: 'Show about app'),

  editServiceDescription(nameAr: 'تعديل وصف الخدمة', nameEn: 'Edit service description'),
  showServiceDescription(nameAr: 'عرض وصف الخدمة', nameEn: 'Show service description'),

  editPrivacyPolicy(nameAr: 'تعديل سياسة الخصوصية', nameEn: 'Edit privacy policy'),
  showPrivacyPolicy(nameAr: 'عرض سياسة الخصوصية', nameEn: 'Show privacy policy'),

  editTermsOfUse(nameAr: 'تعديل شروط الاستخدام', nameEn: 'Edit terms of use'),
  showTermsOfUse(nameAr: 'عرض شروط الاستخدام', nameEn: 'Show terms of use'),

  controlSettings(nameAr: 'التحكم فى الاعدادات', nameEn: 'Control settings'),
  editVersion(nameAr: 'تعديل الاصدار', nameEn: 'Edit version');

  final String nameAr;
  final String nameEn;

  const AdminPermissions({required this.nameAr, required this.nameEn});
}

enum StatisticsLabels {
  revenues, expenses, accounts, users
}

enum PaymentsMethods {direct, wallet}