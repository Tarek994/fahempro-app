import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/data/models/video_model.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class InsertVideoUseCase extends BaseUseCase<VideoModel, InsertVideoParameters> {
  final BaseRepository _baseRepository;

  InsertVideoUseCase(this._baseRepository);

  @override
  Future<Either<Failure, VideoModel>> call(InsertVideoParameters parameters) async {
    return await _baseRepository.insertVideo(parameters);
  }
}

class InsertVideoParameters {
  int playlistId;
  String titleAr;
  String titleEn;
  String link;
  String aboutVideoAr;
  String aboutVideoEn;
  String createdAt;

  InsertVideoParameters({
    required this.playlistId,
    required this.titleAr,
    required this.titleEn,
    required this.link,
    required this.aboutVideoAr,
    required this.aboutVideoEn,
    required this.createdAt,
  });
}