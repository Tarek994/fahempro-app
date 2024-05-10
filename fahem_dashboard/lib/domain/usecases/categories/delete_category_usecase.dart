import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class DeleteCategoryUseCase extends BaseUseCase<void, DeleteCategoryParameters> {
  final BaseRepository _baseRepository;

  DeleteCategoryUseCase(this._baseRepository);

  @override
  Future<Either<Failure, void>> call(DeleteCategoryParameters parameters) async {
    return await _baseRepository.deleteCategory(parameters);
  }
}

class DeleteCategoryParameters {
  int categoryId;

  DeleteCategoryParameters({
    required this.categoryId,
  });
}