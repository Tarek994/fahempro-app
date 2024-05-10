import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/data/models/secret_consultation_model.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class GetSecretConsultationWithIdUseCase extends BaseUseCase<SecretConsultationModel, GetSecretConsultationWithIdParameters> {
  final BaseRepository _baseRepository;

  GetSecretConsultationWithIdUseCase(this._baseRepository);

  @override
  Future<Either<Failure, SecretConsultationModel>> call(GetSecretConsultationWithIdParameters parameters) async {
    return await _baseRepository.getSecretConsultationWithId(parameters);
  }
}

class GetSecretConsultationWithIdParameters {
  int secretConsultationId;

  GetSecretConsultationWithIdParameters({
    required this.secretConsultationId,
  });
}