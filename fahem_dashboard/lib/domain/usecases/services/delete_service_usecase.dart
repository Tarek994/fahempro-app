import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class DeleteServiceUseCase extends BaseUseCase<void, DeleteServiceParameters> {
  final BaseRepository _baseRepository;

  DeleteServiceUseCase(this._baseRepository);

  @override
  Future<Either<Failure, void>> call(DeleteServiceParameters parameters) async {
    return await _baseRepository.deleteService(parameters);
  }
}

class DeleteServiceParameters {
  int serviceId;

  DeleteServiceParameters({
    required this.serviceId,
  });
}