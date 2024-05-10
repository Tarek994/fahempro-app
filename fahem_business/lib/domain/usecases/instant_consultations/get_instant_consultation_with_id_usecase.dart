import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/data/models/instant_consultation_model.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class GetInstantConsultationWithIdUseCase extends BaseUseCase<InstantConsultationModel, GetInstantConsultationWithIdParameters> {
  final BaseRepository _baseRepository;

  GetInstantConsultationWithIdUseCase(this._baseRepository);

  @override
  Future<Either<Failure, InstantConsultationModel>> call(GetInstantConsultationWithIdParameters parameters) async {
    return await _baseRepository.getInstantConsultationWithId(parameters);
  }
}

class GetInstantConsultationWithIdParameters {
  int instantConsultationId;

  GetInstantConsultationWithIdParameters({
    required this.instantConsultationId,
  });
}