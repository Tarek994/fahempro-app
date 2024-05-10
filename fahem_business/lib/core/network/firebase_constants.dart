class FirebaseConstants {

  // region Collections
  static const String technicalSupportCollection = 'technicalSupport';
  static const String privateChatsCollection = 'privateChats';
  static const String groupsChatsCollection = 'groupsChats';
  // endregion

  // region Sub Collections
  static const String messagesSubCollection = 'messages';
  // endregion

  // region Fields
  static const String usersIdsField = 'usersIds';
  static const String messageModeField = 'messageMode';
  static const String createdAtField = 'createdAt';
  static const String lastMessageCreateAtField = 'lastMessageCreateAtField';
  // endregion

  // region Prefix
  static const String accountPrefix = 'account';
  static const String userPrefix = 'user';
  // endregion

  // region Topics
  static const String fahemTopic = 'fahem_topic';
  static const String fahemBusinessTopic = 'fahem_business_topic';
  static const String fahemDashboardTopic = 'fahem_dashboard_topic';
  // endregion

  // region Data Action (Admin)
  static const String newComplaint = 'newComplaint';
  static const String newJob = 'newJob';
  static const String editJob = 'editJob';
  // endregion

  // region Data Action (User)
  static const String deleteAccount = 'deleteAccount';
  static const String updateApp = 'updateApp';
  static const String jobStatus = 'jobStatus';
  // endregion

  // region Constants
  static const String adminId = '0';
  // endregion
}