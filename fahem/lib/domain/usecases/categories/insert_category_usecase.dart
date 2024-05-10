import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/data/models/category_model.dart';
import 'package:fahem/domain/repository/base_repository.dart';
import 'package:fahem/domain/usecases/base/base_usecase.dart';

class InsertCategoryUseCase extends BaseUseCase<CategoryModel, InsertCategoryParameters> {
  final BaseRepository _baseRepository;

  InsertCategoryUseCase(this._baseRepository);

  @override
  Future<Either<Failure, CategoryModel>> call(InsertCategoryParameters parameters) async {
    return await _baseRepository.insertCategory(parameters);
  }
}

class InsertCategoryParameters {
  int mainCategoryId;
  String nameAr;
  String nameEn;
  String image;
  int customOrder;
  String createdAt;

  InsertCategoryParameters({
    required this.mainCategoryId,
    required this.nameAr,
    required this.nameEn,
    required this.image,
    required this.customOrder,
    required this.createdAt,
  });
}