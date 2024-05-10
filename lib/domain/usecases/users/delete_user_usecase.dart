import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class DeleteUserUseCase extends BaseUseCase<void, DeleteUserParameters> {
  final BaseRepository _baseRepository;

  DeleteUserUseCase(this._baseRepository);

  @override
  Future<Either<Failure, void>> call(DeleteUserParameters parameters) async {
    return await _baseRepository.deleteUser(parameters);
  }
}

class DeleteUserParameters {
  int userId;

  DeleteUserParameters({
    required this.userId,
  });
}