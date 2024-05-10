import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/data/models/social_media_model.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class InsertSocialMediaUseCase extends BaseUseCase<SocialMediaModel, InsertSocialMediaParameters> {
  final BaseRepository _baseRepository;

  InsertSocialMediaUseCase(this._baseRepository);

  @override
  Future<Either<Failure, SocialMediaModel>> call(InsertSocialMediaParameters parameters) async {
    return await _baseRepository.insertSocialMedia(parameters);
  }
}

class InsertSocialMediaParameters {
  String image;
  String nameAr;
  String nameEn;
  String link;
  bool isAvailable;
  String createdAt;

  InsertSocialMediaParameters({
    required this.image,
    required this.nameAr,
    required this.nameEn,
    required this.link,
    required this.isAvailable,
    required this.createdAt,
  });
}