import 'package:flutter/material.dart';
import 'package:fahem_business/core/resources/colors_manager.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';

class RequiredTextWidget extends StatelessWidget {

  const RequiredTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topStart,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(SizeManager.s16, SizeManager.s10, SizeManager.s0, SizeManager.s0),
        child: Text(
          Methods.getText(StringsManager.required).toCapitalized(),
          style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsManager.red700),
        ),
      ),
    );
  }
}