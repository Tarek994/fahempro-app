import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/data/response/jobs_response.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class GetJobsUseCase extends BaseUseCase<JobsResponse, GetJobsParameters> {
  final BaseRepository _baseRepository;

  GetJobsUseCase(this._baseRepository);

  @override
  Future<Either<Failure, JobsResponse>> call(GetJobsParameters parameters) async {
    return await _baseRepository.getJobs(parameters);
  }
}

class GetJobsParameters {
  bool? isPaginated;
  int? limit;
  int? page;
  String? searchText;
  OrderByType? orderBy;
  String? filtersMap;

  GetJobsParameters({
    this.isPaginated,
    this.limit,
    this.page,
    this.searchText,
    this.orderBy,
    this.filtersMap,
  });
}