import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/data/models/service_description_model.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class GetServiceDescriptionUseCase extends BaseUseCase<ServiceDescriptionModel, NoParameters> {
  final BaseRepository _baseRepository;

  GetServiceDescriptionUseCase(this._baseRepository);

  @override
  Future<Either<Failure, ServiceDescriptionModel>> call(NoParameters parameters) async {
    return await _baseRepository.getServiceDescription();
  }
}