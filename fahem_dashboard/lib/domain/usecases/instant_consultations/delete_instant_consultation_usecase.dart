import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class DeleteInstantConsultationUseCase extends BaseUseCase<void, DeleteInstantConsultationParameters> {
  final BaseRepository _baseRepository;

  DeleteInstantConsultationUseCase(this._baseRepository);

  @override
  Future<Either<Failure, void>> call(DeleteInstantConsultationParameters parameters) async {
    return await _baseRepository.deleteInstantConsultation(parameters);
  }
}

class DeleteInstantConsultationParameters {
  int instantConsultationId;

  DeleteInstantConsultationParameters({
    required this.instantConsultationId,
  });
}