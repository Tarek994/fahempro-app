import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/data/models/slider_model.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class GetSliderWithIdUseCase extends BaseUseCase<SliderModel, GetSliderWithIdParameters> {
  final BaseRepository _baseRepository;

  GetSliderWithIdUseCase(this._baseRepository);

  @override
  Future<Either<Failure, SliderModel>> call(GetSliderWithIdParameters parameters) async {
    return await _baseRepository.getSliderWithId(parameters);
  }
}

class GetSliderWithIdParameters {
  int sliderId;

  GetSliderWithIdParameters({
    required this.sliderId,
  });
}