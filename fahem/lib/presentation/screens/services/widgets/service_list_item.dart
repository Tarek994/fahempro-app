import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/presentation/shared/widgets/hover.dart';
import 'package:flutter/material.dart';
import 'package:fahem/data/models/service_model.dart';

class ServiceListItem extends StatelessWidget {
  final ServiceModel serviceModel;
  final int index;

  const ServiceListItem({
    super.key,
    required this.serviceModel,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Hover(
      onTap: () {
        Methods.routeTo(
          context,
          Routes.serviceDetailsScreen,
          arguments: ServiceDetailsArgs(
            service: serviceModel,
            color: index % 2 == 0 ? ColorsManager.lightPrimaryColor : ColorsManager.lightSecondaryColor,
          ),
        );
      },
      color: index % 2 == 0 ? ColorsManager.lightPrimaryColor : ColorsManager.lightSecondaryColor,
      child: Container(
        constraints: const BoxConstraints(
          minHeight: SizeManager.s60,
        ),
        child: Center(
          child: Text(
            MyProviders.appProvider.isEnglish ? serviceModel.nameEn : serviceModel.nameAr,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: ColorsManager.white,
              fontSize: SizeManager.s22,
              fontWeight: FontWeightManager.bold,
            ),
          ),
        ),
      ),
    );
  }
}