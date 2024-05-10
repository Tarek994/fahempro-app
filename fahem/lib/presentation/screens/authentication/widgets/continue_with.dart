import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';

class ContinueWith extends StatelessWidget {

  const ContinueWith({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              width: SizeManager.s35,
              height: SizeManager.s35,
              decoration: const BoxDecoration(
                color: ColorsManager.lightPrimaryColor,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: FaIcon(FontAwesomeIcons.facebookF, color: ColorsManager.white),
              ),
            ),
          ),
          const SizedBox(width: SizeManager.s10),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: SizeManager.s35,
              height: SizeManager.s35,
              decoration: const BoxDecoration(
                color: ColorsManager.lightPrimaryColor,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: FaIcon(FontAwesomeIcons.google, color: ColorsManager.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}