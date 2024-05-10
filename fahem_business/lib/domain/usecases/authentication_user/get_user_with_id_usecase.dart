import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/data/models/user_model.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class GetUserWithIdUseCase extends BaseUseCase<UserModel, GetUserWithIdParameters> {
  final BaseRepository _baseRepository;

  GetUserWithIdUseCase(this._baseRepository);

  @override
  Future<Either<Failure, UserModel>> call(GetUserWithIdParameters parameters) async {
    return await _baseRepository.getUserWithId(parameters);
  }
}

class GetUserWithIdParameters {
  int userId;

  GetUserWithIdParameters({
    required this.userId,
  });
}