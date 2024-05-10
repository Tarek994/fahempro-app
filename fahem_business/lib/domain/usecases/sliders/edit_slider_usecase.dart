import 'package:dartz/dartz.dart';
import 'package:fahem_business/core/error/failure.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/data/models/slider_model.dart';
import 'package:fahem_business/domain/repository/base_repository.dart';
import 'package:fahem_business/domain/usecases/base/base_usecase.dart';

class EditSliderUseCase extends BaseUseCase<SliderModel, EditSliderParameters> {
  final BaseRepository _baseRepository;

  EditSliderUseCase(this._baseRepository);

  @override
  Future<Either<Failure, SliderModel>> call(EditSliderParameters parameters) async {
    return await _baseRepository.editSlider(parameters);
  }
}

class EditSliderParameters {
  int sliderId;
  String image;
  SliderTarget sliderTarget;
  String? value;

  EditSliderParameters({
    required this.sliderId,
    required this.image,
    required this.sliderTarget,
    required this.value,
  });
}