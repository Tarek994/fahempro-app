import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class DeleteInstantConsultationCommentUseCase extends BaseUseCase<void, DeleteInstantConsultationCommentParameters> {
  final BaseRepository _baseRepository;

  DeleteInstantConsultationCommentUseCase(this._baseRepository);

  @override
  Future<Either<Failure, void>> call(DeleteInstantConsultationCommentParameters parameters) async {
    return await _baseRepository.deleteInstantConsultationComment(parameters);
  }
}

class DeleteInstantConsultationCommentParameters {
  int instantConsultationCommentId;

  DeleteInstantConsultationCommentParameters({
    required this.instantConsultationCommentId,
  });
}