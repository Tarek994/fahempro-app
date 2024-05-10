import 'package:fahem_business/core/utilities/enums.dart';

class SliderModel {
  late final int sliderId;
  late final String image;
  late final SliderTarget sliderTarget;
  late final String? value;
  late final String createdAt;

  SliderModel({
    required this.sliderId,
    required this.image,
    required this.sliderTarget,
    required this.value,
    required this.createdAt,
  });

  SliderModel.fromJson(Map<String, dynamic> json) {
    sliderId = int.parse(json['sliderId'].toString());
    image = json['image'];
    sliderTarget = SliderTarget.values.firstWhere((element) => element.name == json['sliderTarget']);
    value = json['value'];
    createdAt = json['createdAt'];
  }
}