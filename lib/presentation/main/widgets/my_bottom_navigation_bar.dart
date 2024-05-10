import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/presentation/shared/controllers/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/presentation/main/widgets/bottom_app_bar_item.dart';
import 'package:provider/provider.dart';

class MyBottomNavigationBar extends StatelessWidget {
  
  const MyBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        return Container(
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(SizeManager.s20),
              topRight: Radius.circular(SizeManager.s20),
            ),
          ),
          child: BottomAppBar(
            color: appProvider.isLight ? ColorsManager.lightPrimaryColor : ColorsManager.darkPrimaryColor,
            shape: const CircularNotchedRectangle(),
            notchMargin: SizeManager.s5,
            child: SizedBox(
              height: SizeManager.s60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: BottomNavigationBarPages.values.map((item) => Expanded(
                  child: BottomAppBarItem(
                    page: item,
                    text: item.title,
                    icon: item.icon,
                    image: item.image,
                  ),
                )).toList(),
                // children: [
                //   Row(
                //     children: [
                //       BottomAppBarItem(page: BottomNavigationBarPages.home, text: StringsManager.home, image: IconsManager.home),
                //       BottomAppBarItem(page: BottomNavigationBarPages.blogs, text: StringsManager.blogs, image: IconsManager.blogs),
                //     ],
                //   ),
                //   Row(
                //     children: [
                //       BottomAppBarItem(page: BottomNavigationBarPages.profile, text: StringsManager.profile, image: IconsManager.profile),
                //     ],
                //   )
                // ],
              ),
            ),
          ),
        );
      },
    );
  }
}