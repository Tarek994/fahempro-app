import 'package:fahem/core/resources/assets_manager.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/dialogs.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/data/models/static/governorate_model.dart';
import 'package:fahem/presentation/btm_sheets/governorates_btm_sheet.dart';
import 'package:fahem/presentation/screens/services/controllers/instant_lawyers_provider.dart';
import 'package:fahem/presentation/screens/services/widgets/extra_widget_in_instant_lawyers.dart';
import 'package:fahem/presentation/screens/services/widgets/instant_lawyer_list_item.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/presentation/shared/widgets/template_list_screen.dart';

class InstantLawyersScreen extends StatefulWidget {

  const InstantLawyersScreen({super.key});

  @override
  State<InstantLawyersScreen> createState() => _InstantLawyersScreenState();
}

class _InstantLawyersScreenState extends State<InstantLawyersScreen> {
  late InstantLawyersProvider instantLawyersProvider;

  @override
  void initState() {
    super.initState();
    instantLawyersProvider = Provider.of<InstantLawyersProvider>(context, listen: false);
    instantLawyersProvider.accountsAddListenerScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.wait([
        instantLawyersProvider.fetchAccounts(),
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<InstantLawyersProvider>(
      builder: (context, provider, _) {
        return TemplateListScreen(
          reFetchData: () async {
            await Future.wait([
              instantLawyersProvider.reFetchAccounts(),
            ]);
          },
          scrollController: provider.accountsScrollController,
          goToInsertScreen: null,
          customTitle: CustomButton(
            buttonType: ButtonType.preImage,
            onPressed: () {
              Dialogs.showBottomSheet(
                context: context,
                child: GovernoratesBtmSheet(
                  extraGovernorates: [
                    GovernorateModel(
                      governorateId: allGovernoratesLabel,
                      governorateNameAr: 'كل المحافظات',
                      governorateNameEn: 'All Governorates',
                    ),
                  ],
                ),
                thenMethod: () {
                  if(selectedGovernorateInBtmSheet != null) {
                    if (selectedGovernorateInBtmSheet!.governorateId == allGovernoratesLabel) {
                      provider.governorateId = null;
                    }
                    else {
                      provider.governorateId = selectedGovernorateInBtmSheet!.governorateId;
                    }
                    provider.reFetchAccounts();
                  }
                },
              );
            },
            // onPressed: () => Dialogs.showBottomSheetGovernorates(context: context).then((value) {
            //   if(value != null) {
            //     if(value.governoratesMode == GovernoratesMode.currentLocation) {
            //       provider.changeSelectedLawyers(provider.lawyers.where((lawyer) {
            //         double distanceKm = Geolocator.distanceBetween(value.latitude, value.longitude, lawyer.latitude, lawyer.longitude) / 1000;
            //         return lawyer.categoriesIds.contains(widget.lawyersCategoryId.toString())
            //             && distanceKm <= settingsProvider.settings.distanceKm;
            //       }).toList());
            //       provider.changeSelectedGovernmentModel(value);
            //     }
            //     else if(value.governoratesMode == GovernoratesMode.allGovernorates) {
            //       provider.changeSelectedLawyers(provider.lawyers.where((lawyer) {
            //         return lawyer.categoriesIds.contains(widget.lawyersCategoryId.toString());
            //       }).toList());
            //       provider.changeSelectedGovernmentModel(value);
            //     }
            //     else {
            //       provider.changeSelectedLawyers(provider.lawyers.where((lawyer) {
            //         return lawyer.categoriesIds.contains(widget.lawyersCategoryId.toString())
            //             && lawyer.governorate == value.nameAr;
            //       }).toList());
            //       provider.changeSelectedGovernmentModel(value);
            //     }
            //   }
            // }),
            text: selectedGovernorateInBtmSheet == null
                ? Methods.getText(StringsManager.chooseGovernorate).toTitleCase()
                : MyProviders.appProvider.isEnglish ? selectedGovernorateInBtmSheet!.governorateNameEn : selectedGovernorateInBtmSheet!.governorateNameAr,
            imageName: IconsManager.animatedMap,
            textColor: ColorsManager.lightPrimaryColor,
            imageColor: ColorsManager.lightPrimaryColor,
            imageSize: SizeManager.s25,
            buttonColor: ColorsManager.white,
            borderColor: ColorsManager.lightPrimaryColor,
            height: SizeManager.s35,
            borderRadius: SizeManager.s10,
          ),
          scaffoldColor: ColorsManager.white,
          searchFilterOrderWidget: null,
          isDataNotEmpty: provider.accounts.isNotEmpty,
          dataCount: provider.accounts.length,
          totalResults: null,
          // totalResults: provider.accountsPaginationModel == null ? 0 : provider.accountsPaginationModel!.total,
          supportedViewStyle: const [ViewStyle.list],
          currentViewStyle: provider.accountsViewStyle,
          changeViewStyleToList: () => provider.changeAccountsViewStyle(ViewStyle.list),
          changeViewStyleToGrid: () => provider.changeAccountsViewStyle(ViewStyle.grid),
          listItemBuilder: (context, index) => InstantLawyerListItem(accountModel: provider.accounts[index]),
          gridItemBuilder: null,
          dataState: provider.accountsDataState,
          hasMore: provider.accountsHasMore,
          noDataMsgInScreen: StringsManager.thereAreNoAccounts,
          extraWidget: const ExtraWidgetInInstantLawyers(),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    instantLawyersProvider.setIsScreenDisposed(true);
    // instantLawyersProvider.accountsScrollController.dispose();
    selectedGovernorateInBtmSheet = null;
  }
}