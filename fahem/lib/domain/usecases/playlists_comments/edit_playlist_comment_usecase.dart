import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/data/models/playlist_comment_model.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class EditPlaylistCommentUseCase extends BaseUseCase<PlaylistCommentModel, EditPlaylistCommentParameters> {
  final BaseRepository _baseRepository;

  EditPlaylistCommentUseCase(this._baseRepository);

  @override
  Future<Either<Failure, PlaylistCommentModel>> call(EditPlaylistCommentParameters parameters) async {
    return await _baseRepository.editPlaylistComment(parameters);
  }
}

class EditPlaylistCommentParameters {
  late final int playlistCommentId;
  late final int playlistId;
  late final int userId;
  late final String comment;

  EditPlaylistCommentParameters({
    required this.playlistCommentId,
    required this.playlistId,
    required this.userId,
    required this.comment,
  });
}