// import 'package:fahem/core/resources/assets_manager.dart';
// import 'package:fahem/core/resources/colors_manager.dart';
// import 'package:fahem/core/resources/routes_manager.dart';
// import 'package:fahem/core/utilities/dialogs.dart';
// import 'package:fahem/core/utilities/my_providers.dart';
// import 'package:fahem/data/models/user_model.dart';
// import 'package:fahem/presentation/screens/authentication/controllers/authentication_provider.dart';
// import 'package:fahem/presentation/shared/widgets/custom/custom_button.dart';
// import 'package:fahem/presentation/shared/widgets/default_sliver_app_bar.dart';
// import 'package:fahem/presentation/shared/widgets/name_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:fahem/core/network/api_constants.dart';
// import 'package:fahem/core/resources/fonts_manager.dart';
// import 'package:fahem/core/resources/strings_manager.dart';
// import 'package:fahem/core/resources/values_manager.dart';
// import 'package:fahem/core/utilities/enums.dart';
// import 'package:fahem/core/utilities/extensions.dart';
// import 'package:fahem/core/utilities/methods.dart';
// import 'package:fahem/presentation/shared/widgets/card_info.dart';
// import 'package:fahem/presentation/shared/widgets/custom/custom_full_loading.dart';
// import 'package:fahem/presentation/shared/widgets/image_widget.dart';
// import 'package:provider/provider.dart';
//
// class UserProfileScreen extends StatelessWidget {
//   const UserProfileScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final UserModel userModel = MyProviders.authenticationProvider.currentUser;
//     return Consumer<AuthenticationProvider>(
//       builder: (context, authenticationProvider, child) {
//         return Scaffold(
//           body: CustomFullLoading(
//             waitForDone: authenticationProvider.isLoading,
//             isShowLoading: authenticationProvider.isLoading,
//             isShowOpacityBackground: true,
//             child: CustomScrollView(
//               physics: const AlwaysScrollableScrollPhysics(),
//               slivers: [
//                 DefaultSliverAppBar(customTitle: userModel.fullName),
//                 SliverToBoxAdapter(
//                   child: Column(
//                     children: [
//                       // Images
//                       SizedBox(
//                         width: double.infinity,
//                         height: SizeManager.s260,
//                         child: Stack(
//                           children: [
//                             ImageWidget(
//                               image: userModel.coverImage,
//                               imageDirectory: ApiConstants.usersDirectory,
//                               color1: userModel.coverImage == null ? ColorsManager.white : null,
//                               width: double.infinity,
//                               height: SizeManager.s200,
//                               isShowFullImageScreen: true,
//                             ),
//                             Align(
//                               alignment: AlignmentDirectional.bottomCenter,
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: SizeManager.s16),
//                                 child: ImageWidget(
//                                   image: userModel.personalImage,
//                                   imageDirectory: ApiConstants.usersDirectory,
//                                   defaultImage: ImagesManager.defaultAvatar,
//                                   width: SizeManager.s120,
//                                   height: SizeManager.s120,
//                                   boxShape: BoxShape.circle,
//                                   isBorderAroundImage: true,
//                                   isShowFullImageScreen: true,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: SizeManager.s20),
//
//                       // Name
//                       NameWidget(
//                         fullName: userModel.fullName,
//                         isFeatured: userModel.isFeatured,
//                         isSupportFeatured: true,
//                         style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeightManager.semiBold),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: SizeManager.s20),
//
//                       // Edit User
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: SizeManager.s16),
//                         child: CustomButton(
//                           onPressed: () => Methods.routeTo(context, Routes.editUserProfileScreen, arguments: authenticationProvider.currentUser),
//                           buttonType: ButtonType.postSpacerIcon,
//                           text: Methods.getText(StringsManager.editProfile).toCapitalized(),
//                           iconData: Icons.edit,
//                           buttonColor: ColorsManager.lightSecondaryColor,
//                           width: double.infinity,
//                         ),
//                       ),
//                       const SizedBox(height: SizeManager.s10),
//
//                       // Change Password
//                       if(authenticationProvider.currentUser.signInMethod == SignInMethod.emailAndPassword) ...[
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: SizeManager.s16),
//                           child: CustomButton(
//                             onPressed: () => Methods.routeTo(context, Routes.changePasswordScreen),
//                             buttonType: ButtonType.postSpacerIcon,
//                             text: Methods.getText(StringsManager.changePassword).toCapitalized(),
//                             iconData: Icons.password,
//                             buttonColor: ColorsManager.lightSecondaryColor,
//                             width: double.infinity,
//                           ),
//                         ),
//                         const SizedBox(height: SizeManager.s10),
//                       ],
//
//                       // Delete User
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: SizeManager.s16),
//                         child: CustomButton(
//                           onPressed: () => Dialogs.showBottomSheetConfirmation(
//                             context: context,
//                             message: Methods.getText(StringsManager.doYouWantToDeleteTheAccount).toCapitalized(),
//                           ).then((value) async {
//                             if (value) {
//                               await MyProviders.authenticationProvider.deleteUser(context);
//                             }
//                           }),
//                           buttonType: ButtonType.postSpacerIcon,
//                           text: Methods.getText(StringsManager.deleteAccount).toCapitalized(),
//                           iconData: Icons.delete,
//                           buttonColor: ColorsManager.lightSecondaryColor,
//                           width: double.infinity,
//                         ),
//                       ),
//                       const SizedBox(height: SizeManager.s10),
//
//                       // Logout
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: SizeManager.s16),
//                         child: CustomButton(
//                           onPressed: () => Dialogs.showBottomSheetConfirmation(
//                             context: context,
//                             message: Methods.getText(StringsManager.doYouWantToLogout).toCapitalized(),
//                           ).then((value) {
//                             if(value) MyProviders.authenticationProvider.logout(context);
//                           }),
//                           buttonType: ButtonType.postSpacerImage,
//                           text: Methods.getText(StringsManager.logout).toCapitalized(),
//                           imageName: IconsManager.logout,
//                           buttonColor: ColorsManager.lightSecondaryColor,
//                           width: double.infinity,
//                           imageColor: ColorsManager.white,
//                         ),
//                       ),
//                       const SizedBox(height: SizeManager.s20),
//
//                       // Info
//                       Padding(
//                         padding: const EdgeInsets.only(left: SizeManager.s16, right: SizeManager.s16, bottom: SizeManager.s16),
//                         child: Column(
//                           children: [
//                             CardInfo(
//                               icon: FontAwesomeIcons.envelope,
//                               title: Methods.getText(StringsManager.emailAddress).toTitleCase(),
//                               value: userModel.emailAddress,
//                             ),
//                             const SizedBox(height: SizeManager.s10),
//                             if(userModel.phoneNumber != null) ...[
//                               CardInfo(
//                                 icon: FontAwesomeIcons.phone,
//                                 title: Methods.getText(StringsManager.phoneNumber).toTitleCase(),
//                                 value: userModel.phoneNumber,
//                                 spacerImage: FlagsImagesManager.egyptFlag,
//                               ),
//                               const SizedBox(height: SizeManager.s10),
//                             ],
//                             if(userModel.birthDate != null) ...[
//                               CardInfo(
//                                 icon: FontAwesomeIcons.calendar,
//                                 title: Methods.getText(StringsManager.birthDate).toTitleCase(),
//                                 value: Methods.formatDate(milliseconds: int.parse(userModel.birthDate!), format: 'd MMMM yyyy'),
//                               ),
//                               const SizedBox(height: SizeManager.s10),
//                             ],
//                             if(userModel.gender != null) ...[
//                               CardInfo(
//                                 icon: FontAwesomeIcons.venusMars,
//                                 title: Methods.getText(StringsManager.gender).toTitleCase(),
//                                 value: Gender.toText(userModel.gender!),
//                               ),
//                               const SizedBox(height: SizeManager.s10),
//                             ],
//                             CardInfo(
//                               icon: FontAwesomeIcons.coins,
//                               title: Methods.getText(StringsManager.balance).toTitleCase(),
//                               value: '${userModel.balance} ${Methods.getText(StringsManager.egp).toTitleCase()}',
//                             ),
//                             const SizedBox(height: SizeManager.s10),
//                             const SizedBox(height: SizeManager.s10),
//                             CardInfo(
//                               icon: FontAwesomeIcons.calendar,
//                               title: Methods.getText(StringsManager.joinDate).toTitleCase(),
//                               value: Methods.formatDate(milliseconds: int.parse(userModel.createdAt), format: 'd MMMM yyyy'),
//                             ),
//                             const SizedBox(height: SizeManager.s10),
//                             if(userModel.bio != null) ...[
//                               CardInfo(
//                                 icon: FontAwesomeIcons.info,
//                                 title: Methods.getText(StringsManager.bio).toTitleCase(),
//                                 value: userModel.bio,
//                               ),
//                               const SizedBox(height: SizeManager.s10),
//                             ],
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }