import 'package:fahem_business/data/models/notification_model.dart';
import 'package:fahem_business/data/models/static/base_model.dart';
import 'package:fahem_business/data/models/static/pagination_model.dart';

class NotificationsResponse {
  late final BaseModel base;
  late final PaginationModel pagination;
  late final List<NotificationModel> notifications;

  NotificationsResponse({
    required this.base,
    required this.pagination,
    required this.notifications,
  });

  NotificationsResponse.fromJson(Map<String, dynamic> json) {
    base = BaseModel.fromJson(json['base']);
    pagination = PaginationModel.fromJson(json['pagination']);
    notifications = List.from(json['notifications']).map((e) => NotificationModel.fromJson(e)).toList();
  }
}