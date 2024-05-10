import 'package:flutter/material.dart';
import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';

class DontHaveAccount extends StatelessWidget {

  const DontHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          Methods.getText(StringsManager.dontHaveAnAccountYet).toCapitalized(),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        TextButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            // Methods.routeTo(context, Routes.registerScreen);
          },
          style: TextButton.styleFrom(
            visualDensity: const VisualDensity(horizontal: -4),
            padding: const EdgeInsets.symmetric(horizontal: SizeManager.s5),
          ),
          child: Text(
            Methods.getText(StringsManager.newAccount).toUpperCase(),
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ],
    );
  }
}