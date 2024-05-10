import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/data/models/video_model.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class EditVideoUseCase extends BaseUseCase<VideoModel, EditVideoParameters> {
  final BaseRepository _baseRepository;

  EditVideoUseCase(this._baseRepository);

  @override
  Future<Either<Failure, VideoModel>> call(EditVideoParameters parameters) async {
    return await _baseRepository.editVideo(parameters);
  }
}

class EditVideoParameters {
  int videoId;
  int playlistId;
  String titleAr;
  String titleEn;
  String link;
  String aboutVideoAr;
  String aboutVideoEn;

  EditVideoParameters({
    required this.videoId,
    required this.playlistId,
    required this.titleAr,
    required this.titleEn,
    required this.link,
    required this.aboutVideoAr,
    required this.aboutVideoEn,
  });
}