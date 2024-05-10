import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/data/models/playlist_model.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class EditPlaylistUseCase extends BaseUseCase<PlaylistModel, EditPlaylistParameters> {
  final BaseRepository _baseRepository;

  EditPlaylistUseCase(this._baseRepository);

  @override
  Future<Either<Failure, PlaylistModel>> call(EditPlaylistParameters parameters) async {
    return await _baseRepository.editPlaylist(parameters);
  }
}

class EditPlaylistParameters {
  int playlistId;
  String image;
  String playlistNameAr;
  String playlistNameEn;

  EditPlaylistParameters({
    required this.playlistId,
    required this.image,
    required this.playlistNameAr,
    required this.playlistNameEn,
  });
}