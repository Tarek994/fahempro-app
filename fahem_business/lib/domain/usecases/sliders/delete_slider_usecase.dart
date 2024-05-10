import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class DeleteSliderUseCase extends BaseUseCase<void, DeleteSliderParameters> {
  final BaseRepository _baseRepository;

  DeleteSliderUseCase(this._baseRepository);

  @override
  Future<Either<Failure, void>> call(DeleteSliderParameters parameters) async {
    return await _baseRepository.deleteSlider(parameters);
  }
}

class DeleteSliderParameters {
  int sliderId;

  DeleteSliderParameters({
    required this.sliderId,
  });
}