import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class DeleteAdminUseCase extends BaseUseCase<void, DeleteAdminParameters> {
  final BaseRepository _baseRepository;

  DeleteAdminUseCase(this._baseRepository);

  @override
  Future<Either<Failure, void>> call(DeleteAdminParameters parameters) async {
    return await _baseRepository.deleteAdmin(parameters);
  }
}

class DeleteAdminParameters {
  int adminId;

  DeleteAdminParameters({
    required this.adminId,
  });
}