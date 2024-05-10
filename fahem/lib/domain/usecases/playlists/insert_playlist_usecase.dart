import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/data/models/playlist_model.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class InsertPlaylistUseCase extends BaseUseCase<PlaylistModel, InsertPlaylistParameters> {
  final BaseRepository _baseRepository;

  InsertPlaylistUseCase(this._baseRepository);

  @override
  Future<Either<Failure, PlaylistModel>> call(InsertPlaylistParameters parameters) async {
    return await _baseRepository.insertPlaylist(parameters);
  }
}

class InsertPlaylistParameters {
  String image;
  String playlistNameAr;
  String playlistNameEn;
  String createdAt;

  InsertPlaylistParameters({
    required this.image,
    required this.playlistNameAr,
    required this.playlistNameEn,
    required this.createdAt,
  });
}