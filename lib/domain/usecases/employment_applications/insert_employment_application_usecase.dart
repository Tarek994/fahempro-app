import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/data/models/employment_application_model.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class InsertEmploymentApplicationUseCase extends BaseUseCase<EmploymentApplicationModel, InsertEmploymentApplicationParameters> {
  final BaseRepository _baseRepository;

  InsertEmploymentApplicationUseCase(this._baseRepository);

  @override
  Future<Either<Failure, EmploymentApplicationModel>> call(InsertEmploymentApplicationParameters parameters) async {
    return await _baseRepository.insertEmploymentApplication(parameters);
  }
}

class InsertEmploymentApplicationParameters {
  int accountId;
  int userId;
  int jobId;
  String cv;
  String createdAt;

  InsertEmploymentApplicationParameters({
    required this.accountId,
    required this.userId,
    required this.jobId,
    required this.cv,
    required this.createdAt,
  });
}