import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class DeletePlaylistUseCase extends BaseUseCase<void, DeletePlaylistParameters> {
  final BaseRepository _baseRepository;

  DeletePlaylistUseCase(this._baseRepository);

  @override
  Future<Either<Failure, void>> call(DeletePlaylistParameters parameters) async {
    return await _baseRepository.deletePlaylist(parameters);
  }
}

class DeletePlaylistParameters {
  int playlistId;

  DeletePlaylistParameters({
    required this.playlistId,
  });
}