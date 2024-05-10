import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/data/models/main_category_model.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class InsertMainCategoryUseCase extends BaseUseCase<MainCategoryModel, InsertMainCategoryParameters> {
  final BaseRepository _baseRepository;

  InsertMainCategoryUseCase(this._baseRepository);

  @override
  Future<Either<Failure, MainCategoryModel>> call(InsertMainCategoryParameters parameters) async {
    return await _baseRepository.insertMainCategory(parameters);
  }
}

class InsertMainCategoryParameters {
  String nameAr;
  String nameEn;
  String image;
  int customOrder;
  String createdAt;

  InsertMainCategoryParameters({
    required this.nameAr,
    required this.nameEn,
    required this.image,
    required this.customOrder,
    required this.createdAt,
  });
}