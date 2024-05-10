import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class DeleteSecretConsultationUseCase extends BaseUseCase<void, DeleteSecretConsultationParameters> {
  final BaseRepository _baseRepository;

  DeleteSecretConsultationUseCase(this._baseRepository);

  @override
  Future<Either<Failure, void>> call(DeleteSecretConsultationParameters parameters) async {
    return await _baseRepository.deleteSecretConsultation(parameters);
  }
}

class DeleteSecretConsultationParameters {
  int secretConsultationId;

  DeleteSecretConsultationParameters({
    required this.secretConsultationId,
  });
}