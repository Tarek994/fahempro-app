import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/data/models/video_model.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class GetVideoWithIdUseCase extends BaseUseCase<VideoModel, GetVideoWithIdParameters> {
  final BaseRepository _baseRepository;

  GetVideoWithIdUseCase(this._baseRepository);

  @override
  Future<Either<Failure, VideoModel>> call(GetVideoWithIdParameters parameters) async {
    return await _baseRepository.getVideoWithId(parameters);
  }
}

class GetVideoWithIdParameters {
  int videoId;

  GetVideoWithIdParameters({
    required this.videoId,
  });
}