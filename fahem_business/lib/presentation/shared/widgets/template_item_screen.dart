import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fahem_business/core/resources/colors_manager.dart';
import 'package:fahem_business/core/resources/fonts_manager.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem_business/presentation/shared/widgets/my_back_button.dart';
import 'package:fahem_business/presentation/shared/widgets/my_error_widget.dart';

class TemplateItemScreen extends StatelessWidget {
  final bool isShowLoading;
  final bool isShowOpacityBackground;
  final bool waitForDone;
  final Function reFetchData;
  final Function? goToEditScreen;
  final String screenTitle;
  final DataState dataState;
  final Widget child;
  final bool isSupportAppBar;
  final Color? appBarColor;
  final Color? scaffoldColor;

  const TemplateItemScreen({
    super.key,
    this.isShowLoading = false,
    this.isShowOpacityBackground = false,
    this.waitForDone = false,
    required this.reFetchData,
    required this.goToEditScreen,
    required this.screenTitle,
    required this.dataState,
    required this.child,
    this.isSupportAppBar = true,
    this.appBarColor = ColorsManager.white,
    this.scaffoldColor = ColorsManager.grey1,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: CustomFullLoading(
        isShowLoading: isShowLoading,
        waitForDone: waitForDone,
        isShowOpacityBackground: isShowOpacityBackground,
        onRefresh: () => reFetchData(),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            if(isSupportAppBar) SliverAppBar(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: appBarColor,
                statusBarIconBrightness: Brightness.dark,
              ),
              backgroundColor: appBarColor,
              pinned: true,
              centerTitle: true,
              leading: const MyBackButton(),
              actions: [
                if(dataState == DataState.done && goToEditScreen != null) Padding(
                  padding: const EdgeInsets.symmetric(horizontal: SizeManager.s16, vertical: SizeManager.s10),
                  child: CustomButton(
                    onPressed: () => goToEditScreen!(),
                    buttonType: ButtonType.postIcon,
                    text: Methods.getText(StringsManager.edit).toTitleCase(),
                    iconData: FontAwesomeIcons.penToSquare,
                    visualDensity: const VisualDensity(horizontal: -2, vertical: -4),
                    centerSpace: SizeManager.s5,
                    padding: EdgeInsets.zero,
                    borderRadius: SizeManager.s10,
                  ),
                ),
              ],
              title: Text(
                Methods.getText(screenTitle).toTitleCase(),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeightManager.semiBold),
              ),
            ),
            if(dataState == DataState.done) SliverPadding(
              padding: const EdgeInsets.all(SizeManager.s16),
              sliver: SliverToBoxAdapter(
                child: child,
              ),
            ),
            if(dataState == DataState.error) SliverFillRemaining(
              child: Padding(
                padding: const EdgeInsets.all(SizeManager.s16),
                child: MyErrorWidget(onPressed: () => reFetchData()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}