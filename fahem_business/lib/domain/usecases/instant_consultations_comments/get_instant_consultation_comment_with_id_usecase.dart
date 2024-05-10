import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/data/models/instant_consultation_comment_model.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class GetInstantConsultationCommentWithIdUseCase extends BaseUseCase<InstantConsultationCommentModel, GetInstantConsultationCommentWithIdParameters> {
  final BaseRepository _baseRepository;

  GetInstantConsultationCommentWithIdUseCase(this._baseRepository);

  @override
  Future<Either<Failure, InstantConsultationCommentModel>> call(GetInstantConsultationCommentWithIdParameters parameters) async {
    return await _baseRepository.getInstantConsultationCommentWithId(parameters);
  }
}

class GetInstantConsultationCommentWithIdParameters {
  int instantConsultationCommentId;

  GetInstantConsultationCommentWithIdParameters({
    required this.instantConsultationCommentId,
  });
}