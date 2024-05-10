import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class DeletePhoneNumberRequestUseCase extends BaseUseCase<void, DeletePhoneNumberRequestParameters> {
  final BaseRepository _baseRepository;

  DeletePhoneNumberRequestUseCase(this._baseRepository);

  @override
  Future<Either<Failure, void>> call(DeletePhoneNumberRequestParameters parameters) async {
    return await _baseRepository.deletePhoneNumberRequest(parameters);
  }
}

class DeletePhoneNumberRequestParameters {
  int phoneNumberRequestId;

  DeletePhoneNumberRequestParameters({
    required this.phoneNumberRequestId,
  });
}