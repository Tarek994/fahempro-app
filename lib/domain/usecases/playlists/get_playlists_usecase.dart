import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/data/response/playlists_response.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class GetPlaylistsUseCase extends BaseUseCase<PlaylistsResponse, GetPlaylistsParameters> {
  final BaseRepository _baseRepository;

  GetPlaylistsUseCase(this._baseRepository);

  @override
  Future<Either<Failure, PlaylistsResponse>> call(GetPlaylistsParameters parameters) async {
    return await _baseRepository.getPlaylists(parameters);
  }
}

class GetPlaylistsParameters {
  bool? isPaginated;
  int? limit;
  int? page;
  String? searchText;
  OrderByType? orderBy;
  String? filtersMap;

  GetPlaylistsParameters({
    this.isPaginated,
    this.limit,
    this.page,
    this.searchText,
    this.orderBy,
    this.filtersMap,
  });
}