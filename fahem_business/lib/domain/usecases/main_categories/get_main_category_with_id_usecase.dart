import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/data/models/main_category_model.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class GetMainCategoryWithIdUseCase extends BaseUseCase<MainCategoryModel, GetMainCategoryWithIdParameters> {
  final BaseRepository _baseRepository;

  GetMainCategoryWithIdUseCase(this._baseRepository);

  @override
  Future<Either<Failure, MainCategoryModel>> call(GetMainCategoryWithIdParameters parameters) async {
    return await _baseRepository.getMainCategoryWithId(parameters);
  }
}

class GetMainCategoryWithIdParameters {
  int mainCategoryId;

  GetMainCategoryWithIdParameters({
    required this.mainCategoryId,
  });
}