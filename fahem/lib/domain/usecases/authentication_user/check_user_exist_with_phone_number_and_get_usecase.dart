import 'package:fahem/data/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class CheckUserExistWithPhoneNumberAndGetUseCase extends BaseUseCase<UserModel?, CheckUserExistWithPhoneNumberAndGetParameters> {
  final BaseRepository _baseRepository;

  CheckUserExistWithPhoneNumberAndGetUseCase(this._baseRepository);

  @override
  Future<Either<Failure, UserModel?>> call(CheckUserExistWithPhoneNumberAndGetParameters parameters) async {
    return await _baseRepository.checkUserExistWithPhoneNumberAndGet(parameters);
  }
}

class CheckUserExistWithPhoneNumberAndGetParameters {
  final String phoneNumber;

  CheckUserExistWithPhoneNumberAndGetParameters({required this.phoneNumber});
}