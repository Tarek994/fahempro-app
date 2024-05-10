import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/data/models/social_media_model.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class EditSocialMediaUseCase extends BaseUseCase<SocialMediaModel, EditSocialMediaParameters> {
  final BaseRepository _baseRepository;

  EditSocialMediaUseCase(this._baseRepository);

  @override
  Future<Either<Failure, SocialMediaModel>> call(EditSocialMediaParameters parameters) async {
    return await _baseRepository.editSocialMedia(parameters);
  }
}

class EditSocialMediaParameters {
  int socialMediaId;
  String image;
  String nameAr;
  String nameEn;
  String link;
  bool isAvailable;

  EditSocialMediaParameters({
    required this.socialMediaId,
    required this.image,
    required this.nameAr,
    required this.nameEn,
    required this.link,
    required this.isAvailable,
  });
}