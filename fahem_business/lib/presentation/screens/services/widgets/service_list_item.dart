import 'package:fahem_business/core/network/api_constants.dart';
import 'package:fahem_business/core/resources/colors_manager.dart';
import 'package:fahem_business/core/resources/fonts_manager.dart';
import 'package:fahem_business/core/resources/routes_manager.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/dialogs.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/core/utilities/my_providers.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_popup_menu.dart';
import 'package:fahem_business/presentation/shared/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:fahem_business/data/models/service_model.dart';

class ServiceListItem extends StatelessWidget {
  final ServiceModel serviceModel;
  final Function onEdit;
  final Function onDelete;

  const ServiceListItem({
    super.key,
    required this.serviceModel,
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
          ImageWidget(
            image: serviceModel.serviceImage,
            imageDirectory: ApiConstants.servicesDirectory,
            width: SizeManager.s40,
            height: SizeManager.s40,
            boxShape: BoxShape.circle,
            isShowFullImageScreen: true,
          ),
          const SizedBox(width: SizeManager.s10),
          Expanded(
            child: Text(
              MyProviders.appProvider.isEnglish ? serviceModel.nameEn : serviceModel.nameAr,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeightManager.medium),
            ),
          ),
          const SizedBox(width: SizeManager.s10),
          if(Methods.checkAdminPermission(AdminPermissions.editService) || Methods.checkAdminPermission(AdminPermissions.deleteService)) ...[
            const SizedBox(width: SizeManager.s5),
            CustomPopupMenu(
              items: [
                if(Methods.checkAdminPermission(AdminPermissions.editService)) PopupMenu.edit,
                if(Methods.checkAdminPermission(AdminPermissions.deleteService)) PopupMenu.delete,
              ],
              onPressedEdit: () => Methods.routeTo(context, Routes.insertEditServiceScreen, arguments: serviceModel, then: (service) => onEdit(service)),
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