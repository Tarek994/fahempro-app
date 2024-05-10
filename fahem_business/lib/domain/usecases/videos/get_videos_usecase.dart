import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/data/response/videos_response.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

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