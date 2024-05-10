import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/data/models/about_app_model.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class GetAboutAppUseCase extends BaseUseCase<AboutAppModel, NoParameters> {
  final BaseRepository _baseRepository;

  GetAboutAppUseCase(this._baseRepository);

  @override
  Future<Either<Failure, AboutAppModel>> call(NoParameters parameters) async {
    return await _baseRepository.getAboutApp();
  }
}