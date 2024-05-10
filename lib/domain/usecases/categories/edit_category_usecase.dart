import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/data/models/category_model.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class EditCategoryUseCase extends BaseUseCase<CategoryModel, EditCategoryParameters> {
  final BaseRepository _baseRepository;

  EditCategoryUseCase(this._baseRepository);

  @override
  Future<Either<Failure, CategoryModel>> call(EditCategoryParameters parameters) async {
    return await _baseRepository.editCategory(parameters);
  }
}

class EditCategoryParameters {
  int categoryId;
  int mainCategoryId;
  String nameAr;
  String nameEn;
  String image;
  int customOrder;

  EditCategoryParameters({
    required this.categoryId,
    required this.mainCategoryId,
    required this.nameAr,
    required this.nameEn,
    required this.image,
    required this.customOrder,
  });
}