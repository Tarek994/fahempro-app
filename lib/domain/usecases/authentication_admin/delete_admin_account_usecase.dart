import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class DeleteAdminAccountUseCase extends BaseUseCase<void, DeleteAdminAccountParameters> {
  final BaseRepository _baseRepository;

  DeleteAdminAccountUseCase(this._baseRepository);

  @override
  Future<Either<Failure, void>> call(DeleteAdminAccountParameters parameters) async {
    return await _baseRepository.deleteAdminAccount(parameters);
  }
}

class DeleteAdminAccountParameters {
  int adminId;

  DeleteAdminAccountParameters({
    required this.adminId,
  });
}