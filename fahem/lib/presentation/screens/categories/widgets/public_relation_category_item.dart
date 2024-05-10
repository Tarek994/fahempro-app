import 'package:fahem/core/network/api_constants.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/data/models/category_model.dart';
import 'package:fahem/presentation/shared/widgets/image_widget.dart';
import 'package:flutter/material.dart';

class PublicRelationCategoryItem extends StatefulWidget {
  final CategoryModel categoryModel;
  final double height;
  final String linesImage;

  const PublicRelationCategoryItem({
    super.key,
    required this.categoryModel,
    required this.height,
    required this.linesImage,
  });

  @override
  State<PublicRelationCategoryItem> createState() => _PublicRelationCategoryItemState();
}

class _PublicRelationCategoryItemState extends State<PublicRelationCategoryItem> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeManager.s20),
      ),
      child: InkWell(
        onTap: () async {
          Methods.routeTo(
            context,
            Routes.accountsScreen,
            arguments: AccountsArgs(
              mainCategory: widget.categoryModel.mainCategory,
              category: widget.categoryModel,
            ),
          );

          // PublicRelationsProvider publicRelationsProvider = Provider.of<PublicRelationsProvider>(context, listen: false);
          // publicRelationsProvider.changeSelectedPublicRelations(publicRelationsProvider.publicRelations.where((publicRelations) {
          //   return publicRelations.categoriesIds.contains(widget.categoryModel.publicRelationCategoryId.toString());
          // }).toList());
          // GovernmentModel governmentModel = governoratesData[1];
          // publicRelationsProvider.setSelectedGovernmentModel(governmentModel);
          // Navigator.pushNamed(
          //   context,
          //   Routes.publicRelationsRoute,
          //   arguments: {
          //     ConstantsManager.publicRelationCategoryIdArgument: widget.categoryModel.publicRelationCategoryId,
          //   },
          // );
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            ImageWidget(
              image: widget.categoryModel.image,
              imageDirectory: ApiConstants.categoriesDirectory,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
              borderRadius: SizeManager.s10,
              isShowFullImageScreen: false,
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              color: ColorsManager.black.withOpacity(0.5),
            ),
            Image.asset(widget.linesImage, width: double.infinity, height: double.infinity, fit: BoxFit.fill),
            Padding(
              padding: const EdgeInsets.all(SizeManager.s10),
              child: Text(
                MyProviders.appProvider.isEnglish ? widget.categoryModel.nameEn : widget.categoryModel.nameAr,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(color: ColorsManager.white, fontSize: SizeManager.s18, fontWeight: FontWeightManager.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}