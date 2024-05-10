import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/data/models/job_model.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class IncrementJobViewsUseCase extends BaseUseCase<JobModel, IncrementJobViewsParameters> {
  final BaseRepository _baseRepository;

  IncrementJobViewsUseCase(this._baseRepository);

  @override
  Future<Either<Failure, JobModel>> call(IncrementJobViewsParameters parameters) async {
    return await _baseRepository.incrementJobViews(parameters);
  }
}

class IncrementJobViewsParameters {
  int jobId;

  IncrementJobViewsParameters({
    required this.jobId,
  });
}