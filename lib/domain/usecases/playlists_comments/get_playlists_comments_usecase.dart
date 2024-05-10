import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/data/response/playlists_comments_response.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class GetPlaylistsCommentsUseCase extends BaseUseCase<PlaylistsCommentsResponse, GetPlaylistsCommentsParameters> {
  final BaseRepository _baseRepository;

  GetPlaylistsCommentsUseCase(this._baseRepository);

  @override
  Future<Either<Failure, PlaylistsCommentsResponse>> call(GetPlaylistsCommentsParameters parameters) async {
    return await _baseRepository.getPlaylistsComments(parameters);
  }
}

class GetPlaylistsCommentsParameters {
  bool? isPaginated;
  int? limit;
  int? page;
  String? searchText;
  OrderByType? orderBy;
  String? filtersMap;

  GetPlaylistsCommentsParameters({
    this.isPaginated,
    this.limit,
    this.page,
    this.searchText,
    this.orderBy,
    this.filtersMap,
  });
}