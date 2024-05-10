import 'package:fahem/presentation/screens/splash/controllers/start_provider.dart';
import 'package:flutter/material.dart';
import 'package:fahem/core/resources/constants_manager.dart';
import 'package:fahem/core/helper/cache_helper.dart';
import 'package:fahem/data/data_source/static/on_boarding_data.dart';

class OnBoardingProvider with ChangeNotifier {

  int _currentPage = 0;
  int get currentPage => _currentPage;
  setCurrentPage(int index) => _currentPage = index;
  onPageChanged(int index) {_currentPage = index; notifyListeners();}

  late PageController _pageController;
  PageController get pageController => _pageController;

  void init() {
    _pageController = PageController();
  }

  Future<void> next({required BuildContext context, required StartProvider startProvider}) async {
    _currentPage++;
    if(currentPage > onBoardingData.length - 1) {
      skip(context: context, startProvider: startProvider);
    }
    else {
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: ConstantsManager.onBoardingPageViewDuration),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> skip({required BuildContext context, required StartProvider startProvider}) async {
    CacheHelper.setData(key: CacheHelper.isFirstOpenAppKey, value: false);
    await startProvider.goToInitialRoute(context, startProvider);
  }
}