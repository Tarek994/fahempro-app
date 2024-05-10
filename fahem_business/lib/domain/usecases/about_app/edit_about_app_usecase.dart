import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/data/models/about_app_model.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class EditAboutAppUseCase extends BaseUseCase<AboutAppModel, EditAboutAppParameters> {
  final BaseRepository _baseRepository;

  EditAboutAppUseCase(this._baseRepository);

  @override
  Future<Either<Failure, AboutAppModel>> call(EditAboutAppParameters parameters) async {
    return await _baseRepository.editAboutApp(parameters);
  }
}

class EditAboutAppParameters {
  String textAr;
  String textEn;

  EditAboutAppParameters({
    required this.textAr,
    required this.textEn,
  });
}