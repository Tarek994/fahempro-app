import 'package:flutter/material.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/methods.dart';

class OrWidget extends StatelessWidget {

  const OrWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        const SizedBox(width: SizeManager.s5),
        Text(
          Methods.getText(StringsManager.or).toUpperCase(),
        ),
        const SizedBox(width: SizeManager.s5),
        const Expanded(child: Divider()),
      ],
    );
  }
}