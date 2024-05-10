import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/data/models/main_category_model.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class EditMainCategoryUseCase extends BaseUseCase<MainCategoryModel, EditMainCategoryParameters> {
  final BaseRepository _baseRepository;

  EditMainCategoryUseCase(this._baseRepository);

  @override
  Future<Either<Failure, MainCategoryModel>> call(EditMainCategoryParameters parameters) async {
    return await _baseRepository.editMainCategory(parameters);
  }
}

class EditMainCategoryParameters {
  int mainCategoryId;
  String nameAr;
  String nameEn;
  String image;
  int customOrder;

  EditMainCategoryParameters({
    required this.mainCategoryId,
    required this.nameAr,
    required this.nameEn,
    required this.image,
    required this.customOrder,
  });
}