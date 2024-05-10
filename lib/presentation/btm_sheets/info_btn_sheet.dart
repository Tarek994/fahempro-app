import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem/presentation/shared/widgets/image_widget.dart';
import 'package:flutter/material.dart';

class InfoBtmSheet extends StatelessWidget {
  final String title;
  final String body;
  final List<String>? images;
  final String? imageDirectory;

  const InfoBtmSheet({
    super.key,
    required this.title,
    required this.body,
    this.images,
    this.imageDirectory,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: AlignmentDirectional.topStart,
            child: CustomButton(
              onPressed: () => Navigator.pop(context),
              buttonType: ButtonType.icon,
              iconData: Icons.clear,
              isCircleBorder: true,
              iconSize: SizeManager.s25,
              padding: EdgeInsets.zero,
              width: SizeManager.s35,
              height: SizeManager.s35,
              buttonColor: Colors.transparent,
              iconColor: ColorsManager.black,
            ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: ColorsManager.lightSecondaryColor,
              fontSize: SizeManager.s24,
              fontWeight: FontWeightManager.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: SizeManager.s20),
          if(images != null && images!.isNotEmpty && imageDirectory != null) ...[
            SizedBox(
              width: double.infinity,
              child: Wrap(
                spacing: SizeManager.s10,
                runSpacing: SizeManager.s10,
                children: List.generate(images!.length, (index) => ImageWidget(
                  image: images![index],
                  imageDirectory: imageDirectory,
                  width: SizeManager.s70,
                  height: SizeManager.s70,
                  borderRadius: SizeManager.s10,
                  isShowFullImageScreen: true,
                )),
              ),
            ),
            const SizedBox(height: SizeManager.s20),
          ],
          Text(
            body,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: SizeManager.s15,
              fontWeight: FontWeightManager.medium,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
