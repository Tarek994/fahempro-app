import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fahem/core/resources/assets_manager.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';

class MaintenanceScreen extends StatelessWidget {

  const MaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Methods.getDirection(),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: SizeManager.s0,
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(SizeManager.s16),
            child: Column(
              children: [
                SvgPicture.asset(SvgManager.maintenance, width: SizeManager.s200, height: SizeManager.s300),
                const SizedBox(height: SizeManager.s20),
                Text(
                  Methods.getText(StringsManager.appUnderMaintenance).toTitleCase(),
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: SizeManager.s20, fontWeight: FontWeightManager.bold),
                ),
                const SizedBox(height: SizeManager.s10),
                Text(
                  Methods.getText(StringsManager.maintenanceMsg),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(height: SizeManager.s1_8),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}