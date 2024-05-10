import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/data/models/service_description_model.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class EditServiceDescriptionUseCase extends BaseUseCase<ServiceDescriptionModel, EditServiceDescriptionParameters> {
  final BaseRepository _baseRepository;

  EditServiceDescriptionUseCase(this._baseRepository);

  @override
  Future<Either<Failure, ServiceDescriptionModel>> call(EditServiceDescriptionParameters parameters) async {
    return await _baseRepository.editServiceDescription(parameters);
  }
}

class EditServiceDescriptionParameters {
  String textAr;
  String textEn;

  EditServiceDescriptionParameters({
    required this.textAr,
    required this.textEn,
  });
}