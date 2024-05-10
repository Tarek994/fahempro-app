import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/my_error_widget.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/not_found_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fahem_dashboard/core/resources/colors_manager.dart';
import 'package:fahem_dashboard/core/resources/fonts_manager.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/my_back_button.dart';

class TemplateListScreen extends StatelessWidget {
  final bool isShowLoading;
  final bool isShowOpacityBackground;
  final bool waitForDone;
  final Function reFetchData;
  final ScrollController scrollController;
  final Function? goToInsertScreen;
  final List<Widget>? customAction;
  final bool isSearchFilterOrderWidgetInAction;
  final String? screenTitle;
  final String? title;
  final Widget? searchFilterOrderWidget;
  final bool isDataNotEmpty;
  final int dataCount;
  final int? totalResults;
  final List<ViewStyle> supportedViewStyle;
  final ViewStyle currentViewStyle;
  final Function changeViewStyleToList;
  final Function changeViewStyleToGrid;
  final Widget? Function(BuildContext, int)? listItemBuilder;
  final Widget? Function(BuildContext, int)? gridItemBuilder;
  final double itemHeightInGrid;
  final DataState dataState;
  final bool hasMore;
  final String noDataMsgInScreen;
  final String? noDataMsgInLastItem;
  final Widget? extraWidget;
  final Widget? bottomNavigationBar;
  final bool isSupportAppBar;
  final Color? appBarColor;
  final Color? scaffoldColor;
  final bool isSupportBack;

  const TemplateListScreen({
    super.key,
    this.isShowLoading = false,
    this.isShowOpacityBackground = false,
    this.waitForDone = false,
    required this.reFetchData,
    required this.scrollController,
    this.goToInsertScreen,
    this.customAction,
    this.isSearchFilterOrderWidgetInAction = false,
    this.screenTitle,
    this.title,
    required this.searchFilterOrderWidget,
    required this.isDataNotEmpty,
    required this.dataCount,
    this.totalResults,
    required this.supportedViewStyle,
    required this.currentViewStyle,
    required this.changeViewStyleToList,
    required this.changeViewStyleToGrid,
    required this.listItemBuilder,
    required this.gridItemBuilder,
    this.itemHeightInGrid = SizeManager.s90,
    required this.dataState,
    required this.hasMore,
    required this.noDataMsgInScreen,
    this.noDataMsgInLastItem,
    this.extraWidget,
    this.bottomNavigationBar,
    this.isSupportAppBar = true,
    this.appBarColor = ColorsManager.white,
    this.scaffoldColor,
    this.isSupportBack = true,
  });

  Widget _showData() {
    if(supportedViewStyle.isEmpty) return const SliverToBoxAdapter(child: SizedBox());
    if(supportedViewStyle.contains(ViewStyle.list) && currentViewStyle == ViewStyle.list && listItemBuilder != null) {
      return SliverList.separated(
        itemBuilder: listItemBuilder!,
        separatorBuilder: (context, index) => const SizedBox(height: SizeManager.s15),
        itemCount: dataCount,
      );
    }
    if(supportedViewStyle.contains(ViewStyle.grid) && currentViewStyle == ViewStyle.grid && gridItemBuilder != null) {
      return SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: SizeManager.s15,
          mainAxisSpacing: SizeManager.s15,
          mainAxisExtent: itemHeightInGrid,
        ),
        delegate: SliverChildBuilderDelegate(
          gridItemBuilder!,
          childCount: dataCount,
        ),
      );
    }
    return const SliverToBoxAdapter(child: SizedBox());
  }

  List<Widget>? _getAction(BuildContext context) {
    if(customAction != null) {
      return customAction!;
    }
    if(searchFilterOrderWidget != null && isSearchFilterOrderWidgetInAction) {
      return [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: SizeManager.s16, vertical: SizeManager.s10),
          child: searchFilterOrderWidget!,
        ),
      ];
    }
    if(goToInsertScreen != null) {
      return [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: SizeManager.s16, vertical: SizeManager.s10),
          child: CustomButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              goToInsertScreen!();
            },
            buttonType: ButtonType.postIcon,
            text: Methods.getText(StringsManager.add).toTitleCase(),
            iconData: FontAwesomeIcons.plus,
            visualDensity: const VisualDensity(horizontal: -2, vertical: -4),
            centerSpace: SizeManager.s5,
            padding: EdgeInsets.zero,
            borderRadius: SizeManager.s5,
          ),
        ),
      ];
    }
    return null;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: CustomFullLoading(
        isShowLoading: isShowLoading,
        isShowOpacityBackground: isShowOpacityBackground,
        waitForDone: waitForDone,
        onRefresh: () => reFetchData(),
        child: CustomScrollView(
          controller: scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            if(isSupportAppBar) SliverAppBar(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: appBarColor ?? (searchFilterOrderWidget == null ? ColorsManager.white : ColorsManager.grey200),
                statusBarIconBrightness: Brightness.dark,
              ),
              backgroundColor: appBarColor ?? (searchFilterOrderWidget == null ? ColorsManager.white : ColorsManager.grey200),
              pinned: true,
              centerTitle: true,
              leading: isSupportBack ? const MyBackButton() : null,
              actions: _getAction(context),
              title: title != null ? Text(
                title!,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeightManager.semiBold),
              ) : screenTitle != null ? Text(
                Methods.getText(screenTitle!).toTitleCase(),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeightManager.semiBold),
              ) : null,
            ),
            if(searchFilterOrderWidget != null && !isSearchFilterOrderWidgetInAction) SliverToBoxAdapter(
              child: Container(
                color: appBarColor,
                padding: const EdgeInsets.symmetric(horizontal: SizeManager.s16),
                child: searchFilterOrderWidget!,
              ),
            ),
            if(extraWidget != null) SliverToBoxAdapter(child: extraWidget),
            if(isDataNotEmpty) SliverToBoxAdapter(
              child: _ViewStyleWidget(
                totalResults: totalResults,
                viewStyle: currentViewStyle,
                changeViewStyleToList: () => changeViewStyleToList(),
                changeViewStyleToGrid: () => changeViewStyleToGrid(),
                supportedViewStyle: supportedViewStyle,
              ),
            ),
            ConditionalBuilder(
              condition: isDataNotEmpty,
              builder: (_) => SliverPadding(
                padding: const EdgeInsets.only(left: SizeManager.s16, right: SizeManager.s16, top: SizeManager.s8),
                sliver: _showData(),
              ),
              fallback: (_) => _FallbackWidget(
                dataState: dataState,
                reFetchData: () => reFetchData(),
                noDataMsgInScreen: noDataMsgInScreen,
              ),
            ),
            if(isDataNotEmpty) SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: SizeManager.s16, right: SizeManager.s16, bottom: SizeManager.s16, top: SizeManager.s8),
                child: _DefaultLastItem(
                  hasMore: hasMore,
                  dataState: dataState,
                  reFetchData: () => reFetchData(),
                  noDataMsgInLastItem: noDataMsgInLastItem,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomNavigationBar == null ? null : Directionality(
        textDirection: Methods.getDirection(),
        child: bottomNavigationBar!,
      ),
    );
  }
}

class _ViewStyleWidget extends StatelessWidget {
  final List<ViewStyle> supportedViewStyle;
  final int? totalResults;
  final ViewStyle viewStyle;
  final Function changeViewStyleToList;
  final Function changeViewStyleToGrid;

  const _ViewStyleWidget({
    required this.supportedViewStyle,
    required this.totalResults,
    required this.viewStyle,
    required this.changeViewStyleToList,
    required this.changeViewStyleToGrid,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: SizeManager.s16, right: SizeManager.s16, top: SizeManager.s8),
      child: Row(
        mainAxisAlignment: totalResults == null ? MainAxisAlignment.end : MainAxisAlignment.spaceBetween,
        children: [
          if(totalResults != null) Padding(
            padding: const EdgeInsets.symmetric(vertical: SizeManager.s10),
            child: Text(
              '${Methods.getText(StringsManager.results).toCapitalized()}: $totalResults',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          if(supportedViewStyle.length == 2) Row(
            children: [
              IconButton(
                onPressed: () {
                  if (viewStyle == ViewStyle.list) return;
                  changeViewStyleToList();
                },
                icon: Icon(
                  Icons.view_list_rounded,
                  size: SizeManager.s20,
                  color: viewStyle == ViewStyle.list ? ColorsManager.lightPrimaryColor : ColorsManager.grey,
                ),
                visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                padding: EdgeInsets.zero,
              ),
              const SizedBox(width: SizeManager.s10),
              IconButton(
                onPressed: () {
                  if (viewStyle == ViewStyle.grid) return;
                  changeViewStyleToGrid();
                },
                icon: Icon(
                  Icons.grid_view_rounded,
                  size: SizeManager.s20,
                  color: viewStyle == ViewStyle.grid ? ColorsManager.lightPrimaryColor : ColorsManager.grey,
                ),
                visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                padding: EdgeInsets.zero,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FallbackWidget extends StatelessWidget {
  final DataState dataState;
  final String noDataMsgInScreen;
  final Function reFetchData;

  const _FallbackWidget({
    required this.dataState,
    required this.noDataMsgInScreen,
    required this.reFetchData,
  });

  @override
  Widget build(BuildContext context) {
    if(dataState == DataState.loading) {
      return SliverPadding(
        padding: const EdgeInsets.all(SizeManager.s16),
        sliver: Methods.shimmerSliverList(),
      );
    }
    if(dataState == DataState.empty) {
      return SliverFillRemaining(
        child: Padding(
          padding: const EdgeInsets.all(SizeManager.s16),
          child: NotFoundWidget(message: noDataMsgInScreen),
        ),
      );
    }
    if(dataState == DataState.error) {
      return SliverFillRemaining(
        child: Padding(
          padding: const EdgeInsets.all(SizeManager.s16),
          child: MyErrorWidget(onPressed: () => reFetchData()),
        ),
      );
    }
    return SliverToBoxAdapter(child: Container());
  }
}

class _DefaultLastItem extends StatelessWidget {
  final bool hasMore;
  final DataState dataState;
  final String? noDataMsgInLastItem;
  final Function reFetchData;

  const _DefaultLastItem({
    required this.hasMore,
    required this.dataState,
    this.noDataMsgInLastItem,
    required this.reFetchData,
  });

  @override
  Widget build(BuildContext context) {
    if(hasMore) {
      if(dataState == DataState.loading) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.only(top: SizeManager.s10),
            child: CircularProgressIndicator(),
          ),
        );
      }
      else if(dataState == DataState.error) {
        return Center(
          child: CustomButton(
            onPressed: () => reFetchData(),
            buttonType: ButtonType.text,
            text: Methods.getText(StringsManager.tryAgain).toCapitalized(),
            buttonColor: Colors.transparent,
            textColor: ColorsManager.blue,
          ),
        );
      }
      return const SizedBox();
    }
    else {
      return noDataMsgInLastItem == null ? const SizedBox() : Center(
        child: Padding(
          padding: const EdgeInsets.only(top: SizeManager.s10),
          child: Text(Methods.getText(noDataMsgInLastItem!).toCapitalized()),
        ),
      );
    }
  }
}