import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/data/response/employment_applications_response.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class GetEmploymentApplicationsUseCase extends BaseUseCase<EmploymentApplicationsResponse, GetEmploymentApplicationsParameters> {
  final BaseRepository _baseRepository;

  GetEmploymentApplicationsUseCase(this._baseRepository);

  @override
  Future<Either<Failure, EmploymentApplicationsResponse>> call(GetEmploymentApplicationsParameters parameters) async {
    return await _baseRepository.getEmploymentApplications(parameters);
  }
}

class GetEmploymentApplicationsParameters {
  bool? isPaginated;
  int? limit;
  int? page;
  String? searchText;
  OrderByType? orderBy;
  String? filtersMap;

  GetEmploymentApplicationsParameters({
    this.isPaginated,
    this.limit,
    this.page,
    this.searchText,
    this.orderBy,
    this.filtersMap,
  });
}