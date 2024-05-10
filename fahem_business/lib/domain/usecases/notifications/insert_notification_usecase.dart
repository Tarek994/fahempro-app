import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/data/models/notification_model.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class InsertNotificationUseCase extends BaseUseCase<NotificationModel, InsertNotificationParameters> {
  final BaseRepository _baseRepository;

  InsertNotificationUseCase(this._baseRepository);

  @override
  Future<Either<Failure, NotificationModel>> call(InsertNotificationParameters parameters) async {
    return await _baseRepository.insertNotification(parameters);
  }
}

class InsertNotificationParameters {
  int? userId;
  int? accountId;
  NotificationToApp notificationToApp;
  NotificationTo notificationTo;
  String title;
  String body;
  String createdAt;

  InsertNotificationParameters({
    required this.userId,
    required this.accountId,
    required this.notificationToApp,
    required this.notificationTo,
    required this.title,
    required this.body,
    required this.createdAt,
  });
}