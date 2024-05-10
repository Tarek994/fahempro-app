import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/data/models/job_model.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class EditJobUseCase extends BaseUseCase<JobModel, EditJobParameters> {
  final BaseRepository _baseRepository;

  EditJobUseCase(this._baseRepository);

  @override
  Future<Either<Failure, JobModel>> call(EditJobParameters parameters) async {
    return await _baseRepository.editJob(parameters);
  }
}

class EditJobParameters {
  int jobId;
  int accountId;
  String image;
  String jobTitle;
  String companyName;
  String aboutCompany;
  int minSalary;
  int maxSalary;
  String jobLocation;
  List<String> features;
  String details;
  JobStatus jobStatus;
  String? reasonOfReject;
  bool isAvailable;

  EditJobParameters({
    required this.jobId,
    required this.accountId,
    required this.image,
    required this.jobTitle,
    required this.companyName,
    required this.aboutCompany,
    required this.minSalary,
    required this.maxSalary,
    required this.jobLocation,
    required this.features,
    required this.details,
    required this.jobStatus,
    required this.reasonOfReject,
    required this.isAvailable,
  });
}