import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/data/response/videos_response.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class GetVideosUseCase extends BaseUseCase<VideosResponse, GetVideosParameters> {
  final BaseRepository _baseRepository;

  GetVideosUseCase(this._baseRepository);

  @override
  Future<Either<Failure, VideosResponse>> call(GetVideosParameters parameters) async {
    return await _baseRepository.getVideos(parameters);
  }
}

class GetVideosParameters {
  bool? isPaginated;
  int? limit;
  int? page;
  String? searchText;
  OrderByType? orderBy;
  String? filtersMap;

  GetVideosParameters({
    this.isPaginated,
    this.limit,
    this.page,
    this.searchText,
    this.orderBy,
    this.filtersMap,
  });
}