import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/presentation/screens/splash/widgets/my_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/utilities/dialogs.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';

class MainProvider with ChangeNotifier {

  BottomNavigationBarPages _currentPage = BottomNavigationBarPages.home;
  BottomNavigationBarPages get currentPage => _currentPage;
  setBottomNavigationBarPages(BottomNavigationBarPages page) => _currentPage = page;
  changeBottomNavigationBarPages({required BuildContext context, required BottomNavigationBarPages page}) {
    if(MyProviders.authenticationProvider.currentUser == null && (
        page == BottomNavigationBarPages.transactions || page == BottomNavigationBarPages.wallet
    )) {
      Dialogs.showBottomSheetConfirmation(
        context: context,
        message: Methods.getText(StringsManager.youMustLoginFirst).toCapitalized(),
      ).then((value) {
        if(value) {
          Navigator.pushNamed(context, Routes.loginWithPhoneScreen);
        }
      });
      return;
    }

    _currentPage = page;
    notifyListeners();
  }

  Widget getScreenTitle(BuildContext context) {
    if(_currentPage == BottomNavigationBarPages.home) {
      return const MyLogo(
        width: SizeManager.s70,
        height: SizeManager.s25,
      );
    }
    if(_currentPage == BottomNavigationBarPages.search) {
      return SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Methods.getText(StringsManager.atYourService).toCapitalized(),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeightManager.black),
            ),
            Text(
              Methods.getText(StringsManager.whatAreYouLookingFor).toCapitalized(),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: SizeManager.s25, fontWeight: FontWeightManager.black),
            ),
          ],
        ),
      );
    }
    if(_currentPage == BottomNavigationBarPages.transactions) {
      return SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Methods.getText(StringsManager.myTransactions).toCapitalized(),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeightManager.black,
                fontSize: SizeManager.s24,
              ),
            ),
          ],
        ),
      );
    }
    if(_currentPage == BottomNavigationBarPages.wallet) {
      return SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Methods.getText(StringsManager.myWallet).toCapitalized(),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeightManager.black,
                fontSize: SizeManager.s24,
              ),
            ),
          ],
        ),
      );
    }
    if(_currentPage == BottomNavigationBarPages.menu) {
      return Text(
        MyProviders.authenticationProvider.currentUser == null
            ? Methods.getText(StringsManager.menu).toCapitalized()
            : MyProviders.authenticationProvider.currentUser!.fullName,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
          fontWeight: FontWeightManager.black,
          fontSize: SizeManager.s24,
        ),
      );
    }
    return Text(
      Methods.getText(_currentPage.title).toTitleCase(),
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeightManager.medium),
    );
  }

  Future<bool> onBackPressed({required BuildContext context, required AdvancedDrawerController advancedDrawerController}) async {
    if(advancedDrawerController.value.visible) {
      advancedDrawerController.hideDrawer();
      return Future.value(false);
    }
    else {
      if(_currentPage == BottomNavigationBarPages.home) {
        return await Dialogs.showBottomSheetConfirmation(context: context, message: Methods.getText(StringsManager.doYouWantToExitAnApp).toCapitalized());
      }
      else {
        changeBottomNavigationBarPages(context: context, page: BottomNavigationBarPages.home);
        return await Future.value(false);
      }
    }
  }
}