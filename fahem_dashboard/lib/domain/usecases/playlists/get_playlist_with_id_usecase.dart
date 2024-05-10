import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/data/models/playlist_model.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class GetPlaylistWithIdUseCase extends BaseUseCase<PlaylistModel, GetPlaylistWithIdParameters> {
  final BaseRepository _baseRepository;

  GetPlaylistWithIdUseCase(this._baseRepository);

  @override
  Future<Either<Failure, PlaylistModel>> call(GetPlaylistWithIdParameters parameters) async {
    return await _baseRepository.getPlaylistWithId(parameters);
  }
}

class GetPlaylistWithIdParameters {
  int playlistId;

  GetPlaylistWithIdParameters({
    required this.playlistId,
  });
}