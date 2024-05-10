import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:readmore/readmore.dart';
import 'package:fahem_dashboard/core/resources/fonts_manager.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_grid.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/image_widget.dart';

enum ListTileType {text, link, images}

class ListTileItem extends StatelessWidget {
  final ListTileType type;
  final String title;
  final dynamic value;
  final String imageDirectory;

  const ListTileItem({
    super.key,
    required this.type,
    required this.title,
    required this.value,
    required this.imageDirectory,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeightManager.semiBold),
          ),
          const SizedBox(height: SizeManager.s5),
          if(type == ListTileType.text) ReadMoreText(
            value.toString(),
            trimMode: TrimMode.Line,
            trimLines: 3,
            trimCollapsedText: Methods.getText(StringsManager.showMore).toCapitalized(),
            trimExpandedText: ' ${Methods.getText(StringsManager.showLess).toCapitalized()}',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(height: SizeManager.s1_8),
            moreStyle: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeightManager.bold),
            lessStyle: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeightManager.bold),
          ),
          if(type == ListTileType.link) CustomButton(
            onPressed: () async => await Methods.openUrl(url: value),
            buttonType: ButtonType.preIcon,
            text: Methods.getText(StringsManager.watchProductOnYoutube).toCapitalized(),
            iconData: FontAwesomeIcons.youtube,
            height: SizeManager.s35,
          ),
          if(type == ListTileType.images) CustomGrid(
            listLength: value.length,
            numberOfItemsInRow: 3,
            child: (index) {
              return Container(
                margin: const EdgeInsets.all(SizeManager.s5),
                child: ImageWidget(
                  image: value[index],
                  imageDirectory: imageDirectory,
                  width: SizeManager.s100,
                  height: SizeManager.s100,
                  borderRadius: SizeManager.s10,
                  isShowFullImageScreen: true,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}