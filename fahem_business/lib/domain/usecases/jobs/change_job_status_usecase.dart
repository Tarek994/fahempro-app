import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/data/models/job_model.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class ChangeJobStatusUseCase extends BaseUseCase<JobModel, ChangeJobStatusParameters> {
  final BaseRepository _baseRepository;

  ChangeJobStatusUseCase(this._baseRepository);

  @override
  Future<Either<Failure, JobModel>> call(ChangeJobStatusParameters parameters) async {
    return await _baseRepository.changeJobStatus(parameters);
  }
}

class ChangeJobStatusParameters {
  int jobId;
  JobStatus jobStatus;
  String? reasonOfReject;

  ChangeJobStatusParameters({
    required this.jobId,
    required this.jobStatus,
    required this.reasonOfReject,
  });
}