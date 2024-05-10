import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/presentation/screens/authentication/controllers/authentication_provider.dart';
import 'package:fahem/presentation/screens/splash/widgets/my_logo.dart';
import 'package:fahem/presentation/shared/controllers/app_provider.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/presentation/main/controllers/main_provider.dart';
import 'package:fahem/presentation/main/widgets/my_bottom_navigation_bar.dart';
import 'package:fahem/presentation/main/widgets/my_drawer.dart';

class MainScreen extends StatefulWidget {

  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final AdvancedDrawerController _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationProvider>(
      builder: (context, authenticationProvider, _) {
        return Consumer<MainProvider>(
          builder: (context, mainProvider, _) {
            return Consumer<AppProvider>(
              builder: (context, appProvider, _) {
                return Directionality(
                  textDirection: Methods.getDirection(),
                  child: CustomFullLoading(
                    isShowLoading: authenticationProvider.isLoading,
                    waitForDone: authenticationProvider.isLoading,
                    isShowOpacityBackground: true,
                    child: WillPopScope(
                      onWillPop: () => mainProvider.onBackPressed(
                        context: context,
                        advancedDrawerController: _advancedDrawerController,
                      ),
                      child: Scaffold(
                        backgroundColor: ColorsManager.white,
                        appBar: mainProvider.currentPage == BottomNavigationBarPages.home ? null : AppBar(
                          systemOverlayStyle: SystemUiOverlayStyle(
                            statusBarColor: mainProvider.currentPage == BottomNavigationBarPages.home ? ColorsManager.white : ColorsManager.white,
                            statusBarIconBrightness: Brightness.dark,
                          ),
                          backgroundColor: mainProvider.currentPage == BottomNavigationBarPages.home ? ColorsManager.white : ColorsManager.white,
                          // leading: IconButton(
                          //   onPressed: () => _advancedDrawerController.showDrawer(),
                          //   icon: const Icon(Icons.menu, color: ColorsManager.black),
                          // ),
                          centerTitle: true,
                          toolbarHeight: SizeManager.s70,
                          title: mainProvider.getScreenTitle(context),
                        ),
                        body: SafeArea(
                          child: mainProvider.currentPage.page,
                        ),
                        // floatingActionButton: FloatingActionButton(
                        //   onPressed: () {},
                        //   elevation: SizeManager.s0,
                        //   child: const Icon(Icons.add, color: ColorsManager.white, size: SizeManager.s30),
                        // ),
                        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                        bottomNavigationBar: const MyBottomNavigationBar(),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _advancedDrawerController.dispose();
    super.dispose();
  }
}