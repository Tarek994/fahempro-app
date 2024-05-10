import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class CheckAccountEmailToResetPasswordUseCase extends BaseUseCase<bool, CheckAccountEmailToResetPasswordParameters> {
  final BaseRepository _baseRepository;

  CheckAccountEmailToResetPasswordUseCase(this._baseRepository);

  @override
  Future<Either<Failure, bool>> call(CheckAccountEmailToResetPasswordParameters parameters) async {
    return await _baseRepository.checkAccountEmailToResetPassword(parameters);
  }
}

class CheckAccountEmailToResetPasswordParameters {
  String emailAddress;

  CheckAccountEmailToResetPasswordParameters({
    required this.emailAddress,
  });
}