import 'package:fahem/core/resources/assets_manager.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/dialogs.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/data/models/static/governorate_model.dart';
import 'package:fahem/presentation/btm_sheets/governorates_btm_sheet.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem/presentation/shared/widgets/search_filter_order_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/presentation/screens/accounts/controllers/accounts_provider.dart';
import 'package:fahem/presentation/screens/accounts/widgets/account_list_item.dart';
import 'package:fahem/presentation/shared/widgets/template_list_screen.dart';

class AccountsScreen extends StatefulWidget {

  const AccountsScreen({super.key});

  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  late AccountsProvider accountsProvider;

  @override
  void initState() {
    super.initState();
    accountsProvider = Provider.of<AccountsProvider>(context, listen: false);
    accountsProvider.accountsAddListenerScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.wait([
        accountsProvider.fetchAccounts(),
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountsProvider>(
      builder: (context, provider, _) {
        return TemplateListScreen(
          reFetchData: () async {
            await Future.wait([
              accountsProvider.reFetchAccounts(),
            ]);
          },
          scrollController: provider.accountsScrollController,
          goToInsertScreen: null,
          customTitle: SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        MyProviders.appProvider.isEnglish ? provider.accountsArgs.mainCategory.nameEn : provider.accountsArgs.mainCategory.nameAr,
                        style: provider.accountsArgs.category == null
                            ? Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeightManager.black, fontSize: SizeManager.s24)
                            : Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeightManager.black),
                      ),
                      if(provider.accountsArgs.category != null) Text(
                        MyProviders.appProvider.isEnglish ? provider.accountsArgs.category!.nameEn : provider.accountsArgs.category!.nameAr,
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeightManager.black,
                          fontSize: SizeManager.s24,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: SizeManager.s10),
                CustomButton(
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
              ],
            ),
          ),
          scaffoldColor: ColorsManager.white,
          searchFilterOrderWidget: Padding(
            padding: const EdgeInsets.only(top: SizeManager.s20),
            child: SearchFilterOrderWidget(
              hintText: StringsManager.searchByName,
              ordersItems: const [OrderByType.accountsNewestFirst, OrderByType.accountsOldestFirst],
              filtersItems: const [FiltersType.gender, FiltersType.isFeatured],
              dataState: provider.accountsDataState,
              reFetchData: () async => await provider.reFetchAccounts(),
              customText: {
                FiltersType.dateOfCreated.name: StringsManager.joinDate,
                FiltersType.isFeatured.name: StringsManager.verifiedAccounts,
              },
            ),
          ),
          isDataNotEmpty: provider.accounts.isNotEmpty,
          dataCount: provider.accounts.length,
          totalResults: provider.accountsPaginationModel == null ? 0 : provider.accountsPaginationModel!.total,
          supportedViewStyle: const [ViewStyle.list],
          currentViewStyle: provider.accountsViewStyle,
          changeViewStyleToList: () => provider.changeAccountsViewStyle(ViewStyle.list),
          changeViewStyleToGrid: () => provider.changeAccountsViewStyle(ViewStyle.grid),
          listItemBuilder: (context, index) => AccountListItem(
            accountModel: provider.accounts[index],
            index: index,
          ),
          gridItemBuilder: null,
          dataState: provider.accountsDataState,
          hasMore: provider.accountsHasMore,
          noDataMsgInScreen: StringsManager.thereAreNoAccounts,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    accountsProvider.setIsScreenDisposed(true);
    accountsProvider.accountsScrollController.dispose();
    selectedGovernorateInBtmSheet = null;
  }
}