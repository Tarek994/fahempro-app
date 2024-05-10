import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class DeleteComplaintUseCase extends BaseUseCase<void, DeleteComplaintParameters> {
  final BaseRepository _baseRepository;

  DeleteComplaintUseCase(this._baseRepository);

  @override
  Future<Either<Failure, void>> call(DeleteComplaintParameters parameters) async {
    return await _baseRepository.deleteComplaint(parameters);
  }
}

class DeleteComplaintParameters {
  int complaintId;

  DeleteComplaintParameters({
    required this.complaintId,
  });
}