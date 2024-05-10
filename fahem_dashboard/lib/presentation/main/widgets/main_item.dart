import 'package:fahem_dashboard/core/resources/colors_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/core/utilities/my_providers.dart';
import 'package:fahem_dashboard/data/models/static/main_model.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/hover.dart';
import 'package:flutter/material.dart';

class MainItem extends StatelessWidget {
  final MainModel mainModel;

  const MainItem({
    super.key,
    required this.mainModel,
  });

  @override
  Widget build(BuildContext context) {
    return Hover(
      color: ColorsManager.grey100,
      paddingValue: SizeManager.s0,
      onTap: () {
        if(mainModel.onTap != null) {
          mainModel.onTap!(context);
        }
        else {
          Methods.routeTo(context, mainModel.route!, arguments: mainModel.arguments);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(SizeManager.s10),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Container(
                constraints: const BoxConstraints(
                  maxWidth: SizeManager.s60,
                  maxHeight: SizeManager.s60,
                ),
                child: Image.asset(mainModel.image),
              ),
              const SizedBox(height: SizeManager.s15),
              FittedBox(
                child: Text(
                  MyProviders.appProvider.isEnglish ? mainModel.textEn : mainModel.textAr,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}