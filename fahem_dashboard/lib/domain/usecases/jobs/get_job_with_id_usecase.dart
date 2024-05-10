import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/data/models/job_model.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class GetJobWithIdUseCase extends BaseUseCase<JobModel, GetJobWithIdParameters> {
  final BaseRepository _baseRepository;

  GetJobWithIdUseCase(this._baseRepository);

  @override
  Future<Either<Failure, JobModel>> call(GetJobWithIdParameters parameters) async {
    return await _baseRepository.getJobWithId(parameters);
  }
}

class GetJobWithIdParameters {
  int jobId;

  GetJobWithIdParameters({
    required this.jobId,
  });
}