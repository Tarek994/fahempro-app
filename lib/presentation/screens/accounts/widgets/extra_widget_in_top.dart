import 'package:fahem/core/network/api_constants.dart';
import 'package:fahem/core/resources/assets_manager.dart';
import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/constants_manager.dart';
import 'package:fahem/core/resources/fonts_manager.dart';
import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/dialogs.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:fahem/data/models/account_model.dart';
import 'package:fahem/domain/usecases/reviews/insert_review_usecase.dart';
import 'package:fahem/presentation/screens/accounts/controllers/account_details_provider.dart';
import 'package:fahem/presentation/screens/accounts/screens/account_details_screen.dart';
import 'package:fahem/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem/presentation/shared/widgets/image_widget.dart';
import 'package:fahem/presentation/shared/widgets/name_widget.dart';
import 'package:fahem/presentation/shared/widgets/rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class ExtraWidgetInTop extends StatefulWidget {
  final AccountModel accountModel;
  
  const ExtraWidgetInTop({
    super.key,
    required this.accountModel,
  });

  @override
  State<ExtraWidgetInTop> createState() => _ExtraWidgetInTopState();
}

class _ExtraWidgetInTopState extends State<ExtraWidgetInTop> {
  late AccountDetailsProvider accountDetailsProvider;

  @override
  void initState() {
    super.initState();
    accountDetailsProvider = Provider.of<AccountDetailsProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: SizeManager.s16, left: SizeManager.s16, right: SizeManager.s16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageWidget(
                image: widget.accountModel.personalImage,
                imageDirectory: ApiConstants.accountsDirectory,
                defaultImage: ImagesManager.defaultAvatar,
                width: SizeManager.s100,
                height: SizeManager.s100,
                boxShape: BoxShape.circle,
                isShowFullImageScreen: true,
              ),
              const SizedBox(width: SizeManager.s10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: SizeManager.s10),
                    NameWidget(
                      fullName: widget.accountModel.fullName,
                      isFeatured: widget.accountModel.isFeatured,
                      isSupportFeatured: true,
                      verifiedColor: ColorsManager.blue,
                    ),
                    const SizedBox(height: SizeManager.s10),
                    if(widget.accountModel.jobTitle != null) ...[
                      Text(
                        widget.accountModel.jobTitle!,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: SizeManager.s10),
                    ],
                    Row(
                      children: [
                        RatingBar(numberOfStars: widget.accountModel.rating, starSize: SizeManager.s12, padding: SizeManager.s1),
                        const SizedBox(width: SizeManager.s10),
                        Expanded(
                          child: Text(
                            '${Methods.getText(StringsManager.overallRatingOf).toCapitalized()} ${Methods.getWordStatusLabel(num: widget.accountModel.numberOfReviews, label: WordStatusLabel.user)}',
                            style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsManager.grey),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: SizeManager.s10),
                    if(widget.accountModel.bio != null) ...[
                      ReadMoreText(
                        widget.accountModel.bio!,
                        trimMode: TrimMode.Line,
                        trimLines: 3,
                        trimCollapsedText: Methods.getText(StringsManager.showMore).toCapitalized(),
                        trimExpandedText: ' ${Methods.getText(StringsManager.showLess).toCapitalized()}',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: SizeManager.s1_8),
                        moreStyle: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeightManager.bold),
                        lessStyle: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeightManager.bold),
                      ),
                      const SizedBox(height: SizeManager.s20),
                    ],
                    Wrap(
                      spacing: SizeManager.s5,
                      runSpacing: SizeManager.s5,
                      children: List.generate(widget.accountModel.features.length, (index) {
                        return Container(
                          padding: const EdgeInsets.all(SizeManager.s5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(SizeManager.s5),
                            border: Border.all(color: ColorsManager.lightSecondaryColor),
                          ),
                          child: Text(
                            widget.accountModel.features[index],
                            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                              fontSize: SizeManager.s10,
                              color: ColorsManager.lightSecondaryColor,
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(color: ColorsManager.grey),
          if(widget.accountModel.tasks.isNotEmpty) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(IconsManager.clipboard, color: ColorsManager.lightPrimaryColor, width: SizeManager.s20, height: SizeManager.s20),
                const SizedBox(width: SizeManager.s10),
                Expanded(
                  child: Wrap(
                    children: List.generate(widget.accountModel.tasks.length, (index) {
                      return Text(
                        '${widget.accountModel.tasks[index]} ${index == widget.accountModel.tasks.length-1 ? '' : '-'} ',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: SizeManager.s1_8),
                      );
                    }),
                  ),
                ),
              ],
            ),
            const SizedBox(height: SizeManager.s10),
          ],
          if(widget.accountModel.address != null) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(IconsManager.map, color: ColorsManager.lightPrimaryColor, width: SizeManager.s20, height: SizeManager.s20),
                const SizedBox(width: SizeManager.s10),
                Expanded(
                  child: Text(
                    widget.accountModel.address!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: SizeManager.s10),
          ],
          if(widget.accountModel.consultationPrice != null) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(IconsManager.money, color: ColorsManager.lightPrimaryColor, width: SizeManager.s20, height: SizeManager.s20),
                const SizedBox(width: SizeManager.s10),
                Text(
                  '${Methods.getText(StringsManager.consultationPrice).toCapitalized()}: ${widget.accountModel.consultationPrice} ${Methods.getText(StringsManager.egp).toUpperCase()}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
          const Divider(color: ColorsManager.grey),
          Text(
            Methods.getText(
              widget.accountModel.isBookingByAppointment && widget.accountModel.availablePeriods.isNotEmpty
                  ? StringsManager.chooseYourConsultationAppointment
                  : StringsManager.callNow,
            ).toTitleCase(),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeightManager.semiBold),
          ),
          const SizedBox(height: SizeManager.s10),
          Row(
            children: [
              if(widget.accountModel.phoneNumber != null) Expanded(
                child: CustomButton(
                  buttonType: ButtonType.postImage,
                  onPressed: () {
                    if(MyProviders.authenticationProvider.currentUser == null) {
                      Dialogs.showBottomSheetConfirmation(
                        context: context,
                        message: Methods.getText(StringsManager.youMustLoginFirstToAccessTheService).toCapitalized(),
                      ).then((value) async {
                        if(value) {
                          Navigator.pushNamed(context, Routes.loginWithPhoneScreen);
                        }
                      });
                    }
                    else {
                      Dialogs.onPressedCallNow(
                        context: context,
                        // title: Methods.getText(StringsManager.pleaseEnterYourDataToShowTheLawyerNumber).toCapitalized(),
                        account: widget.accountModel,
                      );
                    }
                  },
                  text: Methods.getText(StringsManager.callNow).toTitleCase(),
                  imageName: IconsManager.animatedPhone,
                  imageColor: ColorsManager.lightPrimaryColor,
                  imageSize: SizeManager.s25,
                  buttonColor: ColorsManager.white,
                  borderColor: ColorsManager.lightPrimaryColor,
                  textColor: ColorsManager.lightPrimaryColor,
                  width: double.infinity,
                  height: SizeManager.s40,
                ),
              ),
              if(widget.accountModel.isBookingByAppointment && widget.accountModel.availablePeriods.isNotEmpty) const SizedBox(width: SizeManager.s20),
              if(widget.accountModel.isBookingByAppointment && widget.accountModel.availablePeriods.isNotEmpty) Expanded(
                child: CustomButton(
                  buttonType: ButtonType.postImage,
                  onPressed: () {
                    if(MyProviders.authenticationProvider.currentUser == null) {
                      Dialogs.showBottomSheetConfirmation(
                        context: context,
                        message: Methods.getText(StringsManager.youMustLoginFirstToAccessTheService).toCapitalized(),
                      ).then((value) async {
                        if(value) {
                          Navigator.pushNamed(context, Routes.loginWithPhoneScreen);
                        }
                      });
                    }
                    else {
                      Dialogs.chooseAppointmentBooking(
                        context: context,
                        account: widget.accountModel,
                        // title: Methods.getText(StringsManager.bookAnAppointmentWithALawyer).toCapitalized(),
                        // targetId: accountModel.lawyerId,
                        // textAr: 'حجز موعد مع المحامى ${accountModel.name} فى الفترة',
                        // textEn: 'Booking an appointment with lawyer ${accountModel.name}',
                        // transactionType: TransactionType.appointmentBookingWithLawyer,
                        // periodsIds: accountModel.availablePeriods,
                      );
                    }
                  },
                  text: Methods.getText(StringsManager.appointmentBooking).toTitleCase(),
                  imageName: IconsManager.animatedAppointment,
                  imageColor: ColorsManager.white,
                  imageSize: SizeManager.s25,
                  width: double.infinity,
                  height: SizeManager.s40,
                ),
              ),
            ],
          ),
          // const SizedBox(height: SizeManager.s10),
          // if(accountModel.isBookingByAppointment && accountModel.availablePeriods.isNotEmpty) Center(
          //   child: Text(
          //     Methods.getText(StringsManager.pleaseAdhereToTheSpecifiedReservationDate).toCapitalized(),
          //     style: Theme.of(context).textTheme.bodySmall,
          //   ),
          // ),
          // const Divider(color: ColorsManager.grey),

          const SizedBox(height: SizeManager.s20),

          // photoGallery
          if(widget.accountModel.photoGallery.isNotEmpty) Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Methods.getText(StringsManager.photoGallery).toTitleCase(),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeightManager.semiBold),
              ),
              const SizedBox(height: SizeManager.s10),
              Wrap(
                spacing: SizeManager.s5,
                runSpacing: SizeManager.s5,
                children: List.generate(widget.accountModel.photoGallery.length, (index) {
                  return ImageWidget(
                    image: widget.accountModel.photoGallery[index],
                    imageDirectory: ApiConstants.accountsGalleryDirectory,
                    width: SizeManager.s100,
                    height: SizeManager.s100,
                    borderRadius: SizeManager.s10,
                    isShowFullImageScreen: true,
                  );
                }),
              ),
              const Divider(color: ColorsManager.grey),
            ],
          ),

          // Customers Reviews
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Methods.getText(StringsManager.customersReviews).toTitleCase(),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeightManager.semiBold),
              ),
              const SizedBox(height: SizeManager.s10),
              Center(
                child: Text(
                  widget.accountModel.rating.toStringAsFixed(2).endsWith('0') ? widget.accountModel.rating.toStringAsFixed(1) : widget.accountModel.rating.toStringAsFixed(2),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: SizeManager.s30, fontWeight: FontWeightManager.bold),
                ),
              ),
              const SizedBox(height: SizeManager.s10),
              Center(
                child: RatingBar(numberOfStars: widget.accountModel.rating),
              ),
              const SizedBox(height: SizeManager.s10),
              Center(
                child: Text(
                  '${Methods.getText(StringsManager.overallRatingOf).toCapitalized()} ${Methods.getWordStatusLabel(num: widget.accountModel.numberOfReviews, label: WordStatusLabel.user)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              const SizedBox(height: SizeManager.s20),
              SizedBox(
                height: SizeManager.s70,
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Methods.getText(StringsManager.excellent).toCapitalized(),
                          style: Theme.of(context).textTheme.displayLarge!.copyWith(color: ColorsManager.grey),
                        ),
                        Text(
                          Methods.getText(StringsManager.good).toCapitalized(),
                          style: Theme.of(context).textTheme.displayLarge!.copyWith(color: ColorsManager.grey),
                        ),
                        Text(
                          Methods.getText(StringsManager.lessThanExpected).toCapitalized(),
                          style: Theme.of(context).textTheme.displayLarge!.copyWith(color: ColorsManager.grey),
                        ),
                      ],
                    ),
                    const SizedBox(width: SizeManager.s20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LayoutBuilder(
                            builder: (context, constraints) {
                              return Stack(
                                children: [
                                  Container(
                                    color: ColorsManager.grey300,
                                    width: constraints.maxWidth * 1,
                                    height: SizeManager.s10,
                                  ),
                                  Container(
                                    color: ColorsManager.green,
                                    width: constraints.maxWidth * (widget.accountModel.numberOfReviews == 0 ? 0 : widget.accountModel.numberOfReviewsExcellent/widget.accountModel.numberOfReviews),
                                    height: SizeManager.s10,
                                  ),
                                ],
                              );
                            },
                          ),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              print(widget.accountModel.numberOfReviewsExcellent);
                              return Stack(
                                children: [
                                  Container(
                                    color: ColorsManager.grey300,
                                    width: constraints.maxWidth * 1,
                                    height: SizeManager.s10,
                                  ),
                                  Container(
                                    color: ColorsManager.orange,
                                    width: constraints.maxWidth * (widget.accountModel.numberOfReviews == 0 ? 0 : widget.accountModel.numberOfReviewsGood/widget.accountModel.numberOfReviews),
                                    height: SizeManager.s10,
                                  ),
                                ],
                              );
                            },
                          ),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              return Stack(
                                children: [
                                  Container(
                                    color: ColorsManager.grey300,
                                    width: constraints.maxWidth * 1,
                                    height: SizeManager.s10,
                                  ),
                                  Container(
                                    color: ColorsManager.red700,
                                    width: constraints.maxWidth * (widget.accountModel.numberOfReviews == 0 ? 0 : widget.accountModel.numberOfReviewsLessThanExpected/widget.accountModel.numberOfReviews),
                                    height: SizeManager.s10,
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: SizeManager.s20),

          CustomButton(
            onPressed: () {
              Dialogs.getUserReview(
                context: context,
              ).then((value) {
                if(!value.contains(null)) {
                  InsertReviewParameters parameters = InsertReviewParameters(
                    accountId: accountDetailsProvider.accountModel.accountId,
                    userId: MyProviders.authenticationProvider.currentUser!.userId,
                    comment: value[0],
                    rating: value[1],
                    featuresAr: [],
                    featuresEn: [],
                    createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                  );
                  accountDetailsProvider.insertReview(context: context, insertReviewParameters: parameters);
                }
              });
            },
            buttonType: ButtonType.text,
            text: Methods.getText(StringsManager.rateTheAccountNow).toCapitalized(),
            width: double.infinity,
            height: SizeManager.s35,
          ),
          // AddReviewWidget(),

          // Review Button
          // if(isShowReviewButton()) Padding(
          //   padding: const EdgeInsets.all(SizeManager.s16),
          //   child: Selector<UserAccountProvider, UserAccountModel?>(
          //     selector: (context, provider) => provider.userAccount,
          //     builder: (context, userAccount, __) {
          //       int userReviewIndex = userAccount == null ? -1 : lawyersReviews.indexWhere((element) => element.userAccountId == userAccount.userAccountId);
          //
          //       if(userReviewIndex == -1 || userAccount == null) {
          //         return CustomButton(
          //           buttonType: ButtonType.text,
          //           onPressed: () async {
          //             if(userAccount == null) {
          //               Dialogs.showBottomSheetConfirmation(context: context, message: Methods.getText(StringsManager.youMustLoginFirstToAccessTheService).toCapitalized()).then((value) async {
          //                 if(value) {Navigator.pushNamed(context, Routes.signInWithPhoneNumberRoute);}
          //               });
          //             }
          //             else {
          //               Dialogs.sendReview(
          //                 context: context,
          //                 targetId: accountModel.accountId,
          //                 title: '${Methods.getText(StringsManager.rate).toTitleCase()} ${accountModel.fullName}',
          //                 selectTheFeaturesText: Methods.getText(StringsManager.selectTheFeaturesOfLawyer).toCapitalized(),
          //                 mainCategories: MainCategories.lawyers,
          //                 features: lawyersFeaturesProvider.lawyersFeatures,
          //               );
          //             }
          //           },
          //           text: '${Methods.getText(StringsManager.rate).toTitleCase()} ${accountModel.fullName}',
          //           borderRadius: SizeManager.s10,
          //         );
          //       }
          //       else {
          //         LawyerReviewModel yourReview = lawyersReviews.firstWhere((element) => element.userAccountId == userAccount.userAccountId);
          //         return Container(
          //           width: double.infinity,
          //           padding: const EdgeInsets.all(SizeManager.s10),
          //           decoration: BoxDecoration(
          //             color: ColorsManager.grey100,
          //             borderRadius: BorderRadius.circular(SizeManager.s10),
          //             border: Border.all(color: ColorsManager.grey300),
          //           ),
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(
          //                 Methods.getText(StringsManager.yourReview).toTitleCase(),
          //                 style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: SizeManager.s18, fontWeight: FontWeightManager.bold),
          //               ),
          //               const SizedBox(height: SizeManager.s10),
          //               Row(
          //                 children: [
          //                   RatingBar(numberOfStars: yourReview.rating),
          //                   const SizedBox(width: SizeManager.s5),
          //                   Text(
          //                     yourReview.rating.toString(),
          //                     style: Theme.of(context).textTheme.bodySmall,
          //                   ),
          //                   const Spacer(),
          //                   Text(
          //                     Methods.formatDate(context: context, milliseconds: yourReview.createdAt.millisecondsSinceEpoch),
          //                     style: Theme.of(context).textTheme.bodySmall,
          //                   ),
          //                 ],
          //               ),
          //               const SizedBox(height: SizeManager.s10),
          //               Text(
          //                 yourReview.comment,
          //                 style: Theme.of(context).textTheme.bodyMedium,
          //               ),
          //             ],
          //           ),
          //         );
          //       }
          //     },
          //   ),
          // ),

          // Reviews
          // ListView.builder(
          //   shrinkWrap: true,
          //   physics: const NeverScrollableScrollPhysics(),
          //   padding: const EdgeInsets.only(bottom: SizeManager.s16),
          //   itemBuilder: (context, index) => ReviewItem(lawyersReviews: lawyersReviews.toList(), index: index),
          //   itemCount: accountModel.numberOfReviews >= ConstantsManager.maxNumberToShowReviews ? ConstantsManager.maxNumberToShowReviews : accountModel.numberOfReviews,
          // ),
          // if(accountModel.numberOfReviews > ConstantsManager.maxNumberToShowReviews) Padding(
          //   padding: const EdgeInsets.only(bottom: SizeManager.s16),
          //   child: Align(
          //     alignment: Alignment.center,
          //     child: TextButton(
          //       onPressed: () => Navigator.pushNamed(context, Routes.reviewsScreen),
          //       child: Text(
          //         Methods.getText(StringsManager.viewMoreReviews).toTitleCase(),
          //         style: Theme.of(context).textTheme.titleLarge,
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
