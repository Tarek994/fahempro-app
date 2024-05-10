import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class DeleteUserAccountUseCase extends BaseUseCase<void, DeleteUserAccountParameters> {
  final BaseRepository _baseRepository;

  DeleteUserAccountUseCase(this._baseRepository);

  @override
  Future<Either<Failure, void>> call(DeleteUserAccountParameters parameters) async {
    return await _baseRepository.deleteUserAccount(parameters);
  }
}

class DeleteUserAccountParameters {
  int userId;

  DeleteUserAccountParameters({
    required this.userId,
  });
}