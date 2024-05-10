import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class DeleteAdminNotificationUseCase extends BaseUseCase<void, DeleteAdminNotificationParameters> {
  final BaseRepository _baseRepository;

  DeleteAdminNotificationUseCase(this._baseRepository);

  @override
  Future<Either<Failure, void>> call(DeleteAdminNotificationParameters parameters) async {
    return await _baseRepository.deleteAdminNotification(parameters);
  }
}

class DeleteAdminNotificationParameters {
  int adminNotificationId;

  DeleteAdminNotificationParameters({
    required this.adminNotificationId,
  });
}