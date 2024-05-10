import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/data/models/service_model.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class GetServiceWithIdUseCase extends BaseUseCase<ServiceModel, GetServiceWithIdParameters> {
  final BaseRepository _baseRepository;

  GetServiceWithIdUseCase(this._baseRepository);

  @override
  Future<Either<Failure, ServiceModel>> call(GetServiceWithIdParameters parameters) async {
    return await _baseRepository.getServiceWithId(parameters);
  }
}

class GetServiceWithIdParameters {
  int serviceId;

  GetServiceWithIdParameters({
    required this.serviceId,
  });
}