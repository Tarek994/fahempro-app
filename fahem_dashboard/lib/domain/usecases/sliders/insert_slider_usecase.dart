import 'package:dartz/dartz.dart';
import 'package:fahem_dashboard/core/error/failure.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/data/models/slider_model.dart';
import 'package:fahem_dashboard/domain/repository/base_repository.dart';
import 'package:fahem_dashboard/domain/usecases/base/base_usecase.dart';

class InsertSliderUseCase extends BaseUseCase<SliderModel, InsertSliderParameters> {
  final BaseRepository _baseRepository;

  InsertSliderUseCase(this._baseRepository);

  @override
  Future<Either<Failure, SliderModel>> call(InsertSliderParameters parameters) async {
    return await _baseRepository.insertSlider(parameters);
  }
}

class InsertSliderParameters {
  String image;
  SliderTarget sliderTarget;
  String? value;
  String createdAt;

  InsertSliderParameters({
    required this.image,
    required this.sliderTarget,
    required this.value,
    required this.createdAt,
  });
}