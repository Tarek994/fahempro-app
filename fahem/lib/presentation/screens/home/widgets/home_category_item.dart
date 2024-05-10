import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem/core/network/api_constants.dart';
import 'package:fahem/core/resources/assets_manager.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/data/models/category_model.dart';
import 'package:fahem/presentation/screens/home/controllers/home_provider.dart';
import 'package:fahem/presentation/shared/widgets/image_widget.dart';

class HomeCategoryItem extends StatefulWidget {
  final CategoryModel? categoryModel;

  const HomeCategoryItem({super.key, this.categoryModel});

  @override
  State<HomeCategoryItem> createState() => _HomeCategoryItemState();
}

class _HomeCategoryItemState extends State<HomeCategoryItem> {
  late HomeProvider homeProvider;

  @override
  void initState() {
    super.initState();
    homeProvider = Provider.of<HomeProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: SizeManager.s100),
      decoration: BoxDecoration(
        color: MyProviders.appProvider.isLight ? ColorsManager.grey1 : ColorsManager.darkSecondaryColor,
        borderRadius: BorderRadius.circular(SizeManager.s10),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Methods.routeTo(context, Routes.jobsScreen, arguments: [widget.categoryModel, false]),
          borderRadius: BorderRadius.circular(SizeManager.s10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: SizeManager.s10, vertical: SizeManager.s5),
            child: Row(
              children: [
                SizedBox(
                  width: SizeManager.s30,
                  height: SizeManager.s30,
                  child: widget.categoryModel == null ? Image.asset(
                    ImagesManager.all,
                    color: MyProviders.appProvider.isLight ? ColorsManager.lightSecondaryColor : ColorsManager.white,
                  ) : ImageWidget(
                    image: widget.categoryModel!.image,
                    imageDirectory: ApiConstants.categoriesDirectory,
                    width: SizeManager.s40,
                    height: SizeManager.s40,
                    isShowFullImageScreen: false,
                  ),
                ),
                const SizedBox(width: SizeManager.s10),
                Text(
                  widget.categoryModel == null
                      ? Methods.getText(StringsManager.allJobs).toTitleCase()
                      : MyProviders.appProvider.isEnglish ? widget.categoryModel!.nameEn : widget.categoryModel!.nameAr,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}