import 'package:fahem/core/utilities/enums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/presentation/main/controllers/main_provider.dart';
import 'package:badges/badges.dart' as badges;

class BottomAppBarItem extends StatefulWidget {
  final BottomNavigationBarPages page;
  final String text;
  final String? image;
  final IconData? icon;
  final bool isShowBadge;
  final int count;

  const BottomAppBarItem({
    super.key,
    required this.page,
    required this.text,
    this.image,
    this.icon,
    this.isShowBadge = false,
    this.count = 0,
  });

  @override
  State<BottomAppBarItem> createState() => _BottomAppBarItemState();
}

class _BottomAppBarItemState extends State<BottomAppBarItem> {

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, mainProvider, _) {
        return MaterialButton(
          onPressed: () {
            mainProvider.changeBottomNavigationBarPages(context: context, page: widget.page);
          },
          child: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if(!widget.isShowBadge && widget.image != null) Image.asset(
                    widget.image!,
                    width: SizeManager.s20,
                    height: SizeManager.s20,
                    color: mainProvider.currentPage == widget.page
                        ? ColorsManager.white
                        : ColorsManager.white.withOpacity(0.5),
                  ),
                  if(!widget.isShowBadge && widget.icon != null) Padding(
                    padding: const EdgeInsets.only(bottom: SizeManager.s5),
                    child: Icon(
                      widget.icon,
                      size: SizeManager.s18,
                      color: mainProvider.currentPage == widget.page
                          ? ColorsManager.white
                          : ColorsManager.white.withOpacity(0.5),
                    ),
                  ),
                  if(widget.isShowBadge) badges.Badge(
                    showBadge: true,
                    badgeContent: Text(
                      widget.count.toString(),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: ColorsManager.white),
                    ),
                    child: Icon(
                      widget.icon,
                      size: SizeManager.s18,
                      color: mainProvider.currentPage == widget.page ? ColorsManager.white : ColorsManager.black54,
                    ),
                  ),
                  const SizedBox(height: SizeManager.s5),
                  FittedBox(
                    child: Text(
                      Methods.getText(widget.text).toCapitalized(),
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontSize: mainProvider.currentPage == widget.page ? SizeManager.s12 : SizeManager.s10,
                        color: mainProvider.currentPage == widget.page
                            ? ColorsManager.white
                            : ColorsManager.white.withOpacity(0.5),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}