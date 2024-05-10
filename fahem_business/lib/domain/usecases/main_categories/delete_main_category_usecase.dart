import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class DeleteMainCategoryUseCase extends BaseUseCase<void, DeleteMainCategoryParameters> {
  final BaseRepository _baseRepository;

  DeleteMainCategoryUseCase(this._baseRepository);

  @override
  Future<Either<Failure, void>> call(DeleteMainCategoryParameters parameters) async {
    return await _baseRepository.deleteMainCategory(parameters);
  }
}

class DeleteMainCategoryParameters {
  int mainCategoryId;

  DeleteMainCategoryParameters({
    required this.mainCategoryId,
  });
}