import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/data/models/employment_application_model.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class EditEmploymentApplicationUseCase extends BaseUseCase<EmploymentApplicationModel, EditEmploymentApplicationParameters> {
  final BaseRepository _baseRepository;

  EditEmploymentApplicationUseCase(this._baseRepository);

  @override
  Future<Either<Failure, EmploymentApplicationModel>> call(EditEmploymentApplicationParameters parameters) async {
    return await _baseRepository.editEmploymentApplication(parameters);
  }
}

class EditEmploymentApplicationParameters {
  int employmentApplicationId;
  int accountId;
  int userId;
  int jobId;
  String cv;

  EditEmploymentApplicationParameters({
    required this.employmentApplicationId,
    required this.accountId,
    required this.userId,
    required this.jobId,
    required this.cv,
  });
}