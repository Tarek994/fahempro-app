import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class DeleteSocialMediaUseCase extends BaseUseCase<void, DeleteSocialMediaParameters> {
  final BaseRepository _baseRepository;

  DeleteSocialMediaUseCase(this._baseRepository);

  @override
  Future<Either<Failure, void>> call(DeleteSocialMediaParameters parameters) async {
    return await _baseRepository.deleteSocialMedia(parameters);
  }
}

class DeleteSocialMediaParameters {
  int socialMediaId;

  DeleteSocialMediaParameters({
    required this.socialMediaId,
  });
}