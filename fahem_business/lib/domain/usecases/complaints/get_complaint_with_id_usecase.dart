import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/data/models/complaint_model.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class GetComplaintWithIdUseCase extends BaseUseCase<ComplaintModel, GetComplaintWithIdParameters> {
  final BaseRepository _baseRepository;

  GetComplaintWithIdUseCase(this._baseRepository);

  @override
  Future<Either<Failure, ComplaintModel>> call(GetComplaintWithIdParameters parameters) async {
    return await _baseRepository.getComplaintWithId(parameters);
  }
}

class GetComplaintWithIdParameters {
  int complaintId;

  GetComplaintWithIdParameters({
    required this.complaintId,
  });
}