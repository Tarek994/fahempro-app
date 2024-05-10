import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/data/models/playlist_comment_model.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class InsertPlaylistCommentUseCase extends BaseUseCase<PlaylistCommentModel, InsertPlaylistCommentParameters> {
  final BaseRepository _baseRepository;

  InsertPlaylistCommentUseCase(this._baseRepository);

  @override
  Future<Either<Failure, PlaylistCommentModel>> call(InsertPlaylistCommentParameters parameters) async {
    return await _baseRepository.insertPlaylistComment(parameters);
  }
}

class InsertPlaylistCommentParameters {
  int playlistId;
  int userId;
  String comment;
  String createdAt;

  InsertPlaylistCommentParameters({
    required this.playlistId,
    required this.userId,
    required this.comment,
    required this.createdAt,
  });
}