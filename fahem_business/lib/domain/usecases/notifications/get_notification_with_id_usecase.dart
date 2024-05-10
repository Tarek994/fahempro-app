import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/data/models/notification_model.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class GetNotificationWithIdUseCase extends BaseUseCase<NotificationModel, GetNotificationWithIdParameters> {
  final BaseRepository _baseRepository;

  GetNotificationWithIdUseCase(this._baseRepository);

  @override
  Future<Either<Failure, NotificationModel>> call(GetNotificationWithIdParameters parameters) async {
    return await _baseRepository.getNotificationWithId(parameters);
  }
}

class GetNotificationWithIdParameters {
  int notificationId;

  GetNotificationWithIdParameters({
    required this.notificationId,
  });
}