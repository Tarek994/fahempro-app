import 'package:flutter/material.dart';
import 'package:fahem_dashboard/core/resources/colors_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';

class CustomPopupMenu extends StatelessWidget {
  final List<PopupMenu> items;
  final Function? onPressedEdit;
  final Function? onPressedDelete;
  final Function? onPressedChangeLanguage;
  final Function? onPressedLogout;
  final Function? onPressedCopyPost;
  final Color? iconColor;

  const CustomPopupMenu({
    super.key,
    required this.items,
    this.onPressedEdit,
    this.onPressedDelete,
    this.onPressedChangeLanguage,
    this.onPressedLogout,
    this.onPressedCopyPost,
    this.iconColor = ColorsManager.black,
  });

  Color getItemColor(PopupMenu item) {
    if(item == PopupMenu.logout) return ColorsManager.red;
    if(item == PopupMenu.delete) return ColorsManager.red;
    return ColorsManager.black;
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<PopupMenu>(
      onOpened: () => FocusScope.of(context).unfocus(),
      position: PopupMenuPosition.under,
      onSelected: (item) {
        if(item == PopupMenu.edit && onPressedEdit != null) {onPressedEdit!();}
        else if(item == PopupMenu.delete && onPressedDelete != null) {onPressedDelete!();}
        else if(item == PopupMenu.changeLanguage && onPressedChangeLanguage != null) {onPressedChangeLanguage!();}
        else if(item == PopupMenu.logout && onPressedLogout != null) {onPressedLogout!();}
      },
      itemBuilder: (context) {
        return items.map((item) {
          return PopupMenuItem(
            value: item,
            child: Row(
              textDirection: Methods.getDirection(),
              children: [
                Icon(
                  PopupMenu.getIcon(item),
                  size: SizeManager.s16,
                  color: getItemColor(item),
                ),
                const SizedBox(width: SizeManager.s15),
                Expanded(
                  child: Text(
                    PopupMenu.toText(item),
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(color: getItemColor(item), fontSize: SizeManager.s14),
                  ),
                ),
              ],
            ),
          );
        }).toList();
      },
      child: Icon(Icons.more_vert, color: iconColor),
    );
  }
}