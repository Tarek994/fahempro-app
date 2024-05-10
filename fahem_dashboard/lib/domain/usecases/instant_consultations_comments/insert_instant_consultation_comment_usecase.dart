import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/data/models/instant_consultation_comment_model.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class InsertInstantConsultationCommentUseCase extends BaseUseCase<InstantConsultationCommentModel, InsertInstantConsultationCommentParameters> {
  final BaseRepository _baseRepository;

  InsertInstantConsultationCommentUseCase(this._baseRepository);

  @override
  Future<Either<Failure, InstantConsultationCommentModel>> call(InsertInstantConsultationCommentParameters parameters) async {
    return await _baseRepository.insertInstantConsultationComment(parameters);
  }
}

class InsertInstantConsultationCommentParameters {
  int instantConsultationId;
  int accountId;
  String comment;
  CommentStatus commentStatus;
  String? reasonOfReject;
  String createdAt;

  InsertInstantConsultationCommentParameters({
    required this.instantConsultationId,
    required this.accountId,
    required this.comment,
    required this.commentStatus,
    required this.reasonOfReject,
    required this.createdAt,
  });
}