import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/data/models/job_model.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class InsertJobUseCase extends BaseUseCase<JobModel, InsertJobParameters> {
  final BaseRepository _baseRepository;

  InsertJobUseCase(this._baseRepository);

  @override
  Future<Either<Failure, JobModel>> call(InsertJobParameters parameters) async {
    return await _baseRepository.insertJob(parameters);
  }
}

class InsertJobParameters {
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
  String createdAt;

  InsertJobParameters({
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
    required this.createdAt,
  });
}