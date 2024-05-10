import 'package:fahem_business/core/network/api_constants.dart';
import 'package:fahem_business/core/resources/colors_manager.dart';
import 'package:fahem_business/core/resources/routes_manager.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/dialogs.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/data/models/slider_model.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_popup_menu.dart';
import 'package:fahem_business/presentation/shared/widgets/image_widget.dart';
import 'package:flutter/material.dart';

class SliderListItem extends StatelessWidget {
  final SliderModel sliderModel;
  final Function onEdit;
  final Function onDelete;

  const SliderListItem({
    super.key,
    required this.sliderModel,
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
            child: ImageWidget(
              image: sliderModel.image,
              imageDirectory: ApiConstants.slidersDirectory,
              width: double.infinity,
              height: SizeManager.s150,
              fit: BoxFit.cover,
              borderRadius: SizeManager.s10,
              isShowFullImageScreen: true,
            ),
          ),
          const SizedBox(width: SizeManager.s10),
          if(Methods.checkAdminPermission(AdminPermissions.editSlider) || Methods.checkAdminPermission(AdminPermissions.deleteSlider)) ...[
            const SizedBox(width: SizeManager.s5),
            CustomPopupMenu(
              items: [
                if(Methods.checkAdminPermission(AdminPermissions.editSlider)) PopupMenu.edit,
                if(Methods.checkAdminPermission(AdminPermissions.deleteSlider)) PopupMenu.delete,
              ],
              onPressedEdit: () => Methods.routeTo(context, Routes.insertEditSliderScreen, arguments: sliderModel, then: (slider) => onEdit(slider)),
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