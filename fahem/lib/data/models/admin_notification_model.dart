class AdminNotificationModel {
  late final int adminNotificationId;
  late final String title;
  late final String body;
  late final bool isViewed;
  late final String createdAt;

  AdminNotificationModel({
    required this.adminNotificationId,
    required this.title,
    required this.body,
    required this.isViewed,
    required this.createdAt,
  });

  AdminNotificationModel.fromJson(Map<String, dynamic> json) {
    adminNotificationId = int.parse(json['adminNotificationId'].toString());
    title = json['title'];
    body = json['body'];
    isViewed = json['isViewed'];
    createdAt = json['createdAt'];
  }
}