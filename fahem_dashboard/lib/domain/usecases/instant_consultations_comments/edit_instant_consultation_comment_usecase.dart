import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/data/models/instant_consultation_comment_model.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class EditInstantConsultationCommentUseCase extends BaseUseCase<InstantConsultationCommentModel, EditInstantConsultationCommentParameters> {
  final BaseRepository _baseRepository;

  EditInstantConsultationCommentUseCase(this._baseRepository);

  @override
  Future<Either<Failure, InstantConsultationCommentModel>> call(EditInstantConsultationCommentParameters parameters) async {
    return await _baseRepository.editInstantConsultationComment(parameters);
  }
}

class EditInstantConsultationCommentParameters {
  int instantConsultationCommentId;
  int instantConsultationId;
  int accountId;
  String comment;
  CommentStatus commentStatus;
  String? reasonOfReject;

  EditInstantConsultationCommentParameters({
    required this.instantConsultationCommentId,
    required this.instantConsultationId,
    required this.accountId,
    required this.comment,
    required this.commentStatus,
    required this.reasonOfReject,
  });
}