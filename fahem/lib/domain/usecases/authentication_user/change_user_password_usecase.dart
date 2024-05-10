import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/data/models/user_model.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class ChangeUserPasswordUseCase extends BaseUseCase<UserModel, ChangeUserPasswordParameters> {
  final BaseRepository _baseRepository;

  ChangeUserPasswordUseCase(this._baseRepository);

  @override
  Future<Either<Failure, UserModel>> call(ChangeUserPasswordParameters parameters) async {
    return await _baseRepository.changeUserPassword(parameters);
  }
}

class ChangeUserPasswordParameters {
  int userId;
  String oldPassword;
  String newPassword;

  ChangeUserPasswordParameters({
    required this.userId,
    required this.oldPassword,
    required this.newPassword,
  });
}