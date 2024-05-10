import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class SetIsViewedUseCase extends BaseUseCase<bool, SetIsViewedParameters> {
  final BaseRepository _baseRepository;

  SetIsViewedUseCase(this._baseRepository);

  @override
  Future<Either<Failure, bool>> call(SetIsViewedParameters parameters) async {
    return await _baseRepository.setIsViewed(parameters);
  }
}

class SetIsViewedParameters {
  int adminNotificationId;

  SetIsViewedParameters({
    required this.adminNotificationId,
  });
}