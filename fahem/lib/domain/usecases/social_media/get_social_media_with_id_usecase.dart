import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/data/models/social_media_model.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class GetSocialMediaWithIdUseCase extends BaseUseCase<SocialMediaModel, GetSocialMediaWithIdParameters> {
  final BaseRepository _baseRepository;

  GetSocialMediaWithIdUseCase(this._baseRepository);

  @override
  Future<Either<Failure, SocialMediaModel>> call(GetSocialMediaWithIdParameters parameters) async {
    return await _baseRepository.getSocialMediaWithId(parameters);
  }
}

class GetSocialMediaWithIdParameters {
  int socialMediaId;

  GetSocialMediaWithIdParameters({
    required this.socialMediaId,
  });
}