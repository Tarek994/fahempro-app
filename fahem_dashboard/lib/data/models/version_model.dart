import 'package:fahem_dashboard/core/utilities/enums.dart';

class VersionModel {
  late final App app;
  late final String version;
  late final bool isForceUpdate;
  late final bool isClearCache;
  late final bool isMaintenanceNow;
  late final bool inReview;

  VersionModel({
    required this.app,
    required this.version,
    required this.isForceUpdate,
    required this.isClearCache,
    required this.isMaintenanceNow,
    required this.inReview,
  });

  VersionModel.fromJson(Map<String, dynamic> json) {
    app = App.values.firstWhere((element) => element.name == json['app']);
    version = json['version'];
    isForceUpdate = json['isForceUpdate'];
    isClearCache = json['isClearCache'];
    isMaintenanceNow = json['isMaintenanceNow'];
    inReview = json['inReview'];
  }
}