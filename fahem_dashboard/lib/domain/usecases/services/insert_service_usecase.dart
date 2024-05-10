import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/data/models/service_model.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class InsertServiceUseCase extends BaseUseCase<ServiceModel, InsertServiceParameters> {
  final BaseRepository _baseRepository;

  InsertServiceUseCase(this._baseRepository);

  @override
  Future<Either<Failure, ServiceModel>> call(InsertServiceParameters parameters) async {
    return await _baseRepository.insertService(parameters);
  }
}

class InsertServiceParameters {
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
  String createdAt;

  InsertServiceParameters({
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
    required this.createdAt,
  });
}