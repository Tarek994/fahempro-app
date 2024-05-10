import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class CheckUserEmailToResetPasswordUseCase extends BaseUseCase<bool, CheckUserEmailToResetPasswordParameters> {
  final BaseRepository _baseRepository;

  CheckUserEmailToResetPasswordUseCase(this._baseRepository);

  @override
  Future<Either<Failure, bool>> call(CheckUserEmailToResetPasswordParameters parameters) async {
    return await _baseRepository.checkUserEmailToResetPassword(parameters);
  }
}

class CheckUserEmailToResetPasswordParameters {
  String emailAddress;

  CheckUserEmailToResetPasswordParameters({
    required this.emailAddress,
  });
}