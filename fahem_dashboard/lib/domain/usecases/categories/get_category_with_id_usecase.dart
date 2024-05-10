import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/data/models/category_model.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class GetCategoryWithIdUseCase extends BaseUseCase<CategoryModel, GetCategoryWithIdParameters> {
  final BaseRepository _baseRepository;

  GetCategoryWithIdUseCase(this._baseRepository);

  @override
  Future<Either<Failure, CategoryModel>> call(GetCategoryWithIdParameters parameters) async {
    return await _baseRepository.getCategoryWithId(parameters);
  }
}

class GetCategoryWithIdParameters {
  int categoryId;

  GetCategoryWithIdParameters({
    required this.categoryId,
  });
}