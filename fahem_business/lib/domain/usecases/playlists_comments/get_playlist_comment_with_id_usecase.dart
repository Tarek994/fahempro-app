import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/data/models/playlist_comment_model.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class GetPlaylistCommentWithIdUseCase extends BaseUseCase<PlaylistCommentModel, GetPlaylistCommentWithIdParameters> {
  final BaseRepository _baseRepository;

  GetPlaylistCommentWithIdUseCase(this._baseRepository);

  @override
  Future<Either<Failure, PlaylistCommentModel>> call(GetPlaylistCommentWithIdParameters parameters) async {
    return await _baseRepository.getPlaylistCommentWithId(parameters);
  }
}

class GetPlaylistCommentWithIdParameters {
  int playlistCommentId;

  GetPlaylistCommentWithIdParameters({
    required this.playlistCommentId,
  });
}