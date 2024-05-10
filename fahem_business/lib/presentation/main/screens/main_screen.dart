import 'package:fahem_business/core/network/api_constants.dart';
import 'package:fahem_business/core/resources/assets_manager.dart';
import 'package:fahem_business/core/resources/colors_manager.dart';
import 'package:fahem_business/core/resources/constants_manager.dart';
import 'package:fahem_business/core/resources/fonts_manager.dart';
import 'package:fahem_business/core/resources/routes_manager.dart';
import 'package:fahem_business/core/resources/strings_manager.dart';
import 'package:fahem_business/core/resources/values_manager.dart';
import 'package:fahem_business/core/utilities/dialogs.dart';
import 'package:fahem_business/core/utilities/enums.dart';
import 'package:fahem_business/core/utilities/extensions.dart';
import 'package:fahem_business/core/utilities/methods.dart';
import 'package:fahem_business/core/utilities/my_providers.dart';
import 'package:fahem_business/data/models/account_model.dart';
import 'package:fahem_business/data/models/static/main_model.dart';
import 'package:fahem_business/presentation/main/controllers/account_statistics_provider.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fahem_business/presentation/main/widgets/main_item.dart';
import 'package:fahem_business/presentation/main/widgets/main_statistics_widget.dart';
import 'package:fahem_business/presentation/screens/authentication/controllers/authentication_provider.dart';
import 'package:fahem_business/presentation/shared/controllers/app_provider.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem_business/presentation/shared/widgets/custom/custom_grid.dart';
import 'package:fahem_business/presentation/shared/widgets/image_widget.dart';
import 'package:badges/badges.dart' as badges;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late AccountStatisticsProvider accountStatisticsProvider;
  List<MainModel> _data = [];

  void _setData() {
    AccountModel currentAccount = MyProviders.authenticationProvider.currentAccount;
    bool isAccountActive = currentAccount.accountStatus == AccountStatus.active;
    bool isSubscribeInInstantConsultations = currentAccount.services.indexWhere((element) => element.label == ConstantsManager.instantConsultationsLabel) != -1;

    _data = [
      MainModel(
        textAr: Methods.getTextAr(StringsManager.jobs).toTitleCase(),
        textEn: Methods.getTextEn(StringsManager.jobs).toTitleCase(),
        image: ImagesManager.jobs,
        route: Routes.jobsScreen,
        onTap: isAccountActive ? null : (context) {
          Dialogs.showBottomSheetMessage(
            context: context,
            message: Methods.getText(StringsManager.yourAccountIsInactive).toCapitalized(),
          );
        },
        isLock: !isAccountActive,
      ),
      MainModel(
        textAr: Methods.getTextAr(StringsManager.employmentApplications).toTitleCase(),
        textEn: Methods.getTextEn(StringsManager.employmentApplications).toTitleCase(),
        image: ImagesManager.employmentApplications,
        route: Routes.employmentApplicationsScreen,
        onTap: isAccountActive ? null : (context) {
          Dialogs.showBottomSheetMessage(
            context: context,
            message: Methods.getText(StringsManager.yourAccountIsInactive).toCapitalized(),
          );
        },
        isLock: !isAccountActive,
      ),
      MainModel(
        textAr: Methods.getTextAr(StringsManager.reviews).toTitleCase(),
        textEn: Methods.getTextEn(StringsManager.reviews).toTitleCase(),
        image: ImagesManager.reviews,
        route: Routes.reviewsScreen,
        onTap: isAccountActive ? null : (context) {
          Dialogs.showBottomSheetMessage(
            context: context,
            message: Methods.getText(StringsManager.yourAccountIsInactive).toCapitalized(),
          );
        },
        isLock: !isAccountActive,
      ),

      MainModel(
        textAr: Methods.getTextAr(StringsManager.phoneNumberRequests).toTitleCase(),
        textEn: Methods.getTextEn(StringsManager.phoneNumberRequests).toTitleCase(),
        image: ImagesManager.phoneNumberRequests,
        route: Routes.phoneNumberRequestsScreen,
        onTap: isAccountActive ? null : (context) {
          Dialogs.showBottomSheetMessage(
            context: context,
            message: Methods.getText(StringsManager.yourAccountIsInactive).toCapitalized(),
          );
        },
        isLock: !isAccountActive,
      ),
      MainModel(
        textAr: Methods.getTextAr(StringsManager.bookingAppointments).toTitleCase(),
        textEn: Methods.getTextEn(StringsManager.bookingAppointments).toTitleCase(),
        image: ImagesManager.bookingAppointments,
        route: Routes.bookingAppointmentsScreen,
        onTap: isAccountActive ? null : (context) {
          Dialogs.showBottomSheetMessage(
            context: context,
            message: Methods.getText(StringsManager.yourAccountIsInactive).toCapitalized(),
          );
        },
        isLock: !isAccountActive,
      ),
      if(isSubscribeInInstantConsultations) MainModel(
        textAr: Methods.getTextAr(StringsManager.instantConsultations).toTitleCase(),
        textEn: Methods.getTextEn(StringsManager.instantConsultations).toTitleCase(),
        image: ImagesManager.instantConsultations,
        route: Routes.instantConsultationsScreen,
        onTap: isAccountActive ? null : (context) {
          Dialogs.showBottomSheetMessage(
            context: context,
            message: Methods.getText(StringsManager.yourAccountIsInactive).toCapitalized(),
          );
        },
        isLock: !isAccountActive,
      ),

      MainModel(
        textAr: Methods.getTextAr(StringsManager.walletHistory).toTitleCase(),
        textEn: Methods.getTextEn(StringsManager.walletHistory).toTitleCase(),
        image: ImagesManager.walletHistory,
        route: Routes.walletHistoryScreen,
        onTap: isAccountActive ? null : (context) {
          Dialogs.showBottomSheetMessage(
            context: context,
            message: Methods.getText(StringsManager.yourAccountIsInactive).toCapitalized(),
          );
        },
        isLock: !isAccountActive,
      ),
      MainModel(
        textAr: Methods.getTextAr(StringsManager.withdrawalRequests).toTitleCase(),
        textEn: Methods.getTextEn(StringsManager.withdrawalRequests).toTitleCase(),
        image: ImagesManager.withdrawalRequests,
        route: Routes.withdrawalRequestsScreen,
        onTap: isAccountActive ? null : (context) {
          Dialogs.showBottomSheetMessage(
            context: context,
            message: Methods.getText(StringsManager.yourAccountIsInactive).toCapitalized(),
          );
        },
        isLock: !isAccountActive,
      ),

      MainModel(
        textAr: Methods.getTextAr(StringsManager.privacyPolicy).toTitleCase(),
        textEn: Methods.getTextEn(StringsManager.privacyPolicy).toTitleCase(),
        image: ImagesManager.privacyPolicy,
        route: Routes.privacyPolicyScreen,
      ),
      MainModel(
        textAr: Methods.getTextAr(StringsManager.termsOfUse).toTitleCase(),
        textEn: Methods.getTextEn(StringsManager.termsOfUse).toTitleCase(),
        image: ImagesManager.termsOfUse,
        route: Routes.termsOfUseScreen,
      ),

      MainModel(
        textAr: Methods.getTextAr(StringsManager.settings).toTitleCase(),
        textEn: Methods.getTextEn(StringsManager.settings).toTitleCase(),
        image: ImagesManager.settings,
        route: Routes.settingsScreen,
      ),
      MainModel(
        textAr: Methods.getTextAr(StringsManager.logout).toTitleCase(),
        textEn: Methods.getTextEn(StringsManager.logout).toTitleCase(),
        image: ImagesManager.logout,
        route: null,
        onTap: (context) {
          Dialogs.showBottomSheetConfirmation(context: context, message: Methods.getText(StringsManager.doYouWantToLogout).toCapitalized()).then((value) {
            if(value) MyProviders.authenticationProvider.logout(context);
          });
        },
      ),
      if(false) MainModel(
        textAr: Methods.getTextAr(StringsManager.sendNotification).toTitleCase(),
        textEn: Methods.getTextEn(StringsManager.sendNotification).toTitleCase(),
        image: ImagesManager.notifications,
        route: Routes.notificationsScreen,
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    accountStatisticsProvider = Provider.of<AccountStatisticsProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async => await accountStatisticsProvider.fetchData());
    const SystemUiOverlayStyle(statusBarColor: ColorsManager.grey1, statusBarIconBrightness: Brightness.dark);
  }

  @override
  Widget build(BuildContext context) {
    _setData();

    return WillPopScope(
      onWillPop: () => Dialogs.showBottomSheetConfirmation(
        context: context,
        message: Methods.getText(StringsManager.doYouWantToExitAnApp).toCapitalized(),
      ),
      child: Consumer<AuthenticationProvider>(
        builder: (context, authenticationProvider, _) {
          return Consumer<AccountStatisticsProvider>(
            builder: (context, accountStatisticsProvider, _) {
              _setData();
              return Consumer<AppProvider>(
                builder: (context, appProvider, _) {
                  return Scaffold(
                    body: CustomFullLoading(
                      isShowLoading: authenticationProvider.isLoading,
                      waitForDone: authenticationProvider.isLoading,
                      isShowOpacityBackground: true,
                      onRefresh: () async {
                        await Future.wait([
                          authenticationProvider.refreshCurrentAccount(),
                          accountStatisticsProvider.reFetchData(),
                        ]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: SizeManager.s16, right: SizeManager.s16, top: SizeManager.s16),
                        child: CustomScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          slivers: [
                            SliverAppBar(
                              systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: ColorsManager.grey1),
                              backgroundColor: ColorsManager.grey1,
                              flexibleSpace: FlexibleSpaceBar(
                                title: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(SizeManager.s0, SizeManager.s0, SizeManager.s60, SizeManager.s0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '${Methods.getText(StringsManager.welcome).toUpperCase()} 👋',
                                        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeightManager.bold),
                                      ),
                                      const SizedBox(height: SizeManager.s5),
                                      Text(
                                        authenticationProvider.currentAccount.fullName,
                                        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeightManager.bold),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              leading: Padding(
                                padding: const EdgeInsets.all(5),
                                child: GestureDetector(
                                  onTap: () => Methods.routeTo(context, Routes.accountProfileScreen, arguments: MyProviders.authenticationProvider.currentAccount),
                                  child: ImageWidget(
                                    image: authenticationProvider.currentAccount.personalImage,
                                    imageDirectory: ApiConstants.accountsDirectory,
                                    defaultImage: ImagesManager.defaultAvatar,
                                    width: SizeManager.s50,
                                    height: SizeManager.s50,
                                    boxShape: BoxShape.circle,
                                    isShowFullImageScreen: false,
                                  ),
                                ),
                              ),
                              actions: [
                                IconButton(
                                  onPressed: () => Methods.routeTo(context, Routes.notificationsScreen),
                                  icon: const Icon(Icons.notifications, size: SizeManager.s30),
                                  padding: EdgeInsets.zero,
                                  visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                ),
                                // badges.Badge(
                                //   onTap: () {},
                                //   showBadge: true,
                                //   badgeContent: Text(
                                //     '0',
                                //     style: Theme.of(context).textTheme.bodySmall!.copyWith(color: ColorsManager.white),
                                //   ),
                                //   child: const Icon(Icons.notifications),
                                // ),
                              ],
                            ),
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: SizeManager.s16),
                                child: Container(
                                  padding: const EdgeInsets.all(SizeManager.s16),
                                  decoration: BoxDecoration(
                                    color: AccountStatus.getColor(MyProviders.authenticationProvider.currentAccount.accountStatus).withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(SizeManager.s10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            Methods.getText(StringsManager.accountStatus).toTitleCase(),
                                            style: Theme.of(context).textTheme.displayMedium!.copyWith(color: ColorsManager.white),
                                          ),
                                          const SizedBox(width: SizeManager.s10),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: SizeManager.s10, vertical: SizeManager.s5),
                                            decoration: BoxDecoration(
                                              color: ColorsManager.white,
                                              borderRadius: BorderRadius.circular(SizeManager.s10),
                                            ),
                                            child: Row(
                                              children: [
                                                Text(
                                                  AccountStatus.toText(MyProviders.authenticationProvider.currentAccount.accountStatus),
                                                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                                    color: AccountStatus.getColor(MyProviders.authenticationProvider.currentAccount.accountStatus),
                                                  ),
                                                ),
                                                const SizedBox(width: SizeManager.s10),
                                                Icon(
                                                  AccountStatus.getIcon(MyProviders.authenticationProvider.currentAccount.accountStatus),
                                                  color: AccountStatus.getColor(MyProviders.authenticationProvider.currentAccount.accountStatus),
                                                  size: SizeManager.s20,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      if(MyProviders.authenticationProvider.currentAccount.accountStatus == AccountStatus.pending) ...[
                                        const SizedBox(height: SizeManager.s10),
                                        CustomButton(
                                          onPressed: () => Methods.routeTo(
                                            context,
                                            Routes.editAccountProfileScreen,
                                            arguments: MyProviders.authenticationProvider.currentAccount,
                                          ),
                                          buttonType: ButtonType.text,
                                          text: Methods.getText(StringsManager.completeYourInformation).toTitleCase(),
                                          width: double.infinity,
                                          height: SizeManager.s40,
                                        ),
                                      ],
                                      if(MyProviders.authenticationProvider.currentAccount.reasonOfReject != null) ...[
                                        const SizedBox(height: SizeManager.s10),
                                        Container(
                                          padding: const EdgeInsets.all(SizeManager.s10),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: ColorsManager.red,
                                            borderRadius: BorderRadius.circular(SizeManager.s10),
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                Methods.getText(StringsManager.reasonOfReject).toCapitalized(),
                                                style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsManager.white),
                                              ),
                                              const SizedBox(height: SizeManager.s10),
                                              Text(
                                                MyProviders.authenticationProvider.currentAccount.reasonOfReject!,
                                                style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsManager.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: SizeManager.s16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Methods.dividerHeight(),
                                        Expanded(
                                          child: Text(
                                            Methods.getText(StringsManager.statistics).toUpperCase(),
                                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: SizeManager.s20, fontWeight: FontWeightManager.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: SizeManager.s10),
                                    MainStatisticsWidget(accountStatisticsProvider: accountStatisticsProvider),
                                  ],
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: SizeManager.s16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Methods.dividerHeight(),
                                        Expanded(
                                          child: Text(
                                            Methods.getText(StringsManager.dashboard).toUpperCase(),
                                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: SizeManager.s20, fontWeight: FontWeightManager.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: SizeManager.s10),
                                    _Content(data: _data),
                                    const SizedBox(height: SizeManager.s20),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    accountStatisticsProvider.setIsScreenDisposed(true);
  }
}

class _Content extends StatelessWidget {
  final List<MainModel> data;

  const _Content({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(SizeManager.s10),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(SizeManager.s10),
      ),
      child: CustomGrid(
        listLength: data.length,
        numberOfItemsInRow: 3,
        child: (index) {
          return Container(
            margin: const EdgeInsets.all(SizeManager.s5),
            child: MainItem(mainModel: data[index]),
          );
        },
      ),
    );
  }
}