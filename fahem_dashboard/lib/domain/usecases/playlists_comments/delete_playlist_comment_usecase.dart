import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class DeletePlaylistCommentUseCase extends BaseUseCase<void, DeletePlaylistCommentParameters> {
  final BaseRepository _baseRepository;

  DeletePlaylistCommentUseCase(this._baseRepository);

  @override
  Future<Either<Failure, void>> call(DeletePlaylistCommentParameters parameters) async {
    return await _baseRepository.deletePlaylistComment(parameters);
  }
}

class DeletePlaylistCommentParameters {
  int playlistCommentId;

  DeletePlaylistCommentParameters({
    required this.playlistCommentId,
  });
}