import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class DeleteNotificationUseCase extends BaseUseCase<void, DeleteNotificationParameters> {
  final BaseRepository _baseRepository;

  DeleteNotificationUseCase(this._baseRepository);

  @override
  Future<Either<Failure, void>> call(DeleteNotificationParameters parameters) async {
    return await _baseRepository.deleteNotification(parameters);
  }
}

class DeleteNotificationParameters {
  int notificationId;

  DeleteNotificationParameters({
    required this.notificationId,
  });
}