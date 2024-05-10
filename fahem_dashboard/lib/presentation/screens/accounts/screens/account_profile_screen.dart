import 'package:fahem_dashboard/core/resources/assets_manager.dart';
import 'package:fahem_dashboard/core/resources/colors_manager.dart';
import 'package:fahem_dashboard/core/resources/routes_manager.dart';
import 'package:fahem_dashboard/core/utilities/my_providers.dart';
import 'package:fahem_dashboard/data/models/account_model.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/default_sliver_app_bar.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/hover.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/name_widget.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/statistic_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fahem_dashboard/core/network/api_constants.dart';
import 'package:fahem_dashboard/core/resources/fonts_manager.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/enums.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/card_info.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_full_loading.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/image_widget.dart';

class AccountProfileScreen extends StatelessWidget {
  final AccountModel accountModel;

  const AccountProfileScreen({
    super.key,
    required this.accountModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomFullLoading(
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            DefaultSliverAppBar(customTitle: accountModel.fullName),
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
                          image: accountModel.coverImage,
                          imageDirectory: ApiConstants.accountsDirectory,
                          color1: accountModel.coverImage == null ? ColorsManager.white : null,
                          width: double.infinity,
                          height: SizeManager.s200,
                          isShowFullImageScreen: true,
                        ),
                        Align(
                          alignment: AlignmentDirectional.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: SizeManager.s16),
                            child: ImageWidget(
                              image: accountModel.personalImage,
                              imageDirectory: ApiConstants.accountsDirectory,
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
                    fullName: accountModel.fullName,
                    isFeatured: accountModel.isFeatured,
                    isSupportFeatured: true,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeightManager.semiBold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: SizeManager.s20),

                  // Statistics
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Hover(
                            onTap: () => Methods.routeTo(
                              context,
                              Routes.reviewsScreen,
                              arguments: ReviewsArgs(account: accountModel),
                            ),
                            padding: EdgeInsets.zero,
                            child: StatisticItem(
                              title: Methods.getText(StringsManager.reviews).toTitleCase(),
                              number: accountModel.numberOfReviews.toDouble(),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                        ),
                        const SizedBox(width: SizeManager.s10),
                        Expanded(
                          child: Hover(
                            onTap: () => Methods.routeTo(
                              context,
                              Routes.jobsScreen,
                              arguments: JobsArgs(account: accountModel),
                            ),
                            padding: EdgeInsets.zero,
                            child: StatisticItem(
                              title: Methods.getText(StringsManager.jobs).toTitleCase(),
                              number: accountModel.numberOfJobs.toDouble(),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                        ),
                        const SizedBox(width: SizeManager.s10),
                        Expanded(
                          child: Hover(
                            onTap: () => Methods.routeTo(
                              context,
                              Routes.employmentApplicationsScreen,
                              arguments: EmploymentApplicationsArgs(account: accountModel),
                            ),
                            padding: EdgeInsets.zero,
                            child: StatisticItem(
                              title: Methods.getText(StringsManager.employmentApplications).toTitleCase(),
                              number: accountModel.numberOfEmploymentApplications.toDouble(),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: SizeManager.s10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Hover(
                            onTap: () => Methods.routeTo(
                              context,
                              Routes.instantConsultationsCommentsScreen,
                              arguments: InstantConsultationsCommentsArgs(account: accountModel),
                            ),
                            padding: EdgeInsets.zero,
                            child: StatisticItem(
                              title: Methods.getText(StringsManager.instantConsultationsComments).toTitleCase(),
                              number: accountModel.numberOfInstantConsultationsComments.toDouble(),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                        ),
                        const SizedBox(width: SizeManager.s10),
                        Expanded(
                          child: Hover(
                            onTap: () => Methods.routeTo(
                              context,
                              Routes.phoneNumberRequestsScreen,
                              arguments: PhoneNumberRequestsArgs(account: accountModel),
                            ),
                            padding: EdgeInsets.zero,
                            child: StatisticItem(
                              title: Methods.getText(StringsManager.phoneNumberRequests).toTitleCase(),
                              number: accountModel.numberOfPhoneNumberRequests.toDouble(),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                        ),
                        const SizedBox(width: SizeManager.s10),
                        Expanded(
                          child: Hover(
                            onTap: () => Methods.routeTo(
                              context,
                              Routes.bookingAppointmentsScreen,
                              arguments: BookingAppointmentsArgs(account: accountModel),
                            ),
                            padding: EdgeInsets.zero,
                            child: StatisticItem(
                              title: Methods.getText(StringsManager.bookingAppointments).toTitleCase(),
                              number: accountModel.numberOfBookingAppointments.toDouble(),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: SizeManager.s20),

                  // Info
                  Padding(
                    padding: const EdgeInsets.only(left: SizeManager.s16, right: SizeManager.s16, bottom: SizeManager.s16),
                    child: Column(
                      children: [
                        CardInfo(
                          icon: FontAwesomeIcons.envelope,
                          title: Methods.getText(StringsManager.emailAddress).toTitleCase(),
                          value: accountModel.emailAddress,
                        ),
                        const SizedBox(height: SizeManager.s10),
                        if(accountModel.governorate != null) ...[
                          CardInfo(
                            icon: FontAwesomeIcons.locationDot,
                            title: Methods.getText(StringsManager.governorate).toTitleCase(),
                            value: MyProviders.appProvider.isEnglish ? accountModel.governorate!.governorateNameEn : accountModel.governorate!.governorateNameAr,
                          ),
                          const SizedBox(height: SizeManager.s10),
                        ],
                        if(accountModel.address != null) ...[
                          CardInfo(
                            icon: FontAwesomeIcons.locationDot,
                            title: Methods.getText(StringsManager.address).toTitleCase(),
                            value: accountModel.address,
                          ),
                          const SizedBox(height: SizeManager.s10),
                        ],
                        if(accountModel.phoneNumber != null) ...[
                          CardInfo(
                            icon: FontAwesomeIcons.phone,
                            title: Methods.getText(StringsManager.phoneNumber).toTitleCase(),
                            value: accountModel.phoneNumber,
                            spacerImage: FlagsImagesManager.egyptFlag,
                          ),
                          const SizedBox(height: SizeManager.s10),
                        ],
                        if(accountModel.birthDate != null) ...[
                          CardInfo(
                            icon: FontAwesomeIcons.calendar,
                            title: Methods.getText(StringsManager.birthDate).toTitleCase(),
                            value: Methods.formatDate(milliseconds: int.parse(accountModel.birthDate!), format: 'd MMMM yyyy'),
                          ),
                          const SizedBox(height: SizeManager.s10),
                        ],
                        if(accountModel.gender != null) ...[
                          CardInfo(
                            icon: FontAwesomeIcons.venusMars,
                            title: Methods.getText(StringsManager.gender).toTitleCase(),
                            value: Gender.toText(accountModel.gender!),
                          ),
                          const SizedBox(height: SizeManager.s10),
                        ],
                        if(accountModel.jobTitle != null) ...[
                          CardInfo(
                            icon: FontAwesomeIcons.briefcase,
                            title: Methods.getText(StringsManager.jobTitle).toTitleCase(),
                            value: accountModel.jobTitle,
                          ),
                          const SizedBox(height: SizeManager.s10),
                        ],
                        if(accountModel.categories.isNotEmpty) ...[
                          CardInfo(
                            icon: FontAwesomeIcons.layerGroup,
                            title: Methods.getText(StringsManager.categories).toTitleCase(),
                            value: accountModel.categories.map((e) => MyProviders.appProvider.isEnglish ? e.nameEn : e.nameAr).toList().join(' - '),
                          ),
                          const SizedBox(height: SizeManager.s10),
                        ],
                        if (accountModel.services.isNotEmpty) ...[
                          CardInfo(
                            icon: FontAwesomeIcons.layerGroup,
                            title: Methods.getText(StringsManager.fahemServices).toTitleCase(),
                            value: accountModel.services.map((e) => MyProviders.appProvider.isEnglish ? e.nameEn : e.nameAr).toList().join(' - '),
                          ),
                          const SizedBox(height: SizeManager.s10),
                        ],
                        if(accountModel.consultationPrice != null) ...[
                          CardInfo(
                            icon: FontAwesomeIcons.coins,
                            title: Methods.getText(StringsManager.consultationPrice).toTitleCase(),
                            value: '${accountModel.consultationPrice} ${Methods.getText(StringsManager.egp).toTitleCase()}',
                          ),
                          const SizedBox(height: SizeManager.s10),
                        ],
                        if(accountModel.tasks.isNotEmpty) ...[
                          CardInfo(
                            icon: Icons.task_alt,
                            title: Methods.getText(StringsManager.tasks).toTitleCase(),
                            value: accountModel.tasks.map((e) => e).toList().join(' - '),
                          ),
                          const SizedBox(height: SizeManager.s10),
                        ],
                        if(accountModel.features.isNotEmpty) ...[
                          CardInfo(
                            icon: FontAwesomeIcons.circleCheck,
                            title: Methods.getText(StringsManager.features).toTitleCase(),
                            value: accountModel.features.map((e) => e).toList().join(' - '),
                          ),
                          const SizedBox(height: SizeManager.s10),
                        ],
                        CardInfo(
                          icon: FontAwesomeIcons.coins,
                          title: Methods.getText(StringsManager.accountBalance).toTitleCase(),
                          value: '${accountModel.balance} ${Methods.getText(StringsManager.egp).toTitleCase()}',
                        ),
                        const SizedBox(height: SizeManager.s10),
                        CardInfo(
                          icon: FontAwesomeIcons.gear,
                          title: Methods.getText(StringsManager.accountStatus).toTitleCase(),
                          value: AccountStatus.toText(accountModel.accountStatus),
                        ),
                        const SizedBox(height: SizeManager.s10),
                        if(accountModel.reasonOfReject != null) ...[
                          CardInfo(
                            icon: FontAwesomeIcons.squareXmark,
                            title: Methods.getText(StringsManager.reasonOfReject).toTitleCase(),
                            value: accountModel.reasonOfReject,
                          ),
                          const SizedBox(height: SizeManager.s10),
                        ],
                        if(accountModel.appointmentBooking.isNotEmpty) ...[
                          CardInfo(
                            icon: FontAwesomeIcons.clock,
                            title: Methods.getText(StringsManager.bookingPeriods).toTitleCase(),
                            value: accountModel.appointmentBooking.map((e) => MyProviders.appProvider.isEnglish ? e.nameEn : e.nameAr).toList().join(' - '),
                          ),
                          const SizedBox(height: SizeManager.s10),
                        ],
                        CardInfo(
                          icon: FontAwesomeIcons.userCheck,
                          title: Methods.getText(StringsManager.theAccountIsVerified).toTitleCase(),
                          value: Methods.getText(accountModel.isFeatured ? StringsManager.yes : StringsManager.no).toCapitalized(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Methods.getText(accountModel.isFeatured ? StringsManager.yes : StringsManager.no).toCapitalized(),
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(height: SizeManager.s1_8),
                              ),
                              const SizedBox(width: SizeManager.s10),
                              Icon(
                                accountModel.isFeatured ? Icons.check_circle : FontAwesomeIcons.xmark,
                                color: accountModel.isFeatured ? ColorsManager.green : ColorsManager.red,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: SizeManager.s10),
                        CardInfo(
                          icon: FontAwesomeIcons.calendar,
                          title: Methods.getText(StringsManager.joinDate).toTitleCase(),
                          value: Methods.formatDate(milliseconds: int.parse(accountModel.createdAt), format: 'd MMMM yyyy'),
                        ),
                        const SizedBox(height: SizeManager.s10),
                        if(accountModel.bio != null) ...[
                          CardInfo(
                            icon: FontAwesomeIcons.info,
                            title: Methods.getText(StringsManager.bio).toTitleCase(),
                            value: accountModel.bio,
                          ),
                          const SizedBox(height: SizeManager.s10),
                        ],
                        if(accountModel.photoGallery.isNotEmpty) ...[
                          CardInfo(
                            icon: FontAwesomeIcons.images,
                            title: Methods.getText(StringsManager.photoGallery).toTitleCase(),
                            child: Wrap(
                              spacing: SizeManager.s10,
                              runSpacing: SizeManager.s10,
                              children: List.generate(accountModel.photoGallery.length, (index) => ImageWidget(
                                image: accountModel.photoGallery[index],
                                imageDirectory: ApiConstants.accountsGalleryDirectory,
                                width: SizeManager.s70,
                                height: SizeManager.s70,
                                borderRadius: SizeManager.s10,
                                isShowFullImageScreen: true,
                              )),
                            ),
                          ),
                          const SizedBox(height: SizeManager.s10),
                        ],
                        if(accountModel.identificationImages.isNotEmpty) ...[
                          CardInfo(
                            icon: FontAwesomeIcons.images,
                            title: Methods.getText(StringsManager.proofOfIdentity).toTitleCase(),
                            child: Wrap(
                              spacing: SizeManager.s10,
                              runSpacing: SizeManager.s10,
                              children: List.generate(accountModel.identificationImages.length, (index) => ImageWidget(
                                image: accountModel.identificationImages[index],
                                imageDirectory: ApiConstants.accountsIdentificationDirectory,
                                width: SizeManager.s70,
                                height: SizeManager.s70,
                                borderRadius: SizeManager.s10,
                                isShowFullImageScreen: true,
                              )),
                            ),
                          ),
                          const SizedBox(height: SizeManager.s10),
                        ],
                        if(accountModel.nationalId != null) ...[
                          CardInfo(
                            icon: FontAwesomeIcons.idCard,
                            title: Methods.getText(StringsManager.nationalId).toTitleCase(),
                            value: accountModel.nationalId,
                          ),
                          const SizedBox(height: SizeManager.s10),
                        ],
                        if(accountModel.nationalImageFrontSide != null) ...[
                          CardInfo(
                            icon: FontAwesomeIcons.idCard,
                            title: Methods.getText(StringsManager.nationalImage).toTitleCase(),
                            child: ImageWidget(
                              image: accountModel.nationalImageFrontSide,
                              imageDirectory: ApiConstants.accountsIdentificationDirectory,
                              width: double.infinity,
                              height: SizeManager.s120,
                              borderRadius: SizeManager.s10,
                              isShowFullImageScreen: true,
                            ),
                          ),
                          const SizedBox(height: SizeManager.s10),
                        ],
                        if(accountModel.nationalImageBackSide != null) ...[
                          CardInfo(
                            icon: FontAwesomeIcons.idCard,
                            title: Methods.getText(StringsManager.nationalImage).toTitleCase(),
                            child: ImageWidget(
                              image: accountModel.nationalImageBackSide,
                              imageDirectory: ApiConstants.accountsIdentificationDirectory,
                              width: double.infinity,
                              height: SizeManager.s120,
                              borderRadius: SizeManager.s10,
                              isShowFullImageScreen: true,
                            ),
                          ),
                          const SizedBox(height: SizeManager.s10),
                        ],
                        if(accountModel.cardNumber != null) ...[
                          CardInfo(
                            icon: FontAwesomeIcons.idCardClip,
                            title: Methods.getText(StringsManager.cardNumber).toTitleCase(),
                            value: accountModel.cardNumber,
                          ),
                          const SizedBox(height: SizeManager.s10),
                        ],
                        if(accountModel.cardImage != null) ...[
                          CardInfo(
                            icon: FontAwesomeIcons.idCardClip,
                            title: Methods.getText(StringsManager.cardImage).toTitleCase(),
                            child: ImageWidget(
                              image: accountModel.cardImage,
                              imageDirectory: ApiConstants.accountsIdentificationDirectory,
                              width: double.infinity,
                              height: SizeManager.s120,
                              borderRadius: SizeManager.s10,
                              isShowFullImageScreen: true,
                            ),
                          ),
                          const SizedBox(height: SizeManager.s10),
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