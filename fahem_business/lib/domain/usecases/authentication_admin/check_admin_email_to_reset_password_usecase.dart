import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class CheckAdminEmailToResetPasswordUseCase extends BaseUseCase<bool, CheckAdminEmailToResetPasswordParameters> {
  final BaseRepository _baseRepository;

  CheckAdminEmailToResetPasswordUseCase(this._baseRepository);

  @override
  Future<Either<Failure, bool>> call(CheckAdminEmailToResetPasswordParameters parameters) async {
    return await _baseRepository.checkAdminEmailToResetPassword(parameters);
  }
}

class CheckAdminEmailToResetPasswordParameters {
  String emailAddress;

  CheckAdminEmailToResetPasswordParameters({
    required this.emailAddress,
  });
}