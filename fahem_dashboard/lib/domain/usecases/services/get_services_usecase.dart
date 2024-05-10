import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/data/response/services_response.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class GetServicesUseCase extends BaseUseCase<ServicesResponse, GetServicesParameters> {
  final BaseRepository _baseRepository;

  GetServicesUseCase(this._baseRepository);

  @override
  Future<Either<Failure, ServicesResponse>> call(GetServicesParameters parameters) async {
    return await _baseRepository.getServices(parameters);
  }
}

class GetServicesParameters {
  bool? isPaginated;
  int? limit;
  int? page;
  String? searchText;
  OrderByType? orderBy;
  String? filtersMap;

  GetServicesParameters({
    this.isPaginated,
    this.limit,
    this.page,
    this.searchText,
    this.orderBy,
    this.filtersMap,
  });
}