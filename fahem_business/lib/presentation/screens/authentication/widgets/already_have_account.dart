import 'package:flutter/material.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';

class AlreadyHaveAccount extends StatelessWidget {

  const AlreadyHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          Methods.getText(StringsManager.alreadyHaveAnAccount).toCapitalized(),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        TextButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            Navigator.pop(context);
          },
          style: TextButton.styleFrom(
            visualDensity: const VisualDensity(horizontal: -4),
            padding: const EdgeInsets.symmetric(horizontal: SizeManager.s5),
          ),
          child: Text(
            Methods.getText(StringsManager.login).toUpperCase(),
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ],
    );
  }
}