import 'package:fahem/core/network/api_constants.dart';
import 'package:fahem/core/resources/assets_manager.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/constants_manager.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/dependency_injection.dart';
import 'package:fahem/core/utilities/dialogs.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/core/utilities/validator.dart';
import 'package:fahem/data/models/account_model.dart';
import 'package:fahem/data/models/review_model.dart';
import 'package:fahem/domain/usecases/reviews/insert_review_usecase.dart';
import 'package:fahem/presentation/screens/accounts/controllers/account_details_provider.dart';
import 'package:fahem/presentation/screens/accounts/widgets/extra_widget_in_top.dart';
import 'package:fahem/presentation/screens/accounts/widgets/review_list_item.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_text_form_field.dart';
import 'package:fahem/presentation/shared/widgets/default_sliver_app_bar.dart';
import 'package:fahem/presentation/shared/widgets/image_widget.dart';
import 'package:fahem/presentation/shared/widgets/name_widget.dart';
import 'package:fahem/presentation/shared/widgets/rating_bar.dart';
import 'package:fahem/presentation/shared/widgets/template_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

// class AccountDetailsScreen extends StatefulWidget {
//
//   const AccountDetailsScreen({super.key});
//
//   @override
//   State<AccountDetailsScreen> createState() => _AccountDetailsScreenState();
// }
//
// class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
//
//   // bool isShowReviewButton() {
//   //   for(int i=0; i<transactionsProvider.transactions.length; i++) {
//   //     if(
//   //     widget.accountModel.lawyerId == transactionsProvider.transactions[i].targetId
//   //         && (transactionsProvider.transactions[i].transactionType == TransactionType.showLawyerNumber || transactionsProvider.transactions[i].transactionType == TransactionType.appointmentBookingWithLawyer)
//   //     ) {
//   //       return true;
//   //     }
//   //   }
//   //   return false;
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: Methods.getDirection(),
//       child: Scaffold(
//         body: CustomScrollView(
//           slivers: [
//             const DefaultSliverAppBar(title: StringsManager.theData),
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding: const EdgeInsets.all(SizeManager.s16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         ImageWidget(
//                           image: provider.accountModel.personalImage,
//                           imageDirectory: ApiConstants.accountsDirectory,
//                           defaultImage: ImagesManager.defaultAvatar,
//                           width: SizeManager.s100,
//                           height: SizeManager.s100,
//                           boxShape: BoxShape.circle,
//                           isShowFullImageScreen: true,
//                         ),
//                         const SizedBox(width: SizeManager.s10),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const SizedBox(height: SizeManager.s10),
//                               NameWidget(
//                                 fullName: widget.accountModel.fullName,
//                                 isFeatured: widget.accountModel.isFeatured,
//                                 isSupportFeatured: true,
//                                 verifiedColor: ColorsManager.blue,
//                               ),
//                               const SizedBox(height: SizeManager.s10),
//                               if(widget.accountModel.jobTitle != null) ...[
//                                 Text(
//                                   widget.accountModel.jobTitle!,
//                                   style: Theme.of(context).textTheme.bodySmall,
//                                 ),
//                                 const SizedBox(height: SizeManager.s10),
//                               ],
//                               Row(
//                                 children: [
//                                   RatingBar(numberOfStars: widget.accountModel.rating, starSize: SizeManager.s12, padding: SizeManager.s1),
//                                   const SizedBox(width: SizeManager.s10),
//                                   Expanded(
//                                     child: Text(
//                                       '${Methods.getText(StringsManager.overallRatingOf).toCapitalized()} ${widget.accountModel.numberOfUsersReviews} ${Methods.getText(StringsManager.user)}',
//                                       style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsManager.grey),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: SizeManager.s10),
//                               if(widget.accountModel.bio != null) ...[
//                                 ReadMoreText(
//                                   widget.accountModel.bio!,
//                                   trimMode: TrimMode.Line,
//                                   trimLines: 3,
//                                   trimCollapsedText: Methods.getText(StringsManager.showMore).toCapitalized(),
//                                   trimExpandedText: ' ${Methods.getText(StringsManager.showLess).toCapitalized()}',
//                                   style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: SizeManager.s1_8),
//                                   moreStyle: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeightManager.bold),
//                                   lessStyle: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeightManager.bold),
//                                 ),
//                                 const SizedBox(height: SizeManager.s20),
//                               ],
//                               Wrap(
//                                 spacing: SizeManager.s5,
//                                 runSpacing: SizeManager.s5,
//                                 children: List.generate(widget.accountModel.features.length, (index) {
//                                   return Container(
//                                     padding: const EdgeInsets.all(SizeManager.s5),
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(SizeManager.s5),
//                                       border: Border.all(color: ColorsManager.lightSecondaryColor),
//                                     ),
//                                     child: Text(
//                                       widget.accountModel.features[index],
//                                       style: Theme.of(context).textTheme.displaySmall!.copyWith(
//                                         fontSize: SizeManager.s10,
//                                         color: ColorsManager.lightSecondaryColor,
//                                       ),
//                                     ),
//                                   );
//                                 }),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     const Divider(color: ColorsManager.grey),
//                     if(widget.accountModel.tasks.isNotEmpty) ...[
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Image.asset(IconsManager.clipboard, color: ColorsManager.lightPrimaryColor, width: SizeManager.s20, height: SizeManager.s20),
//                           const SizedBox(width: SizeManager.s10),
//                           Expanded(
//                             child: Wrap(
//                               children: List.generate(widget.accountModel.tasks.length, (index) {
//                                 return Text(
//                                   '${widget.accountModel.tasks[index]} ${index == widget.accountModel.tasks.length-1 ? '' : '-'} ',
//                                   style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: SizeManager.s1_8),
//                                 );
//                               }),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: SizeManager.s10),
//                     ],
//                     if(widget.accountModel.address != null) ...[
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Image.asset(IconsManager.map, color: ColorsManager.lightPrimaryColor, width: SizeManager.s20, height: SizeManager.s20),
//                           const SizedBox(width: SizeManager.s10),
//                           Expanded(
//                             child: Text(
//                               widget.accountModel.address!,
//                               style: Theme.of(context).textTheme.bodyMedium,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: SizeManager.s10),
//                     ],
//                     if(widget.accountModel.consultationPrice != null) ...[
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Image.asset(IconsManager.money, color: ColorsManager.lightPrimaryColor, width: SizeManager.s20, height: SizeManager.s20),
//                           const SizedBox(width: SizeManager.s10),
//                           Text(
//                             '${Methods.getText(StringsManager.consultationPrice).toCapitalized()}: ${widget.accountModel.consultationPrice} ${Methods.getText(StringsManager.egp).toUpperCase()}',
//                             style: Theme.of(context).textTheme.bodySmall,
//                           ),
//                         ],
//                       ),
//                     ],
//                     const Divider(color: ColorsManager.grey),
//                     Text(
//                       Methods.getText(
//                         widget.accountModel.isBookingByAppointment && widget.accountModel.availablePeriods.isNotEmpty
//                             ? StringsManager.chooseYourConsultationAppointment
//                             : StringsManager.callNow,
//                       ).toTitleCase(),
//                       style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeightManager.semiBold),
//                     ),
//                     const SizedBox(height: SizeManager.s10),
//                     Row(
//                       children: [
//                         if(widget.accountModel.phoneNumber != null) Expanded(
//                           child: CustomButton(
//                             buttonType: ButtonType.postImage,
//                             onPressed: () {
//                               if(MyProviders.authenticationProvider.currentUser == null) {
//                                 Dialogs.showBottomSheetConfirmation(
//                                   context: context,
//                                   message: Methods.getText(StringsManager.youMustLoginFirstToAccessTheService).toCapitalized(),
//                                 ).then((value) async {
//                                   if(value) {
//                                     Navigator.pushNamed(context, Routes.loginWithPhoneScreen);
//                                   }
//                                 });
//                               }
//                               else {
//                                 Dialogs.onPressedCallNow(
//                                   context: context,
//                                   // title: Methods.getText(StringsManager.pleaseEnterYourDataToShowTheLawyerNumber).toCapitalized(),
//                                   account: widget.accountModel,
//                                 );
//                               }
//                             },
//                             text: Methods.getText(StringsManager.callNow).toTitleCase(),
//                             imageName: IconsManager.animatedPhone,
//                             imageColor: ColorsManager.lightPrimaryColor,
//                             imageSize: SizeManager.s25,
//                             buttonColor: ColorsManager.white,
//                             borderColor: ColorsManager.lightPrimaryColor,
//                             textColor: ColorsManager.lightPrimaryColor,
//                             width: double.infinity,
//                             height: SizeManager.s40,
//                           ),
//                         ),
//                         if(widget.accountModel.isBookingByAppointment && widget.accountModel.availablePeriods.isNotEmpty) const SizedBox(width: SizeManager.s20),
//                         if(widget.accountModel.isBookingByAppointment && widget.accountModel.availablePeriods.isNotEmpty) Expanded(
//                           child: CustomButton(
//                             buttonType: ButtonType.postImage,
//                             onPressed: () {
//                               if(MyProviders.authenticationProvider.currentUser == null) {
//                                 Dialogs.showBottomSheetConfirmation(
//                                   context: context,
//                                   message: Methods.getText(StringsManager.youMustLoginFirstToAccessTheService).toCapitalized(),
//                                 ).then((value) async {
//                                   if(value) {
//                                     Navigator.pushNamed(context, Routes.loginWithPhoneScreen);
//                                   }
//                                 });
//                               }
//                               else {
//                                 Dialogs.chooseAppointmentBooking(
//                                   context: context,
//                                   account: widget.accountModel,
//                                   // title: Methods.getText(StringsManager.bookAnAppointmentWithALawyer).toCapitalized(),
//                                   // targetId: widget.accountModel.lawyerId,
//                                   // textAr: 'حجز موعد مع المحامى ${widget.accountModel.name} فى الفترة',
//                                   // textEn: 'Booking an appointment with lawyer ${widget.accountModel.name}',
//                                   // transactionType: TransactionType.appointmentBookingWithLawyer,
//                                   // periodsIds: widget.accountModel.availablePeriods,
//                                 );
//                               }
//                             },
//                             text: Methods.getText(StringsManager.appointmentBooking).toTitleCase(),
//                             imageName: IconsManager.animatedAppointment,
//                             imageColor: ColorsManager.white,
//                             imageSize: SizeManager.s25,
//                             width: double.infinity,
//                             height: SizeManager.s40,
//                           ),
//                         ),
//                       ],
//                     ),
//                     // const SizedBox(height: SizeManager.s10),
//                     // if(widget.accountModel.isBookingByAppointment && widget.accountModel.availablePeriods.isNotEmpty) Center(
//                     //   child: Text(
//                     //     Methods.getText(StringsManager.pleaseAdhereToTheSpecifiedReservationDate).toCapitalized(),
//                     //     style: Theme.of(context).textTheme.bodySmall,
//                     //   ),
//                     // ),
//                     // const Divider(color: ColorsManager.grey),
//
//                     const SizedBox(height: SizeManager.s20),
//
//                     // photoGallery
//                     if(widget.accountModel.photoGallery.isNotEmpty) Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           Methods.getText(StringsManager.photoGallery).toTitleCase(),
//                           style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeightManager.semiBold),
//                         ),
//                         const SizedBox(height: SizeManager.s10),
//                         Wrap(
//                           spacing: SizeManager.s5,
//                           runSpacing: SizeManager.s5,
//                           children: List.generate(widget.accountModel.photoGallery.length, (index) {
//                             return ImageWidget(
//                               image: widget.accountModel.photoGallery[index],
//                               imageDirectory: ApiConstants.accountsGalleryDirectory,
//                               width: SizeManager.s100,
//                               height: SizeManager.s100,
//                               borderRadius: SizeManager.s10,
//                               isShowFullImageScreen: true,
//                             );
//                           }),
//                         ),
//                         const Divider(color: ColorsManager.grey),
//                       ],
//                     ),
//
//                     // Customers Reviews
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           Methods.getText(StringsManager.customersReviews).toTitleCase(),
//                           style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeightManager.semiBold),
//                         ),
//                         const SizedBox(height: SizeManager.s10),
//                         Center(
//                           child: Text(
//                             widget.accountModel.rating.toStringAsFixed(2).endsWith('0') ? widget.accountModel.rating.toStringAsFixed(1) : widget.accountModel.rating.toStringAsFixed(2),
//                             style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: SizeManager.s30, fontWeight: FontWeightManager.bold),
//                           ),
//                         ),
//                         const SizedBox(height: SizeManager.s10),
//                         Center(
//                           child: RatingBar(numberOfStars: widget.accountModel.rating),
//                         ),
//                         const SizedBox(height: SizeManager.s10),
//                         Center(
//                           child: Text(
//                             '${Methods.getText(StringsManager.overallRatingOf).toCapitalized()} ${widget.accountModel.numberOfUsersReviews} ${Methods.getText(StringsManager.user)}',
//                             style: Theme.of(context).textTheme.bodySmall,
//                           ),
//                         ),
//                         const SizedBox(height: SizeManager.s20),
//                         SizedBox(
//                           height: SizeManager.s70,
//                           child: Row(
//                             children: [
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     Methods.getText(StringsManager.excellent).toCapitalized(),
//                                     style: Theme.of(context).textTheme.displayLarge!.copyWith(color: ColorsManager.grey),
//                                   ),
//                                   Text(
//                                     Methods.getText(StringsManager.good).toCapitalized(),
//                                     style: Theme.of(context).textTheme.displayLarge!.copyWith(color: ColorsManager.grey),
//                                   ),
//                                   Text(
//                                     Methods.getText(StringsManager.lessThanExpected).toCapitalized(),
//                                     style: Theme.of(context).textTheme.displayLarge!.copyWith(color: ColorsManager.grey),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(width: SizeManager.s20),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     LayoutBuilder(
//                                       builder: (context, constraints) {
//                                         return Stack(
//                                           children: [
//                                             Container(
//                                               color: ColorsManager.grey300,
//                                               width: constraints.maxWidth * 1,
//                                               height: SizeManager.s10,
//                                             ),
//                                             Container(
//                                               color: ColorsManager.green,
//                                               width: constraints.maxWidth * (widget.accountModel.numberOfUsersReviews == 0 ? 0 : 0/widget.accountModel.numberOfUsersReviews),
//                                               // width: constraints.maxWidth * (widget.accountModel.numberOfUsersReviews == 0 ? 0 : excellent/widget.accountModel.numberOfUsersReviews),
//                                               height: SizeManager.s10,
//                                             ),
//                                           ],
//                                         );
//                                       },
//                                     ),
//                                     LayoutBuilder(
//                                       builder: (context, constraints) {
//                                         return Stack(
//                                           children: [
//                                             Container(
//                                               color: ColorsManager.grey300,
//                                               width: constraints.maxWidth * 1,
//                                               height: SizeManager.s10,
//                                             ),
//                                             Container(
//                                               color: ColorsManager.orange,
//                                               width: constraints.maxWidth * (widget.accountModel.numberOfUsersReviews == 0 ? 0 : 0/widget.accountModel.numberOfUsersReviews),
//                                               // width: constraints.maxWidth * (widget.accountModel.numberOfUsersReviews == 0 ? 0 : good/widget.accountModel.numberOfUsersReviews),
//                                               height: SizeManager.s10,
//                                             ),
//                                           ],
//                                         );
//                                       },
//                                     ),
//                                     LayoutBuilder(
//                                       builder: (context, constraints) {
//                                         return Stack(
//                                           children: [
//                                             Container(
//                                               color: ColorsManager.grey300,
//                                               width: constraints.maxWidth * 1,
//                                               height: SizeManager.s10,
//                                             ),
//                                             Container(
//                                               color: ColorsManager.red700,
//                                               width: constraints.maxWidth * (widget.accountModel.numberOfUsersReviews == 0 ? 0 : 0/widget.accountModel.numberOfUsersReviews),
//                                               // width: constraints.maxWidth * (widget.accountModel.numberOfUsersReviews == 0 ? 0 : lessThanExpected/widget.accountModel.numberOfUsersReviews),
//                                               height: SizeManager.s10,
//                                             ),
//                                           ],
//                                         );
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//
//                     // Review Button
//                     // if(isShowReviewButton()) Padding(
//                     //   padding: const EdgeInsets.all(SizeManager.s16),
//                     //   child: Selector<UserAccountProvider, UserAccountModel?>(
//                     //     selector: (context, provider) => provider.userAccount,
//                     //     builder: (context, userAccount, __) {
//                     //       int userReviewIndex = userAccount == null ? -1 : lawyersReviews.indexWhere((element) => element.userAccountId == userAccount.userAccountId);
//                     //
//                     //       if(userReviewIndex == -1 || userAccount == null) {
//                     //         return CustomButton(
//                     //           buttonType: ButtonType.text,
//                     //           onPressed: () async {
//                     //             if(userAccount == null) {
//                     //               Dialogs.showBottomSheetConfirmation(context: context, message: Methods.getText(StringsManager.youMustLoginFirstToAccessTheService).toCapitalized()).then((value) async {
//                     //                 if(value) {Navigator.pushNamed(context, Routes.signInWithPhoneNumberRoute);}
//                     //               });
//                     //             }
//                     //             else {
//                     //               Dialogs.sendReview(
//                     //                 context: context,
//                     //                 targetId: widget.accountModel.accountId,
//                     //                 title: '${Methods.getText(StringsManager.rate).toTitleCase()} ${widget.accountModel.fullName}',
//                     //                 selectTheFeaturesText: Methods.getText(StringsManager.selectTheFeaturesOfLawyer).toCapitalized(),
//                     //                 mainCategories: MainCategories.lawyers,
//                     //                 features: lawyersFeaturesProvider.lawyersFeatures,
//                     //               );
//                     //             }
//                     //           },
//                     //           text: '${Methods.getText(StringsManager.rate).toTitleCase()} ${widget.accountModel.fullName}',
//                     //           borderRadius: SizeManager.s10,
//                     //         );
//                     //       }
//                     //       else {
//                     //         LawyerReviewModel yourReview = lawyersReviews.firstWhere((element) => element.userAccountId == userAccount.userAccountId);
//                     //         return Container(
//                     //           width: double.infinity,
//                     //           padding: const EdgeInsets.all(SizeManager.s10),
//                     //           decoration: BoxDecoration(
//                     //             color: ColorsManager.grey100,
//                     //             borderRadius: BorderRadius.circular(SizeManager.s10),
//                     //             border: Border.all(color: ColorsManager.grey300),
//                     //           ),
//                     //           child: Column(
//                     //             crossAxisAlignment: CrossAxisAlignment.start,
//                     //             children: [
//                     //               Text(
//                     //                 Methods.getText(StringsManager.yourReview).toTitleCase(),
//                     //                 style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: SizeManager.s18, fontWeight: FontWeightManager.bold),
//                     //               ),
//                     //               const SizedBox(height: SizeManager.s10),
//                     //               Row(
//                     //                 children: [
//                     //                   RatingBar(numberOfStars: yourReview.rating),
//                     //                   const SizedBox(width: SizeManager.s5),
//                     //                   Text(
//                     //                     yourReview.rating.toString(),
//                     //                     style: Theme.of(context).textTheme.bodySmall,
//                     //                   ),
//                     //                   const Spacer(),
//                     //                   Text(
//                     //                     Methods.formatDate(context: context, milliseconds: yourReview.createdAt.millisecondsSinceEpoch),
//                     //                     style: Theme.of(context).textTheme.bodySmall,
//                     //                   ),
//                     //                 ],
//                     //               ),
//                     //               const SizedBox(height: SizeManager.s10),
//                     //               Text(
//                     //                 yourReview.comment,
//                     //                 style: Theme.of(context).textTheme.bodyMedium,
//                     //               ),
//                     //             ],
//                     //           ),
//                     //         );
//                     //       }
//                     //     },
//                     //   ),
//                     // ),
//
//                     // Reviews
//                     // ListView.builder(
//                     //   shrinkWrap: true,
//                     //   physics: const NeverScrollableScrollPhysics(),
//                     //   padding: const EdgeInsets.only(bottom: SizeManager.s16),
//                     //   itemBuilder: (context, index) => ReviewItem(lawyersReviews: lawyersReviews.toList(), index: index),
//                     //   itemCount: widget.accountModel.numberOfUsersReviews >= ConstantsManager.maxNumberToShowReviews ? ConstantsManager.maxNumberToShowReviews : widget.accountModel.numberOfUsersReviews,
//                     // ),
//                     if(widget.accountModel.numberOfUsersReviews > ConstantsManager.maxNumberToShowReviews) Padding(
//                       padding: const EdgeInsets.only(bottom: SizeManager.s16),
//                       child: Align(
//                         alignment: Alignment.center,
//                         child: TextButton(
//                           onPressed: () => Navigator.pushNamed(context, Routes.reviewsScreen),
//                           child: Text(
//                             Methods.getText(StringsManager.viewMoreReviews).toTitleCase(),
//                             style: Theme.of(context).textTheme.titleLarge,
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//
//     return Directionality(
//       textDirection: Methods.getDirection(),
//       child: Scaffold(
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(SizeManager.s16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // const PreviousButton(),
//                           const SizedBox(width: SizeManager.s20),
//                           Expanded(
//                             child: Text(
//                               '${Methods.getText(StringsManager.data).toTitleCase()} ${widget.accountModel.fullName}',
//                               style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: SizeManager.s25, fontWeight: FontWeightManager.black),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: SizeManager.s20),
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           ImageWidget(
//                             image: widget.accountModel.personalImage,
//                             imageDirectory: ApiConstants.accountsDirectory,
//                             defaultImage: ImagesManager.defaultAvatar,
//                             width: SizeManager.s100,
//                             height: SizeManager.s100,
//                             boxShape: BoxShape.circle,
//                             isShowFullImageScreen: true,
//                           ),
//                           Expanded(
//                             child: Container(
//                               padding: const EdgeInsets.all(SizeManager.s10),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Flexible(
//                                         child: Text(
//                                           widget.accountModel.fullName,
//                                           style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeightManager.bold),
//                                         ),
//                                       ),
//                                       if(widget.accountModel.isFeatured) ...[
//                                         const SizedBox(width: SizeManager.s5),
//                                         const Icon(Icons.verified, color: ColorsManager.lightPrimaryColor, size: 20),
//                                       ],
//                                     ],
//                                   ),
//                                   const SizedBox(height: SizeManager.s5),
//                                   if(widget.accountModel.jobTitle != null) ...[
//                                     Text(
//                                       widget.accountModel.jobTitle!,
//                                       style: Theme.of(context).textTheme.bodySmall,
//                                     ),
//                                     const SizedBox(height: SizeManager.s5),
//                                   ],
//                                   Row(
//                                     children: [
//                                       RatingBar(numberOfStars: widget.accountModel.rating, starSize: SizeManager.s12, padding: SizeManager.s1),
//                                       const SizedBox(width: SizeManager.s10),
//                                       Expanded(
//                                         child: Text(
//                                           '${Methods.getText(StringsManager.overallRatingOf).toCapitalized()} ${widget.accountModel.numberOfUsersReviews} ${Methods.getText(StringsManager.user)}',
//                                           style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsManager.grey),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(height: SizeManager.s10),
//                                   if(widget.accountModel.bio != null) ...[
//                                     ReadMoreText(
//                                       widget.accountModel.bio!,
//                                       trimMode: TrimMode.Line,
//                                       trimLines: 3,
//                                       trimCollapsedText: Methods.getText(StringsManager.showMore).toCapitalized(),
//                                       trimExpandedText: ' ${Methods.getText(StringsManager.showLess).toCapitalized()}',
//                                       style: Theme.of(context).textTheme.bodyMedium,
//                                       moreStyle: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeightManager.bold),
//                                       lessStyle: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeightManager.bold),
//                                     ),
//                                     const SizedBox(height: SizeManager.s20),
//                                   ],
//                                   Wrap(
//                                     spacing: SizeManager.s5,
//                                     runSpacing: SizeManager.s5,
//                                     children: List.generate(widget.accountModel.features.length, (index) {
//                                       return Container(
//                                         padding: const EdgeInsets.symmetric(vertical: SizeManager.s3, horizontal: SizeManager.s10),
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(SizeManager.s10),
//                                           border: Border.all(color: ColorsManager.lightSecondaryColor),
//                                         ),
//                                         child: Text(
//                                           widget.accountModel.features[index],
//                                           style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsManager.lightSecondaryColor, fontWeight: FontWeightManager.black),
//                                         ),
//                                       );
//                                     }),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const Divider(color: ColorsManager.grey),
//                       if(widget.accountModel.tasks.isNotEmpty) ...[
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Image.asset(IconsManager.clipboard, color: ColorsManager.lightPrimaryColor, width: SizeManager.s20, height: SizeManager.s20),
//                             const SizedBox(width: SizeManager.s10),
//                             Expanded(
//                               child: Wrap(
//                                 children: List.generate(widget.accountModel.tasks.length, (index) {
//                                   return Text(
//                                     '${widget.accountModel.tasks[index]} ${index == widget.accountModel.tasks.length-1 ? '' : '-'} ',
//                                     style: Theme.of(context).textTheme.bodyMedium,
//                                   );
//                                 }),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: SizeManager.s10),
//                       ],
//                       if(widget.accountModel.address != null) ...[
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Image.asset(IconsManager.map, color: ColorsManager.lightPrimaryColor, width: SizeManager.s20, height: SizeManager.s20),
//                             const SizedBox(width: SizeManager.s10),
//                             Expanded(
//                               child: Text(
//                                 widget.accountModel.address!,
//                                 style: Theme.of(context).textTheme.bodyMedium,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: SizeManager.s10),
//                       ],
//                       if(widget.accountModel.consultationPrice != null) ...[
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Image.asset(IconsManager.money, color: ColorsManager.lightPrimaryColor, width: SizeManager.s20, height: SizeManager.s20),
//                             const SizedBox(width: SizeManager.s10),
//                             Text(
//                                 '${Methods.getText(StringsManager.consultationPrice).toCapitalized()}: ${widget.accountModel.consultationPrice} ${Methods.getText(StringsManager.egp).toUpperCase()}',
//                                 style: Theme.of(context).textTheme.bodySmall
//                             ),
//                           ],
//                         ),
//                       ],
//                       const Divider(color: ColorsManager.grey),
//                       Text(
//                         Methods.getText(
//                           widget.accountModel.isBookingByAppointment && widget.accountModel.availablePeriods.isNotEmpty
//                               ? StringsManager.chooseYourConsultationAppointment
//                               : StringsManager.callNow,
//                         ).toTitleCase(),
//                         style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: SizeManager.s18, fontWeight: FontWeightManager.bold),
//                       ),
//                       const SizedBox(height: SizeManager.s10),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: CustomButton(
//                               buttonType: ButtonType.postImage,
//                               // onPressed: () {
//                               //   if(userAccountProvider.userAccount == null) {
//                               //     Dialogs.showBottomSheetConfirmation(context: context, message: Methods.getText(StringsManager.youMustLoginFirstToAccessTheService).toCapitalized()).then((value) async {
//                               //       if(value) {Navigator.pushNamed(context, Routes.signInWithPhoneNumberRoute);}
//                               //     });
//                               //   }
//                               //   else {
//                               //     Dialogs.onPressedCallNow(
//                               //       context: context,
//                               //       title: Methods.getText(StringsManager.pleaseEnterYourDataToShowTheLawyerNumber).toCapitalized(),
//                               //       targetId: widget.accountModel.lawyerId,
//                               //       textAr: 'تم طلب رقم هاتف المحامي ${widget.accountModel.name}',
//                               //       textEn: 'Lawyer ${widget.accountModel.name} phone number has been requested',
//                               //       transactionType: TransactionType.showLawyerNumber,
//                               //       targetNumberText: Methods.getText(StringsManager.lawyerNumber).toTitleCase(),
//                               //       model: widget.accountModel,
//                               //     );
//                               //   }
//                               // },
//                               text: Methods.getText(StringsManager.callNow).toTitleCase(),
//                               imageName: IconsManager.animatedPhone,
//                               imageColor: ColorsManager.lightPrimaryColor,
//                               imageSize: SizeManager.s25,
//                               buttonColor: ColorsManager.white,
//                               borderColor: ColorsManager.lightPrimaryColor,
//                               textColor: ColorsManager.lightPrimaryColor,
//                               height: SizeManager.s40,
//                               borderRadius: SizeManager.s10,
//                             ),
//                           ),
//                           if(widget.accountModel.isBookingByAppointment && widget.accountModel.availablePeriods.isNotEmpty) const SizedBox(width: SizeManager.s20),
//                           if(widget.accountModel.isBookingByAppointment && widget.accountModel.availablePeriods.isNotEmpty) Expanded(
//                             child: CustomButton(
//                               buttonType: ButtonType.postImage,
//                               // onPressed: () {
//                               //   if(userAccountProvider.userAccount == null) {
//                               //     Dialogs.showBottomSheetConfirmation(context: context, message: Methods.getText(StringsManager.youMustLoginFirstToAccessTheService).toCapitalized()).then((value) async {
//                               //       if(value) {Navigator.pushNamed(context, Routes.signInWithPhoneNumberRoute);}
//                               //     });
//                               //   }
//                               //   else {
//                               //     Dialogs.chooseAppointmentBooking(
//                               //       context: context,
//                               //       title: Methods.getText(StringsManager.bookAnAppointmentWithALawyer).toCapitalized(),
//                               //       targetId: widget.accountModel.lawyerId,
//                               //       textAr: 'حجز موعد مع المحامى ${widget.accountModel.name} فى الفترة',
//                               //       textEn: 'Booking an appointment with lawyer ${widget.accountModel.name}',
//                               //       transactionType: TransactionType.appointmentBookingWithLawyer,
//                               //       periodsIds: widget.accountModel.availablePeriods,
//                               //     );
//                               //   }
//                               // },
//                               text: Methods.getText(StringsManager.appointmentBooking).toTitleCase(),
//                               imageName: IconsManager.animatedAppointment,
//                               imageColor: ColorsManager.white,
//                               imageSize: SizeManager.s25,
//                               height: SizeManager.s40,
//                               borderRadius: SizeManager.s10,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: SizeManager.s10),
//                       if(widget.accountModel.isBookingByAppointment && widget.accountModel.availablePeriods.isNotEmpty) Center(
//                         child: Text(
//                           Methods.getText(StringsManager.pleaseAdhereToTheSpecifiedReservationDate).toCapitalized(),
//                           style: Theme.of(context).textTheme.bodySmall,
//                         ),
//                       ),
//                       const Divider(color: ColorsManager.grey),
//
//                       // photoGallery
//                       if(widget.accountModel.photoGallery.isNotEmpty) Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             Methods.getText(StringsManager.photoGallery).toTitleCase(),
//                             style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: SizeManager.s18, fontWeight: FontWeightManager.bold),
//                           ),
//                           const SizedBox(height: SizeManager.s10),
//                           Wrap(
//                             spacing: SizeManager.s5,
//                             runSpacing: SizeManager.s5,
//                             children: List.generate(widget.accountModel.photoGallery.length, (index) {
//                               return ImageWidget(
//                                 image: widget.accountModel.photoGallery[index],
//                                 imageDirectory: ApiConstants.accountsGalleryDirectory,
//                                 width: SizeManager.s100,
//                                 height: SizeManager.s100,
//                                 borderRadius: SizeManager.s10,
//                                 isShowFullImageScreen: true,
//                               );
//                             }),
//                           ),
//                           const Divider(color: ColorsManager.grey),
//                         ],
//                       ),
//
//                       // Customers Reviews
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             Methods.getText(StringsManager.customersReviews).toTitleCase(),
//                             style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: SizeManager.s18, fontWeight: FontWeightManager.bold),
//                           ),
//                           const SizedBox(height: SizeManager.s10),
//                           Center(
//                             child: Text(
//                               widget.accountModel.rating.toStringAsFixed(2).endsWith('0') ? widget.accountModel.rating.toStringAsFixed(1) : widget.accountModel.rating.toStringAsFixed(2),
//                               style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: SizeManager.s40, fontWeight: FontWeightManager.black),
//                             ),
//                           ),
//                           const SizedBox(height: SizeManager.s5),
//                           Center(
//                             child: RatingBar(numberOfStars: widget.accountModel.rating),
//                           ),
//                           const SizedBox(height: SizeManager.s5),
//                           Center(
//                             child: Text(
//                               '${Methods.getText(StringsManager.overallRatingOf).toCapitalized()} ${widget.accountModel.numberOfUsersReviews} ${Methods.getText(StringsManager.user)}',
//                               style: Theme.of(context).textTheme.bodySmall,
//                             ),
//                           ),
//                           const SizedBox(height: SizeManager.s10),
//                           SizedBox(
//                             height: SizeManager.s70,
//                             child: Row(
//                               children: [
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       Methods.getText(StringsManager.excellent).toCapitalized(),
//                                       style: Theme.of(context).textTheme.displayLarge!.copyWith(color: ColorsManager.grey),
//                                     ),
//                                     Text(
//                                       Methods.getText(StringsManager.good).toCapitalized(),
//                                       style: Theme.of(context).textTheme.displayLarge!.copyWith(color: ColorsManager.grey),
//                                     ),
//                                     Text(
//                                       Methods.getText(StringsManager.lessThanExpected).toCapitalized(),
//                                       style: Theme.of(context).textTheme.displayLarge!.copyWith(color: ColorsManager.grey),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(width: SizeManager.s20),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       LayoutBuilder(
//                                         builder: (context, constraints) {
//                                           return Stack(
//                                             children: [
//                                               Container(
//                                                 color: ColorsManager.grey300,
//                                                 width: constraints.maxWidth * 1,
//                                                 height: SizeManager.s10,
//                                               ),
//                                               Container(
//                                                 color: ColorsManager.green,
//                                                 width: constraints.maxWidth * (widget.accountModel.numberOfUsersReviews == 0 ? 0 : 0/widget.accountModel.numberOfUsersReviews),
//                                                 // width: constraints.maxWidth * (widget.accountModel.numberOfUsersReviews == 0 ? 0 : excellent/widget.accountModel.numberOfUsersReviews),
//                                                 height: SizeManager.s10,
//                                               ),
//                                             ],
//                                           );
//                                         },
//                                       ),
//                                       LayoutBuilder(
//                                         builder: (context, constraints) {
//                                           return Stack(
//                                             children: [
//                                               Container(
//                                                 color: ColorsManager.grey300,
//                                                 width: constraints.maxWidth * 1,
//                                                 height: SizeManager.s10,
//                                               ),
//                                               Container(
//                                                 color: ColorsManager.orange,
//                                                 width: constraints.maxWidth * (widget.accountModel.numberOfUsersReviews == 0 ? 0 : 0/widget.accountModel.numberOfUsersReviews),
//                                                 // width: constraints.maxWidth * (widget.accountModel.numberOfUsersReviews == 0 ? 0 : good/widget.accountModel.numberOfUsersReviews),
//                                                 height: SizeManager.s10,
//                                               ),
//                                             ],
//                                           );
//                                         },
//                                       ),
//                                       LayoutBuilder(
//                                         builder: (context, constraints) {
//                                           return Stack(
//                                             children: [
//                                               Container(
//                                                 color: ColorsManager.grey300,
//                                                 width: constraints.maxWidth * 1,
//                                                 height: SizeManager.s10,
//                                               ),
//                                               Container(
//                                                 color: ColorsManager.red700,
//                                                 width: constraints.maxWidth * (widget.accountModel.numberOfUsersReviews == 0 ? 0 : 0/widget.accountModel.numberOfUsersReviews),
//                                                 // width: constraints.maxWidth * (widget.accountModel.numberOfUsersReviews == 0 ? 0 : lessThanExpected/widget.accountModel.numberOfUsersReviews),
//                                                 height: SizeManager.s10,
//                                               ),
//                                             ],
//                                           );
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 // Review Button
//                 // if(isShowReviewButton()) Padding(
//                 //   padding: const EdgeInsets.all(SizeManager.s16),
//                 //   child: Selector<UserAccountProvider, UserAccountModel?>(
//                 //     selector: (context, provider) => provider.userAccount,
//                 //     builder: (context, userAccount, __) {
//                 //       int userReviewIndex = userAccount == null ? -1 : lawyersReviews.indexWhere((element) => element.userAccountId == userAccount.userAccountId);
//                 //
//                 //       if(userReviewIndex == -1 || userAccount == null) {
//                 //         return CustomButton(
//                 //           buttonType: ButtonType.text,
//                 //           onPressed: () async {
//                 //             if(userAccount == null) {
//                 //               Dialogs.showBottomSheetConfirmation(context: context, message: Methods.getText(StringsManager.youMustLoginFirstToAccessTheService).toCapitalized()).then((value) async {
//                 //                 if(value) {Navigator.pushNamed(context, Routes.signInWithPhoneNumberRoute);}
//                 //               });
//                 //             }
//                 //             else {
//                 //               Dialogs.sendReview(
//                 //                 context: context,
//                 //                 targetId: widget.accountModel.accountId,
//                 //                 title: '${Methods.getText(StringsManager.rate).toTitleCase()} ${widget.accountModel.fullName}',
//                 //                 selectTheFeaturesText: Methods.getText(StringsManager.selectTheFeaturesOfLawyer).toCapitalized(),
//                 //                 mainCategories: MainCategories.lawyers,
//                 //                 features: lawyersFeaturesProvider.lawyersFeatures,
//                 //               );
//                 //             }
//                 //           },
//                 //           text: '${Methods.getText(StringsManager.rate).toTitleCase()} ${widget.accountModel.fullName}',
//                 //           borderRadius: SizeManager.s10,
//                 //         );
//                 //       }
//                 //       else {
//                 //         LawyerReviewModel yourReview = lawyersReviews.firstWhere((element) => element.userAccountId == userAccount.userAccountId);
//                 //         return Container(
//                 //           width: double.infinity,
//                 //           padding: const EdgeInsets.all(SizeManager.s10),
//                 //           decoration: BoxDecoration(
//                 //             color: ColorsManager.grey100,
//                 //             borderRadius: BorderRadius.circular(SizeManager.s10),
//                 //             border: Border.all(color: ColorsManager.grey300),
//                 //           ),
//                 //           child: Column(
//                 //             crossAxisAlignment: CrossAxisAlignment.start,
//                 //             children: [
//                 //               Text(
//                 //                 Methods.getText(StringsManager.yourReview).toTitleCase(),
//                 //                 style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: SizeManager.s18, fontWeight: FontWeightManager.bold),
//                 //               ),
//                 //               const SizedBox(height: SizeManager.s10),
//                 //               Row(
//                 //                 children: [
//                 //                   RatingBar(numberOfStars: yourReview.rating),
//                 //                   const SizedBox(width: SizeManager.s5),
//                 //                   Text(
//                 //                     yourReview.rating.toString(),
//                 //                     style: Theme.of(context).textTheme.bodySmall,
//                 //                   ),
//                 //                   const Spacer(),
//                 //                   Text(
//                 //                     Methods.formatDate(context: context, milliseconds: yourReview.createdAt.millisecondsSinceEpoch),
//                 //                     style: Theme.of(context).textTheme.bodySmall,
//                 //                   ),
//                 //                 ],
//                 //               ),
//                 //               const SizedBox(height: SizeManager.s10),
//                 //               Text(
//                 //                 yourReview.comment,
//                 //                 style: Theme.of(context).textTheme.bodyMedium,
//                 //               ),
//                 //             ],
//                 //           ),
//                 //         );
//                 //       }
//                 //     },
//                 //   ),
//                 // ),
//
//                 // Reviews
//                 // ListView.builder(
//                 //   shrinkWrap: true,
//                 //   physics: const NeverScrollableScrollPhysics(),
//                 //   padding: const EdgeInsets.only(bottom: SizeManager.s16),
//                 //   itemBuilder: (context, index) => ReviewItem(lawyersReviews: lawyersReviews.toList(), index: index),
//                 //   itemCount: widget.accountModel.numberOfUsersReviews >= ConstantsManager.maxNumberToShowReviews ? ConstantsManager.maxNumberToShowReviews : widget.accountModel.numberOfUsersReviews,
//                 // ),
//                 if(widget.accountModel.numberOfUsersReviews > ConstantsManager.maxNumberToShowReviews) Padding(
//                   padding: const EdgeInsets.only(bottom: SizeManager.s16),
//                   child: Align(
//                     alignment: Alignment.center,
//                     child: TextButton(
//                       onPressed: () => Navigator.pushNamed(context, Routes.reviewsScreen),
//                       child: Text(
//                         Methods.getText(StringsManager.viewMoreReviews).toTitleCase(),
//                         style: Theme.of(context).textTheme.titleLarge,
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }






class AccountDetailsScreen extends StatefulWidget {
  const AccountDetailsScreen({super.key});

  @override
  State<AccountDetailsScreen> createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
  late AccountDetailsProvider accountDetailsProvider;

  @override
  void initState() {
    super.initState();
    accountDetailsProvider = Provider.of<AccountDetailsProvider>(context, listen: false);
    accountDetailsProvider.addListenerScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await accountDetailsProvider.fetchData());
  }

  void _onInsert(ReviewModel? review) {
    if(review != null) {
      accountDetailsProvider.insertInReviews(review);
      if(accountDetailsProvider.paginationModel != null) accountDetailsProvider.paginationModel!.total++;
    }
  }

  void _onEdit(ReviewModel? review) {
    if(review != null) {
      accountDetailsProvider.editInReviews(review);
    }
  }

  void _onDelete(int reviewId) {
    accountDetailsProvider.deleteReview(context: context, reviewId: reviewId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountDetailsProvider>(
      builder: (context, provider, _) {
        return TemplateListScreen(
          isShowLoading: provider.isLoading,
          waitForDone: provider.isLoading,
          isShowOpacityBackground: true,
          reFetchData: () async => await provider.reFetchData(),
          scrollController: provider.scrollController,
          goToInsertScreen: null,
          screenTitle: StringsManager.theData,
          isDataNotEmpty: provider.reviews.isNotEmpty,
          dataCount: provider.reviews.length,
          totalResults: provider.paginationModel == null ? 0 : provider.paginationModel!.total,
          supportedViewStyle: const [ViewStyle.list],
          currentViewStyle: provider.viewStyle,
          changeViewStyleToList: () => provider.changeViewStyle(ViewStyle.list),
          changeViewStyleToGrid: () => provider.changeViewStyle(ViewStyle.grid),
          listItemBuilder: (context, index) => ReviewListItem(
            reviewModel: provider.reviews[index],
            index: index,
            onEdit: (review) => _onEdit(review),
            onDelete: () => _onDelete(provider.reviews[index].reviewId),
          ),
          gridItemBuilder: null,
          dataState: provider.dataState,
          hasMore: provider.hasMore,
          noDataMsgInScreen: StringsManager.thereAreNoReviews,
          extraWidget: ExtraWidgetInTop(accountModel: provider.accountModel),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    accountDetailsProvider.setIsScreenDisposed(true);
    accountDetailsProvider.scrollController.dispose();
  }
}

// class AddReviewWidget extends StatefulWidget {
//
//   const AddReviewWidget({super.key});
//
//   @override
//   State<AddReviewWidget> createState() => _AddReviewWidgetState();
// }
//
// class _AddReviewWidgetState extends State<AddReviewWidget> {
//   late AccountDetailsProvider accountDetailsProvider;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _reviewController = TextEditingController();
//   bool _isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     accountDetailsProvider = Provider.of<AccountDetailsProvider>(context, listen: false);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if(MyProviders.authenticationProvider.currentUser == null) {
//       return const SizedBox();
//     }
//
//     return Padding(
//       padding: const EdgeInsets.all(SizeManager.s16),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             CustomTextFormField(
//               controller: _reviewController,
//               keyboardType: TextInputType.multiline,
//               textInputAction: TextInputAction.newline,
//               maxLines: 5,
//               borderRadius: SizeManager.s20,
//               fillColor: ColorsManager.grey1,
//               labelText: Methods.getText(StringsManager.writeYourReviewHere).toTitleCase(),
//               validator: Validator.validateEmpty,
//             ),
//             const SizedBox(height: SizeManager.s10),
//             CustomButton(
//               onPressed: () async {
//                 FocusScope.of(context).unfocus();
//                 if(_formKey.currentState!.validate()) {
//                   setState(() => _isLoading = true);
//                   InsertReviewParameters parameters = InsertReviewParameters(
//                     accountId: accountDetailsProvider.accountModel.accountId,
//                     userId: MyProviders.authenticationProvider.currentUser!.userId,
//                     comment: _reviewController.text.trim(),
//                     rating: 0,
//                     featuresAr: [],
//                     featuresEn: [],
//                     createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
//                   );
//                   await DependencyInjection.insertReviewUseCase.call(parameters).then((response) {
//                     response.fold((failure) {}, (review) {
//                       accountDetailsProvider.insertInReviews(review);
//                       _reviewController.clear();
//                     });
//                   });
//                   setState(() => _isLoading = false);
//                 }
//               },
//               buttonType: ButtonType.text,
//               isLoading: _isLoading,
//               text: Methods.getText(StringsManager.send).toCapitalized(),
//               width: double.infinity,
//               height: SizeManager.s35,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _reviewController.dispose();
//     super.dispose();
//   }
// }