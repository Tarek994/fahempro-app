import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/data/models/admin_notification_model.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class InsertAdminNotificationUseCase extends BaseUseCase<AdminNotificationModel, InsertAdminNotificationParameters> {
  final BaseRepository _baseRepository;

  InsertAdminNotificationUseCase(this._baseRepository);

  @override
  Future<Either<Failure, AdminNotificationModel>> call(InsertAdminNotificationParameters parameters) async {
    return await _baseRepository.insertAdminNotification(parameters);
  }
}

class InsertAdminNotificationParameters {
  String title;
  String body;
  bool isViewed;
  String createdAt;

  InsertAdminNotificationParameters({
    required this.title,
    required this.body,
    required this.isViewed,
    required this.createdAt,
  });
}