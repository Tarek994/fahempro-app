import 'package:fahem_dashboard/core/network/api_constants.dart';
import 'package:fahem_dashboard/core/resources/assets_manager.dart';
import 'package:fahem_dashboard/core/resources/colors_manager.dart';
import 'package:fahem_dashboard/core/resources/fonts_manager.dart';
import 'package:fahem_dashboard/core/resources/routes_manager.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/dialogs.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/core/utilities/my_providers.dart';
import 'package:fahem_dashboard/data/models/static/main_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fahem_dashboard/presentation/main/controllers/admin_statistics_provider.dart';
import 'package:fahem_dashboard/presentation/main/widgets/main_item.dart';
import 'package:fahem_dashboard/presentation/main/widgets/main_statistics_widget.dart';
import 'package:fahem_dashboard/presentation/screens/authentication/controllers/authentication_provider.dart';
import 'package:fahem_dashboard/presentation/shared/controllers/app_provider.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_grid.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/image_widget.dart';
import 'package:badges/badges.dart' as badges;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late AdminStatisticsProvider adminStatisticsProvider;
  List<MainModel> _data = [];

  void _setData() {
    _data = [
      if(Methods.checkAdminPermission(AdminPermissions.showAdmins)) MainModel(
        textAr: Methods.getTextAr(StringsManager.admins).toTitleCase(),
        textEn: Methods.getTextEn(StringsManager.admins).toTitleCase(),
        image: ImagesManager.admins,
        route: Routes.adminsScreen,
      ),
      if(Methods.checkAdminPermission(AdminPermissions.showUsers)) MainModel(
        textAr: Methods.getTextAr(StringsManager.users).toTitleCase(),
        textEn: Methods.getTextEn(StringsManager.users).toTitleCase(),
        image: ImagesManager.users,
        route: Routes.usersScreen,
      ),
      if(Methods.checkAdminPermission(AdminPermissions.showAccounts)) MainModel(
        textAr: Methods.getTextAr(StringsManager.accounts).toTitleCase(),
        textEn: Methods.getTextEn(StringsManager.accounts).toTitleCase(),
        image: ImagesManager.accounts,
        route: Routes.accountsScreen,
      ),

      if(Methods.checkAdminPermission(AdminPermissions.showMainCategories)) MainModel(
        textAr: Methods.getTextAr(StringsManager.mainCategories).toTitleCase(),
        textEn: Methods.getTextEn(StringsManager.mainCategories).toTitleCase(),
        image: ImagesManager.mainCategories,
        route: Routes.mainCategoriesScreen,
      ),
      if(Methods.checkAdminPermission(AdminPermissions.showCategories)) MainModel(
        textAr: Methods.getTextAr(StringsManager.categories).toTitleCase(),
        textEn: Methods.getTextEn(StringsManager.categories).toTitleCase(),
        image: ImagesManager.categories,
        route: Routes.categoriesScreen,
      ),
      if(Methods.checkAdminPermission(AdminPermissions.showServices)) MainModel(
        textAr: Methods.getTextAr(StringsManager.services).toTitleCase(),
        textEn: Methods.getTextEn(StringsManager.services).toTitleCase(),
        image: ImagesManager.services,
        route: Routes.servicesScreen,
      ),

      if(Methods.checkAdminPermission(AdminPermissions.showSliders)) MainModel(
        textAr: Methods.getTextAr(StringsManager.sliders).toTitleCase(),
        textEn: Methods.getTextEn(StringsManager.sliders).toTitleCase(),
        image: ImagesManager.sliders,
        route: Routes.slidersScreen,
      ),
      // if(Methods.checkAdminPermission(AdminPermissions.showArticles)) MainModel(
      //   textAr: Methods.getTextAr(StringsManager.articles).toTitleCase(),
      //   textEn: Methods.getTextEn(StringsManager.articles).toTitleCase(),
      //   image: ImagesManager.articles,
      //   route: Routes.articlesScreen,
      // ),
      // if(Methods.checkAdminPermission(AdminPermissions.showFaqs)) MainModel(
      //   textAr: Methods.getTextAr(StringsManager.faqs).toTitleCase(),
      //   textEn: Methods.getTextEn(StringsManager.faqs).toTitleCase(),
      //   image: ImagesManager.faqs,
      //   route: Routes.faqsScreen,
      // ),

      if(Methods.checkAdminPermission(AdminPermissions.showJobs)) MainModel(
        textAr: Methods.getTextAr(StringsManager.jobs).toTitleCase(),
        textEn: Methods.getTextEn(StringsManager.jobs).toTitleCase(),
        image: ImagesManager.jobs,
        route: Routes.jobsScreen,
      ),
      if(Methods.checkAdminPermission(AdminPermissions.showEmploymentApplications)) MainModel(
        textAr: Methods.getTextAr(StringsManager.employmentApplications).toTitleCase(),
        textEn: Methods.getTextEn(StringsManager.employmentApplications).toTitleCase(),
        image: ImagesManager.employmentApplications,
        route: Routes.employmentApplicationsScreen,
      ),
      // if(Methods.checkAdminPermission(AdminPermissions.showComplaints)) MainModel(
      //   textAr: Methods.getTextAr(StringsManager.complaints).toTitleCase(),
      //   textEn: Methods.getTextEn(StringsManager.complaints).toTitleCase(),
      //   image: ImagesManager.complaints,
      //   route: Routes.complaintsScreen,
      // ),

      if(Methods.checkAdminPermission(AdminPermissions.showReviews)) MainModel(
        textAr: Methods.getTextAr(StringsManager.reviews).toTitleCase(),
        textEn: Methods.getTextEn(StringsManager.reviews).toTitleCase(),
        image: ImagesManager.reviews,
        route: Routes.reviewsScreen,
      ),
      if(Methods.checkAdminPermission(AdminPermissions.showFeatures)) MainModel(
        textAr: Methods.getTextAr(StringsManager.features).toTitleCase(),
        textEn: Methods.getTextEn(StringsManager.features).toTitleCase(),
        image: ImagesManager.features,
        route: Routes.featuresScreen,
      ),
      if(Methods.checkAdminPermission(AdminPermissions.showSocialMedia)) MainModel(
        textAr: Methods.getTextAr(StringsManager.socialMedia).toTitleCase(),
        textEn: Methods.getTextEn(StringsManager.socialMedia).toTitleCase(),
        image: ImagesManager.socialMedia,
        route: Routes.socialMediaScreen,
      ),

      if(Methods.checkAdminPermission(AdminPermissions.showPlaylists)) MainModel(
        textAr: Methods.getTextAr(StringsManager.playlists).toTitleCase(),
        textEn: Methods.getTextEn(StringsManager.playlists).toTitleCase(),
        image: ImagesManager.playlists,
        route: Routes.playlistsScreen,
      ),
      if(Methods.checkAdminPermission(AdminPermissions.showVideos)) MainModel(
        textAr: Methods.getTextAr(StringsManager.videos).toTitleCase(),
        textEn: Methods.getTextEn(StringsManager.videos).toTitleCase(),
        image: ImagesManager.videos,
        route: Routes.videosScreen,
      ),
      if(Methods.checkAdminPermission(AdminPermissions.showPlaylistsComments)) MainModel(
        textAr: Methods.getTextAr(StringsManager.playlistsComments).toTitleCase(),
        textEn: Methods.getTextEn(StringsManager.playlistsComments).toTitleCase(),
        image: ImagesManager.playlistsComments,
        route: Routes.playlistsCommentsScreen,
      ),

      if(Methods.checkAdminPermission(AdminPermissions.showPhoneNumberRequests)) MainModel(
        textAr: Methods.getTextAr(StringsManager.phoneNumberRequests).toTitleCase(),
        textEn: Methods.getTextEn(StringsManager.phoneNumberRequests).toTitleCase(),
        image: ImagesManager.phoneNumberRequests,
        route: Routes.phoneNumberRequestsScreen,
      ),
      if(Methods.checkAdminPermission(AdminPermissions.showBookingAppointments)) MainModel(
        textAr: Methods.getTextAr(StringsManager.bookingAppointments).toTitleCase(),
        textEn: Methods.getTextEn(StringsManager.bookingAppointments).toTitleCase(),
        image: ImagesManager.bookingAppointments,
        route: Routes.bookingAppointmentsScreen,
      ),
      if(Methods.checkAdminPermission(AdminPermissions.showInstantConsultations)) MainModel(
        textAr: Methods.getTextAr(StringsManager.instantConsultations).toTitleCase(),
        textEn: Methods.getTextEn(StringsManager.instantConsultations).toTitleCase(),
        image: ImagesManager.instantConsultations,
        route: Routes.instantConsultationsScreen,
      ),

      if(Methods.checkAdminPermission(AdminPermissions.showInstantConsultationComments)) MainModel(
        textAr: Methods.getTextAr(StringsManager.instantConsultationsComments).toTitleCase(),
        textEn: Methods.getTextEn(StringsManager.instantConsultationsComments).toTitleCase(),
        image: ImagesManager.instantConsultationsComments,
        route: Routes.instantConsultationsCommentsScreen,
      ),
      if(Methods.checkAdminPermission(AdminPermissions.showSecretConsultations)) MainModel(
        textAr: Methods.getTextAr(StringsManager.secretConsultations).toTitleCase(),
        textEn: Methods.getTextEn(StringsManager.secretConsultations).toTitleCase(),
        image: ImagesManager.secretConsultations,
        route: Routes.secretConsultationsScreen,
      ),

      if(Methods.checkAdminPermission(AdminPermissions.showSuggestedMessages)) MainModel(
        textAr: Methods.getTextAr(StringsManager.suggestedMessages).toTitleCase(),
        textEn: Methods.getTextEn(StringsManager.suggestedMessages).toTitleCase(),
        image: ImagesManager.suggestedMessages,
        route: Routes.suggestedMessagesScreen,
      ),
      if(Methods.checkAdminPermission(AdminPermissions.showWalletHistory)) MainModel(
        textAr: Methods.getTextAr(StringsManager.walletHistory).toTitleCase(),
        textEn: Methods.getTextEn(StringsManager.walletHistory).toTitleCase(),
        image: ImagesManager.walletHistory,
        route: Routes.walletHistoryScreen,
      ),
      if(Methods.checkAdminPermission(AdminPermissions.showWithdrawalRequests)) MainModel(
        textAr: Methods.getTextAr(StringsManager.withdrawalRequests).toTitleCase(),
        textEn: Methods.getTextEn(StringsManager.withdrawalRequests).toTitleCase(),
        image: ImagesManager.withdrawalRequests,
        route: Routes.withdrawalRequestsScreen,
      ),

      if(Methods.checkAdminPermission(AdminPermissions.showFinancialAccounts)) MainModel(
        textAr: Methods.getTextAr(StringsManager.financialAccounts).toTitleCase(),
        textEn: Methods.getTextEn(StringsManager.financialAccounts).toTitleCase(),
        image: ImagesManager.withdrawalRequests,
        route: Routes.financialAccountsScreen,
        arguments: adminStatisticsProvider.adminStatistics,
      ),

      // if(Methods.checkAdminPermission(AdminPermissions.showAboutApp)) MainModel(
      //   textAr: Methods.getTextAr(StringsManager.aboutApp).toTitleCase(),
      //   textEn: Methods.getTextEn(StringsManager.aboutApp).toTitleCase(),
      //   image: ImagesManager.aboutApp,
      //   route: Routes.aboutAppScreen,
      // ),
      // if(Methods.checkAdminPermission(AdminPermissions.showServiceDescription)) MainModel(
      //   textAr: Methods.getTextAr(StringsManager.serviceDescription).toTitleCase(),
      //   textEn: Methods.getTextEn(StringsManager.serviceDescription).toTitleCase(),
      //   image: ImagesManager.serviceDescription,
      //   route: Routes.serviceDescriptionScreen,
      // ),
      if(Methods.checkAdminPermission(AdminPermissions.showPrivacyPolicy)) MainModel(
        textAr: Methods.getTextAr(StringsManager.privacyPolicy).toTitleCase(),
        textEn: Methods.getTextEn(StringsManager.privacyPolicy).toTitleCase(),
        image: ImagesManager.privacyPolicy,
        route: Routes.privacyPolicyScreen,
      ),
      if(Methods.checkAdminPermission(AdminPermissions.showTermsOfUse)) MainModel(
        textAr: Methods.getTextAr(StringsManager.termsOfUse).toTitleCase(),
        textEn: Methods.getTextEn(StringsManager.termsOfUse).toTitleCase(),
        image: ImagesManager.termsOfUse,
        route: Routes.termsOfUseScreen,
      ),
      if(Methods.checkAdminPermission(AdminPermissions.showChats)) MainModel(
        textAr: Methods.getText(StringsManager.chats).toTitleCase(),
        textEn: Methods.getText(StringsManager.chats).toTitleCase(),
        image: ImagesManager.chats,
        route: Routes.chatsRoute,
      ),
      if(Methods.checkAdminPermission(AdminPermissions.sendNotifications)) MainModel(
        textAr: Methods.getTextAr(StringsManager.sendNotification).toTitleCase(),
        textEn: Methods.getTextEn(StringsManager.sendNotification).toTitleCase(),
        image: ImagesManager.notifications,
        route: Routes.sendNotificationScreen,
      ),
      if(Methods.checkAdminPermission(AdminPermissions.controlSettings)) MainModel(
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
    ];
  }

  @override
  void initState() {
    super.initState();
    adminStatisticsProvider = Provider.of<AdminStatisticsProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async => await adminStatisticsProvider.fetchData());
    const SystemUiOverlayStyle(statusBarColor: ColorsManager.grey1, statusBarIconBrightness: Brightness.dark);
  }

  @override
  Widget build(BuildContext context) {
    _setData();

    return WillPopScope(
      onWillPop: () => Dialogs.showBottomSheetConfirmation(context: context, message: Methods.getText(StringsManager.doYouWantToExitAnApp).toCapitalized()),
      child: Consumer<AuthenticationProvider>(
        builder: (context, authenticationProvider, _) {
          return Consumer<AdminStatisticsProvider>(
            builder: (context, adminStatisticsProvider, _) {
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
                          authenticationProvider.refreshCurrentAdmin(),
                          adminStatisticsProvider.reFetchData(),
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
                                        authenticationProvider.currentAdmin.fullName,
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
                                  onTap: () => Methods.routeTo(context, Routes.adminProfileScreen, arguments: MyProviders.authenticationProvider.currentAdmin),
                                  child: ImageWidget(
                                    image: authenticationProvider.currentAdmin.personalImage,
                                    imageDirectory: ApiConstants.adminsDirectory,
                                    defaultImage: ImagesManager.defaultAvatar,
                                    width: SizeManager.s50,
                                    height: SizeManager.s50,
                                    boxShape: BoxShape.circle,
                                    isShowFullImageScreen: false,
                                  ),
                                ),
                              ),
                              actions: [
                                if(Methods.checkAdminPermission(AdminPermissions.showNotifications)) IconButton(
                                  onPressed: () => Methods.routeTo(context, Routes.adminNotificationsScreen),
                                  icon: const Icon(Icons.notifications, size: SizeManager.s30),
                                  padding: EdgeInsets.zero,
                                  visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                ),
                                // badges.Badge(
                                //   onTap: () => Methods.routeTo(context, Routes.adminNotificationsScreen),
                                //   showBadge: false,
                                //   // badgeContent: Text(
                                //   //   '',
                                //   //   style: Theme.of(context).textTheme.bodySmall!.copyWith(color: ColorsManager.white),
                                //   // ),
                                //   child: const Icon(Icons.notifications, size: SizeManager.s30),
                                // ),
                              ],
                            ),
                            if(Methods.checkAdminPermission(AdminPermissions.showStatistics)) SliverToBoxAdapter(
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
                                    MainStatisticsWidget(adminStatisticsProvider: adminStatisticsProvider),
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
    adminStatisticsProvider.setIsScreenDisposed(true);
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