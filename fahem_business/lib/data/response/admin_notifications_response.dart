import 'package:fahem_business/data/models/admin_notification_model.dart';
import 'package:fahem_business/data/models/static/base_model.dart';
import 'package:fahem_business/data/models/static/pagination_model.dart';

class AdminNotificationsResponse {
  late final BaseModel base;
  late final PaginationModel pagination;
  late final List<AdminNotificationModel> adminNotifications;

  AdminNotificationsResponse({
    required this.base,
    required this.pagination,
    required this.adminNotifications,
  });

  AdminNotificationsResponse.fromJson(Map<String, dynamic> json) {
    base = BaseModel.fromJson(json['base']);
    pagination = PaginationModel.fromJson(json['pagination']);
    adminNotifications = List.from(json['adminNotifications']).map((e) => AdminNotificationModel.fromJson(e)).toList();
  }
}