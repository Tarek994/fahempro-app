import 'package:fahem_dashboard/core/network/api_constants.dart';
import 'package:fahem_dashboard/core/resources/assets_manager.dart';
import 'package:fahem_dashboard/core/resources/fonts_manager.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/core/utilities/my_providers.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/card_info.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/default_sliver_app_bar.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/image_widget.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/name_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fahem_dashboard/core/resources/colors_manager.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';

// class UserProfileScreen extends StatefulWidget {
//   final UserModel userModel;
//
//   const UserProfileScreen({
//     super.key,
//     required this.userModel,
//   });
//
//   @override
//   State<UserProfileScreen> createState() => _UserProfileScreenState();
// }
//
// class _UserProfileScreenState extends State<UserProfileScreen> {
//   late UserProfileProvider userProfileProvider;
//
//   @override
//   void initState() {
//     super.initState();
//     userProfileProvider = Provider.of<UserProfileProvider>(context, listen: false);
//     userProfileProvider.userJobsAddListenerScrollController(userId: widget.userModel.userId);
//     // userProfileProvider.userSeekersAddListenerScrollController(userId: widget.userModel.userId);
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       await Future.wait([
//         userProfileProvider.fetchUserJobs(userId: widget.userModel.userId),
//         // userProfileProvider.fetchUserSeekers(userId: widget.userModel.userId)
//       ]);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<UserProfileProvider>(
//       builder: (context, provider, _) {
//         if(provider.currentUserProfilePage == UserProfilePages.userJobs) {
//           return TemplateListScreen(
//             reFetchData: () async {
//               await Future.wait([
//                 provider.reFetchUserJobs(userId: widget.userModel.userId),
//               ]);
//             },
//             scrollController: provider.userJobsScrollController,
//             goToInsertScreen: null,
//             title: widget.userModel.fullName,
//             appBarColor: ColorsManager.white,
//             searchFilterOrderWidget: null,
//             isDataNotEmpty: provider.userJobs.isNotEmpty,
//             dataCount: provider.userJobs.length,
//             totalResults: provider.userJobsPaginationModel == null ? 0 : provider.userJobsPaginationModel!.total,
//             supportedViewStyle: const [ViewStyle.list],
//             currentViewStyle: provider.userJobsViewStyle,
//             changeViewStyleToList: () => provider.changeUserJobsViewStyle(ViewStyle.list),
//             changeViewStyleToGrid: () => provider.changeUserJobsViewStyle(ViewStyle.grid),
//             // listItemBuilder: (context, index) => JobListItem(jobModel: provider.userJobs[index]),
//             // gridItemBuilder: (context, index) => JobGridItem(jobModel: provider.userJobs[index]),
//             listItemBuilder: (context, index) => null,
//             gridItemBuilder: (context, index) => null,
//             itemHeightInGrid: SizeManager.s260,
//             dataState: provider.userJobsDataState,
//             hasMore: provider.userJobsHasMore,
//             noDataMsgInScreen: StringsManager.thereAreNo,
//             extraWidget: ExtraWidgetInUserProfile(userModel: widget.userModel),
//           );
//         }
//         else {
//           return const SizedBox();
//           // return TemplateListScreen(
//           //   reFetchData: () async {
//           //     await Future.wait([
//           //       provider.reFetchUserSeekers(userId: widget.userModel.userId),
//           //     ]);
//           //   },
//           //   scrollController: provider.userSeekersScrollController,
//           //   goToInsertScreen: null,
//           //   screenTitle: StringsManager.advertiserPage,
//           //   appBarColor: ColorsManager.white,
//           //   searchFilterOrderWidget: null,
//           //   isDataNotEmpty: provider.userSeekers.isNotEmpty,
//           //   dataCount: provider.userSeekers.length,
//           //   totalResults: provider.userSeekersPaginationModel == null ? 0 : provider.userSeekersPaginationModel!.total,
//           //   supportedViewStyle: const [ViewStyle.list],
//           //   currentViewStyle: provider.userSeekersViewStyle,
//           //   changeViewStyleToList: () => provider.changeUserSeekersViewStyle(ViewStyle.list),
//           //   changeViewStyleToGrid: () => provider.changeUserSeekersViewStyle(ViewStyle.grid),
//           //   listItemBuilder: (context, index) => SeekerListItem(seekerModel: provider.userSeekers[index]),
//           //   gridItemBuilder: (context, index) => SeekerGridItem(seekerModel: provider.userSeekers[index]),
//           //   itemHeightInGrid: SizeManager.s300,
//           //   dataState: provider.userSeekersDataState,
//           //   hasMore: provider.userSeekersHasMore,
//           //   noDataMsgInScreen: StringsManager.thereAreNoAds,
//           //   extraWidget: ExtraWidgetInUserProfile(userModel: widget.userModel),
//           // );
//         }
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     userProfileProvider.setIsScreenDisposed(true);
//     userProfileProvider.userJobsScrollController.dispose();
//     // userProfileProvider.userSeekersScrollController.dispose();
//   }
// }

class UserProfileScreen extends StatelessWidget {
  final UserModel userModel;

  const UserProfileScreen({
    super.key,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomFullLoading(
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            DefaultSliverAppBar(customTitle: userModel.fullName),
            SliverToBoxAdapter(
              child: Column(
                children: [

                  // Images
                  SizedBox(
                    width: double.infinity,
                    height: SizeManager.s260,
                    child: Stack(
                      children: [
                        ImageWidget(
                          image: userModel.coverImage,
                          imageDirectory: ApiConstants.usersDirectory,
                          color1: userModel.coverImage == null ? ColorsManager.white : null,
                          width: double.infinity,
                          height: SizeManager.s200,
                          isShowFullImageScreen: true,
                        ),
                        Align(
                          alignment: AlignmentDirectional.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: SizeManager.s16),
                            child: ImageWidget(
                              image: userModel.personalImage,
                              imageDirectory: ApiConstants.usersDirectory,
                              defaultImage: ImagesManager.defaultAvatar,
                              width: SizeManager.s120,
                              height: SizeManager.s120,
                              boxShape: BoxShape.circle,
                              isBorderAroundImage: true,
                              isShowFullImageScreen: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: SizeManager.s20),

                  // Name
                  NameWidget(
                    fullName: userModel.fullName,
                    isFeatured: userModel.isFeatured,
                    isSupportFeatured: true,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeightManager.semiBold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: SizeManager.s20),

                  // Info
                  Padding(
                    padding: const EdgeInsets.only(left: SizeManager.s16, right: SizeManager.s16, bottom: SizeManager.s16),
                    child: Column(
                      children: [
                        if(userModel.phoneNumber != null) ...[
                          CardInfo(
                            icon: FontAwesomeIcons.phone,
                            title: Methods.getText(StringsManager.phoneNumber).toTitleCase(),
                            value: userModel.phoneNumber,
                            spacerText: userModel.dialingCode,
                          ),
                          const SizedBox(height: SizeManager.s10),
                        ],
                        if(userModel.country != null) ...[
                          CardInfo(
                            icon: FontAwesomeIcons.locationDot,
                            title: Methods.getText(StringsManager.country).toTitleCase(),
                            value: MyProviders.appProvider.isEnglish ? userModel.country!.countryNameEn : userModel.country!.countryNameAr,
                            spacerImage: userModel.country!.flag,
                          ),
                          const SizedBox(height: SizeManager.s10),
                        ],
                        if(userModel.birthDate != null) ...[
                          CardInfo(
                            icon: FontAwesomeIcons.calendar,
                            title: Methods.getText(StringsManager.birthDate).toTitleCase(),
                            value: Methods.formatDate(milliseconds: int.parse(userModel.birthDate!), format: 'd MMMM yyyy'),
                          ),
                          const SizedBox(height: SizeManager.s10),
                        ],
                        if(userModel.gender != null) ...[
                          CardInfo(
                            icon: FontAwesomeIcons.venusMars,
                            title: Methods.getText(StringsManager.gender).toTitleCase(),
                            value: Gender.toText(userModel.gender!),
                          ),
                          const SizedBox(height: SizeManager.s10),
                        ],
                        CardInfo(
                          icon: FontAwesomeIcons.calendar,
                          title: Methods.getText(StringsManager.joinDate).toTitleCase(),
                          value: Methods.formatDate(milliseconds: int.parse(userModel.createdAt), format: 'd MMMM yyyy'),
                        ),
                        const SizedBox(height: SizeManager.s10),
                        CardInfo(
                          icon: FontAwesomeIcons.coins,
                          title: Methods.getText(StringsManager.accountBalance).toTitleCase(),
                          value: '${userModel.balance} ${Methods.getText(StringsManager.egp).toTitleCase()}',
                        ),
                        const SizedBox(height: SizeManager.s10),
                        if(userModel.bio != null) ...[
                          CardInfo(
                            icon: FontAwesomeIcons.info,
                            title: Methods.getText(StringsManager.bio).toTitleCase(),
                            value: userModel.bio ?? Methods.getText(StringsManager.notFound).toTitleCase(),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}