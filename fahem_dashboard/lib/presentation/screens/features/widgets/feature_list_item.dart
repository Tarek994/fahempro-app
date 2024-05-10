import 'package:fahem_dashboard/core/resources/colors_manager.dart';
import 'package:fahem_dashboard/core/resources/fonts_manager.dart';
import 'package:fahem_dashboard/core/resources/routes_manager.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/dialogs.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/core/utilities/my_providers.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:fahem_dashboard/data/models/feature_model.dart';

class FeatureListItem extends StatelessWidget {
  final FeatureModel featureModel;
  final Function onEdit;
  final Function onDelete;

  const FeatureListItem({
    super.key,
    required this.featureModel,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(SizeManager.s10),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(SizeManager.s10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              MyProviders.appProvider.isEnglish ? featureModel.featureEn : featureModel.featureAr,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeightManager.medium),
            ),
          ),
          const SizedBox(width: SizeManager.s10),
          if(Methods.checkAdminPermission(AdminPermissions.editFeature) || Methods.checkAdminPermission(AdminPermissions.deleteFeature)) ...[
            const SizedBox(width: SizeManager.s5),
            CustomPopupMenu(
              items: [
                if(Methods.checkAdminPermission(AdminPermissions.editFeature)) PopupMenu.edit,
                if(Methods.checkAdminPermission(AdminPermissions.deleteFeature)) PopupMenu.delete,
              ],
              onPressedEdit: () => Methods.routeTo(context, Routes.insertEditFeatureScreen, arguments: featureModel, then: (feature) => onEdit(feature)),
              onPressedDelete: () {
                Dialogs.showBottomSheetConfirmation(context: context, message: Methods.getText(StringsManager.areYouSureOfTheDeletionProcess).toCapitalized()).then((value) {
                  if(value) {
                    onDelete();
                  }
                });
              },
            ),
          ],
        ],
      ),
    );
  }
}