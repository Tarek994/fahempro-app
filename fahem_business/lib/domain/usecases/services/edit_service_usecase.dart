import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/data/models/service_model.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class EditServiceUseCase extends BaseUseCase<ServiceModel, EditServiceParameters> {
  final BaseRepository _baseRepository;

  EditServiceUseCase(this._baseRepository);

  @override
  Future<Either<Failure, ServiceModel>> call(EditServiceParameters parameters) async {
    return await _baseRepository.editService(parameters);
  }
}

class EditServiceParameters {
  int serviceId;
  int mainCategoryId;
  String nameAr;
  String nameEn;
  String serviceInfoAr;
  String serviceInfoEn;
  String serviceImage;
  String additionalImage;
  bool availableForAccount;
  bool serviceProviderCanSubscribe;
  int customOrder;

  EditServiceParameters({
    required this.serviceId,
    required this.mainCategoryId,
    required this.nameAr,
    required this.nameEn,
    required this.serviceInfoAr,
    required this.serviceInfoEn,
    required this.serviceImage,
    required this.additionalImage,
    required this.availableForAccount,
    required this.serviceProviderCanSubscribe,
    required this.customOrder,
  });
}